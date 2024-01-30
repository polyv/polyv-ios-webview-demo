# Q & A

## 1. 更换web-native通信规则注意事项

本项目中使用的是开源库 WebViewJavascriptBridge 来实现web 和 native之间的通信。如果接入的项目中没有用到web-native通信，则不需要做任何调整。如果接入的项目中也用到web-native通信，则可以参考下面的方式进行修改。

### 1.1 更换native端通信规则

 SDK中使用的 WebViewJavascriptBridge 来实现通信的，在 PLVFloatableWebViewBridge 中对其进行了封装处理，如果需要更换native端通信规则只需要修改  PLVFloatableWebViewBridge 这个类即可

1.1 更换注册消息方式:

```objective-c
- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler {
      //当使用的新的web-native规则时，可以将下面的代码修改为webview使用新规则注册消息时的代码
    [self.bridge registerHandler:handlerName handler:handler];
}
```

1.2更换发送web端消息

```objective-c
- (void)callHandler:(NSString*)handlerName data:(id _Nullable)data responseCallback:(WVJBResponseCallback _Nullable)responseCallback {
      //当使用的新的web-native规则时，可以将下面的代码修改为webview使用新规则发送消息时的代码
    [self.bridge callHandler:handlerName data:data responseCallback:responseCallback];
}
```



### 2.2 更换web端通信规则

当native端通信规则改变时，web端则要根据是否与原来的通信方式原理相同来判断是否需要修改。

2.1 当前web端注册消息方式

```javascript
bridge.registerHandler("testJavascriptHandler",
          function (data, responseCallback) {
            console.log(data);
            responseCallback(data);
          }
 );
```

2.2 当前web端发送消息方式

```javascript
bridge.callHandler("callAppEvent", { },
          function responseCallback(responseData) {
            console.log(responseData);
          }
);
```

当前web-native的通信是通过 bridge 这种方式来发送和接收消息的，如果需要调整可用集成项目web端接收、发送消息的方式来进行替换。



## 2. iOS 使用系统小窗功能

iOS因为系统限制想实现系统小窗只能通过画中画的功能，同时这个功能会有版本限制，在iOS14+开始支持iPhone的画中画功能。同时直播如果使用系统播放器 AVPlayer 会有14s+的高延迟，IJKPlayer可以实现低延迟，但是iOS15以上画中画才支持SampleBufferLayer，因此如果直播低延迟的话需要iOS15+。

- 回放视频系统小窗支持iOS14+
- 直播视频系统小窗支持iOS15+



## 3. 其它问题

 详见保利威帮助中心 [WebView常见问题](https://help.polyv.net/index.html#/vod/product/faq/webview_issue)  
