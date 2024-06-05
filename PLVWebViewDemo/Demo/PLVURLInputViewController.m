//
//  PLVViewController.m
//  WebView-Test
//
//  Created by ftao on 27/04/2018.
//  Copyright © 2018 PLV. All rights reserved.
//

#import "PLVURLInputViewController.h"
#import "PLVWebViewSingleDemoViewController.h"
#import <PLVWebViewSDK/PLVWebViewSDK.h>
#import <AVFoundation/AVFoundation.h>

static NSString *kTestUrlString = @"";

@interface PLVURLInputViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, copy) NSString * _Nullable customUserAgent;
@property (weak, nonatomic) IBOutlet UITextView *urlTextView;
@property (weak, nonatomic) IBOutlet UITextView *uaTextView;

@property (nonatomic, strong) AVCaptureSession *session; //捕获会话任务
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer; //相机图像层
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput; //设备输入
@property (nonatomic, strong) AVCaptureMetadataOutput *dataOutput; //数据输出
@property (nonatomic, strong) UIButton *closeScanButton; //关闭扫描按钮

@end

@implementation PLVURLInputViewController

#pragma mark - Lift cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置域名白名单
    [[PLVUAConfigManager sharedManager] addHostWhitelist:@[@"demo.polyv.net"]];

    self.urlTextView.text = @"";
    self.uaTextView.text = [PLVUAConfigManager sharedManager].defaultUserAgent;
    
    [self.view addSubview:self.closeScanButton];
}

#pragma mark - [ Override ]

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [PLVFloatWindowManager sharedManager].supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
}

#pragma mark - [ Private Method ]

- (void)closeScanQRCode {
    self.closeScanButton.hidden = YES;
    //停止会话
    [self.session stopRunning];
    //移除显示扫描层
    [self.preLayer removeFromSuperlayer];
}

- (void)pushViewControllerWithURLString:(NSString *)urlString {
    PLVWebViewConfig *config = [[PLVWebViewConfig alloc] init];
    config.urlString = urlString;
    config.allowFloatingWindow = YES;
    config.isSystemFloatingWindow = NO;
    config.userAgent = self.uaTextView.text;
    config.enableAutoFloatWindow = YES;
    
    PLVWebViewSingleDemoViewController *floatingWebVC = [[PLVWebViewSingleDemoViewController alloc] initWithConfig:config];
    [self.navigationController pushViewController:floatingWebVC animated:YES];
}

#pragma mark Getter & Setter

- (UIButton *)closeScanButton {
    if (!_closeScanButton) {
        _closeScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeScanButton.hidden = YES;
        _closeScanButton.backgroundColor = [UIColor lightGrayColor];
        _closeScanButton.frame = CGRectMake(40, self.view.bounds.size.height - 70, self.view.bounds.size.width - 80, 40);
        [_closeScanButton setTitle:@"关闭扫描" forState:UIControlStateNormal];
        [_closeScanButton addTarget:self action:@selector(clickScanBottonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeScanButton;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        //将输入设备关联到会话
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        //输出对象关联到会话
        if ([_session canAddOutput:self.dataOutput]){
            [_session addOutput:self.dataOutput];
            //设置元数据类型，是QR二维码
            self.dataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        }
    }
    return _session;
}

- (AVCaptureDeviceInput *)deviceInput {
    if (!_deviceInput) {
        NSError *error;
        // 创建一个普通设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 根据普通设备创建一个输入设备
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    }
    return _deviceInput;
}

- (AVCaptureMetadataOutput *)dataOutput{
    if (!_dataOutput) {
        _dataOutput = [[AVCaptureMetadataOutput alloc]init];
        //设置代理，得到解析结果
        [_dataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _dataOutput;
}

- (AVCaptureVideoPreviewLayer *)preLayer{
    if (!_preLayer) {
        //创建一个特殊的层
        _preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        //设置尺寸并添加到视图树
        _preLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    }
    return _preLayer;
}

#pragma mark - [ Event ]

#pragma mark - Action

-(IBAction)clickOpenWebViewAction:(id)sender {
    [self.view endEditing:YES];
        
    NSString *urlString = self.urlTextView.text;
    if (urlString && [urlString isKindOfClass:NSString.class] && urlString.length > 0) {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self pushViewControllerWithURLString:urlString];
    }
}

- (IBAction)clickScanQRCodeAction:(UIButton *)sender {
    [self.view.layer addSublayer:self.preLayer];
    self.closeScanButton.hidden = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.session startRunning];
    });
}

- (IBAction)clickResetUAAction:(UIButton *)sender {
    self.customUserAgent = nil;
    self.uaTextView.text = [PLVUAConfigManager sharedManager].defaultUserAgent;
}

- (IBAction)clickChangeUAAction:(UIButton *)sender {
    NSString *uaText = self.uaTextView.text;
    if (uaText && [uaText isKindOfClass:NSString.class] && uaText.length > 0) {
        self.customUserAgent = [uaText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
}

- (void)clickScanBottonAction:(UIButton *)sender {
    [self closeScanQRCode];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - [ Delegate ]

#pragma mark AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self closeScanQRCode];
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects firstObject];
        NSString *scanQRCodeString = object.stringValue;
        NSLog(@"%@",object.stringValue);
        if (scanQRCodeString) {
            [self pushViewControllerWithURLString:scanQRCodeString];
        }
    }
}

@end
