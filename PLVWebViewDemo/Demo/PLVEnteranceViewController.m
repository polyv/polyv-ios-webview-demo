//
//  PLVEnteranceViewController.m
//  PLVWebViewDemo
//
//  Created by Sakya on 2024/2/19.
//  Copyright © 2024 easefun. All rights reserved.
//

#import "PLVEnteranceViewController.h"
#import "PLVWebViewFeedDemoViewController.h"

@interface PLVEnteranceViewController ()

@end

@implementation PLVEnteranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc] init];
        //添加背景色
        appperance.backgroundColor = [UIColor whiteColor];
        //设置字体颜色大小
        [appperance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.standardAppearance = appperance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appperance;
    }
    
    // 配置域名白名单
    [[PLVUAConfigManager sharedManager] addHostWhitelist:@[@"demo.polyv.net"]];
}

- (NSArray<PLVWebViewConfig *> *)webViewConfigs {
    NSArray *urlStrings = @[
    ];

    NSMutableArray *configs = [NSMutableArray arrayWithCapacity:urlStrings.count];
    PLVWebViewConfig *baseConfig = [[PLVWebViewConfig alloc] init];
    baseConfig.allowFloatingWindow = YES;
    baseConfig.userAgent = [PLVUAConfigManager sharedManager].defaultUserAgent;
    baseConfig.enableAutoFloatWindow = YES;

    for (NSInteger index = 0; index < urlStrings.count ; index ++) {
        PLVWebViewConfig *config = [baseConfig copy];
        config.urlString = urlStrings[index];
        [configs addObject:config];
    }
    return configs;
}

- (IBAction)feedAction:(UIButton *)sender {
    PLVWebViewFeedDemoViewController *feedVC = [[PLVWebViewFeedDemoViewController alloc] initWithConfigs:self.webViewConfigs];
    [self.navigationController pushViewController:feedVC animated:YES];
}

@end
