//
//  KCToastView.h
//
//
//  Created by Frank on 16/1/15.
//  Copyright © 2016年 Kakao China. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  简单的toast view
 */
@interface FZToastView : UIView

/**
 *  显示提示信息
 *
 *  @param msg 信息
 */
+ (void)showMessage:(NSString *)msg;

@end
