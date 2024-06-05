//
//  PLVWebViewSingleDemoViewController.m
//  PLVWebViewDemo
//
//  Created by Sakya on 2023/11/28.
//  Copyright © 2023 easefun. All rights reserved.
//

#import "PLVWebViewSingleDemoViewController.h"

@interface PLVWebViewSingleDemoViewController ()

@end

@implementation PLVWebViewSingleDemoViewController

#pragma mark - [ Override ]

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/// 初始化时，可以进行的自定义配置
//- (void)initHandleForDemo {
//
//}

#pragma mark - [ Delegate ]
#pragma mark PLVFloatableWebViewBridgeDelegate
/// 如需要监听 js 回调事件，可以通过Delegate事件进行相应的处理，例如webviewBridgeShare消息
//- (void)webviewBridgeShare:(PLVFloatableWebViewBridge *)bridge {
//
//}

@end
