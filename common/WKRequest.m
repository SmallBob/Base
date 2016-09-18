//
//  WKRequest.m
//  Base
//
//  Created by 王凯 on 16/3/11.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import "WKRequest.h"

static const CGFloat KTimeoutInterval = 20;

@implementation WKRequest

+(WKRequest *)shareInstance
{
    static WKRequest*request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc]init];
        request.requestSerializer.timeoutInterval = KTimeoutInterval;
        request.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
//                                                                diskCapacity:10 * 1024 * 1024
//                                                                    diskPath:nil];
//            
//        [NSURLCache setSharedURLCache:sharedCache];
//        
//        [request.reachabilityManager startMonitoring];
        
    });
    return request;

}

-(void)GetUrl:(NSString*)url
  RequestPara:(NSDictionary*)para
RequestSuccess:(RequestSuccessBlock)successCallBack
  RequestFail:(RequestFailBlock)failCallBack{
    
    [self.requestSerializer setValue:@"xiaoma" forHTTPHeaderField:@"token"];
    
    [self GET:url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCallBack(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failCallBack(nil,error);
        
    }];

}


-(void)PostUrl:(NSString*)url
   RequestPara:(NSDictionary*)para
RequestSuccess:(RequestSuccessBlock)successCallBack
   RequestFail:(RequestFailBlock)failCallBack{
    
    [self POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCallBack(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failCallBack(nil,error);
    }];

}

//文件上传
- (void)PostUrl:(NSString *)url
    RequestPara:(NSDictionary *)para
           Body:(RequestBodyBlock)bodyBlock
 RequestSuccess:(RequestSuccessBlock)successCallBack
    RequestFail:(RequestFailBlock)failCallBack {
    
    [self POST:url parameters:para constructingBodyWithBlock:bodyBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successCallBack(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failCallBack(nil,error);
    }];
}


- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        NSString*message = nil;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                message = @"未知网络状态";
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                message = @"无网络";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                message = @"蜂窝数据网";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                message = @"WiFi网络";
                
                break;
                
            default:
                break;
        }
       // [self alertWithMessage:message];
        
    }] ;
    
    [manager startMonitoring];
    
    
}

-(void)alertWithMessage:(NSString*)message
{
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    
    
}

@end
