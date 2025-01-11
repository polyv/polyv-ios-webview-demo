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


- (void)showPageWebViewInParentViewWithURLString:(NSString *)urlString {
    // 可重写自行实现打开新页面
    [super showPageWebViewInParentViewWithURLString:urlString];
    /*
    self.newPageWebView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.5, CGRectGetHeight(self.view.bounds) * 0.5);
    [self.view addSubview:self.newPageWebView];
    // 使用 newPageWebView 打开新的 url 链接，并把 newPageWebView 移动到屏幕上
    if ([PLVWVFdUtil checkStringUseable:urlString]) {
        urlString = [PLVWVFdUtil URLEncodedString:urlString];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.newPageWebView loadRequest:request];
    }
     */
}

- (void)closePageWebView {
    // 可重写自行实现移除当前页面
    [super closePageWebView];
    /*
    [self.newPageWebView removeFromSuperview];
     */
}

#pragma mark - [ Delegate ]
#pragma mark PLVFloatableWebViewBridgeDelegate
/// 如需要监听 js 回调事件，可以通过Delegate事件进行相应的处理，例如webviewBridgeShare消息
//- (void)webviewBridgeShare:(PLVFloatableWebViewBridge *)bridge {
//
//}

@end
