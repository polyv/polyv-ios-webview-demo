source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitee.com/polyv_ef/plvspecs.git'

platform :ios, '11.0'
use_frameworks!

target 'PLVWebViewDemo' do
  
  # Feed
  pod 'MJRefresh', '~> 3.5.0'
  
  pod 'PLVWebViewSDK', '~> 3.1.1'
  
#  包含系统画中画 -- 如果不使用系统小窗 则不需要下面配置
#  pod 'PLVAliHttpDNS', '~>1.10.0'
#  pod 'PLVFoundationSDK', '1.10.6', :subspecs => ['BaseUtils', 'NetworkUtils', 'ErrorCode', 'LogReporter', 'ConsoleLogger', 'Reachability', 'SafeModel', 'ProgressHUD']
#  pod 'PLVBusinessSDK', '1.10.4', :subspecs => ['BaseBSH']
#  pod 'PLVLiveScenesSDK', '1.10.6', :subspecs => ['Base', 'LogReporter', 'ConsoleLogger', 'ErrorManager', 'Network', 'Player', 'BasePlayer', 'LivePlayer', 'LivePlaybackPlayer', 'PictureInPicture']
  
end 

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            # 支持模拟器
            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
         end
    end
  end
end
