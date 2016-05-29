//
//  ViewController.m
//  XYNetworkStatus
//
//  Created by lixinyu on 16/5/29.
//  Copyright © 2016年 xiaoyu. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

//使用cocoaPods管理，在https://github.com/tonymillion/Reachability下载

@interface ViewController ()

@property (nonatomic, strong) Reachability *reachablityManager;
@end

@implementation ViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 停止监听网络状态
    [self.reachablityManager stopNotifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(networkStatusChanged) name:kReachabilityChangedNotification object:nil];
    [self.reachablityManager startNotifier];
}

/**
 *  网络状态改变的回调方法
 */
- (void)networkStatusChanged {
    // 获得当前的网络状态
    NetworkStatus status = [self.reachablityManager currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            NSLog(@"没有可用网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
            break;
        case ReachableViaWWAN:
            NSLog(@"3G/4G");
            break;
    }
}
//懒加载
- (Reachability *)reachablityManager {
    if (_reachablityManager == nil) {
        // 公司服务器域名
        _reachablityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    }
    return _reachablityManager;
}
@end
