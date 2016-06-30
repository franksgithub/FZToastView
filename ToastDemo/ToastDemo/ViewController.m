//
//  ViewController.m
//  ToastDemo
//
//  Created by Frank on 16/6/30.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "ViewController.h"
#import "FZToastView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showToast:(id)sender {
    [FZToastView showMessage:@"hello, this is FZToastView demo!!!! "];
}

@end
