//
//  PLVWebViewFeedDemoViewController.m
//  PLVWebViewDemo
//
//  Created by Sakya on 2024/2/20.
//  Copyright © 2024 easefun. All rights reserved.
//

#import "PLVWebViewFeedDemoViewController.h"

@interface PLVWebViewFeedDemoViewController ()

@end

@implementation PLVWebViewFeedDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark PLVWebViewFeedDataManagerDelegate
- (void)feedDataManager:(PLVWebViewFeedDataManager *)feedDataManager loadMoreDataWithPage:(NSInteger)page completion:(void (^)(NSArray<PLVWebViewConfig *> * _Nullable, BOOL))completion failure:(void (^)(NSError * _Nonnull))failure {
//    NSMutableArray *configs = [NSMutableArray arrayWithCapacity:5];
//    PLVWebViewConfig *baseConfig = [[PLVWebViewConfig alloc] init];
//    baseConfig.allowFloatingWindow = YES;
//    baseConfig.userAgent = [PLVUAConfigManager sharedManager].defaultUserAgent;
//    baseConfig.enableAutoFloatWindow = YES;
//    baseConfig.urlString = @"https://live.polyv.cn/watch/3035966";
//    [configs addObject:baseConfig];
//    
//    PLVWebViewConfig *config = [baseConfig copy];
//    config.urlString = @"https://live.polyv.cn/watch/3035966";
//    [configs addObject:config];

    completion ? completion(nil, YES) : nil;
}

@end
