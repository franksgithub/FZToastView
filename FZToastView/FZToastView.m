//
//  KCToastView.m
//  5dsyClient
//
//  Created by Frank on 16/1/15.
//  Copyright © 2016年 Kakao China. All rights reserved.
//

#import "FZToastView.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static char kTipViewKey;
static const CGFloat kShowDuration = 0.2f;
static const CGFloat kHiddenDuration = 0.5f;

@interface FZToastView()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation FZToastView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 200, SCREEN_WIDTH - 40, 40)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0;
        self.layer.cornerRadius = 6;
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 10, 10)];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
    }
    return self;
}

+ (void)showMessage:(NSString *)msg
{
    UIWindow *keyWindow = AppKeyWindow();
    FZToastView *toastView = objc_getAssociatedObject(keyWindow, &kTipViewKey);
    if (toastView) {
        return;
    }
    toastView = [[self alloc] init];
    [keyWindow addSubview:toastView];
    objc_setAssociatedObject(keyWindow, &kTipViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    toastView.messageLabel.text = msg;
    [toastView.messageLabel sizeToFit];
    CGRect frame = toastView.frame;
    frame.size.height = CGRectGetHeight(toastView.messageLabel.frame) + 20;
    frame.size.width = CGRectGetWidth(toastView.messageLabel.frame) + 20;
    toastView.frame = frame;
    CGRect bounds = toastView.bounds;
    toastView.messageLabel.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    [keyWindow endEditing:YES];
    toastView.center = keyWindow.center;
    [UIView animateWithDuration:kShowDuration animations:^{
        toastView.alpha = 0.9;
    } completion:^(BOOL finished) {
        [toastView performSelector:@selector(hideToast) withObject:nil afterDelay:1.0];
    }];
}

- (void)hideToast
{
    [UIView animateWithDuration:kHiddenDuration animations:^{
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
            UIWindow *keyWindow = AppKeyWindow();
            objc_setAssociatedObject(keyWindow, &kTipViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }];
}

static inline UIWindow * AppKeyWindow() {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) {
        keyWindow = [UIApplication sharedApplication].windows[0];
    }
    return keyWindow;
}

@end
