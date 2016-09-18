//
//  WKNetOperation.m
//  Base
//
//  Created by 王凯 on 16/3/14.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import "WKNetOperation.h"

@interface WKNetOperation()
@property(nonatomic,copy)CallBack callBack;

@end

@implementation WKNetOperation

+(void)operationWithCallBack:(CallBack)callBack
{
    WKNetOperation*op = [[[self class] alloc]init];
    op.callBack = callBack;
    [op startOperation];

}
+(void)operationCacheWithBlock:(CallBack)callBack
{
    [[PINCache sharedCache] objectForKey:NSStringFromClass([self class]) block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        if (object) {
            callBack(object,nil);
        }else{
            callBack(nil,nil);
        }
    }];
    
}

-(void)startOperation
{
    AFNetworkReachabilityManager*manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self operationMethod];
                break;
        }
    }];
    
    [manager startMonitoring];
}

- (void)operationMethod {
    switch ([self method]) {
        case WKNetOperationMethodGet:
            [self getRequest];
            break;
        case WKNetOperationMethodPost:
            [self postRequest];
            break;
        case WKNetOperationMethodData:
            [self postDataRequest];
            break;
    }
}

-(void)getRequest
{
    [[WKRequest shareInstance] GetUrl:[self URL] RequestPara:[self requestPara] RequestSuccess:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
    } RequestFail:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
    }];
}


-(void)postDataRequest{
    [[WKRequest shareInstance] PostUrl:[self URL] RequestPara:[self requestPara] Body:^(id<AFMultipartFormData> formData) {
        if (_bodyBlock) {
            _bodyBlock(formData);
        }
    } RequestSuccess:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
    } RequestFail:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
    }];
}

-(void)postRequest{
    [[WKRequest shareInstance] PostUrl:[self URL] RequestPara:[self requestPara] RequestSuccess:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
        
    } RequestFail:^(id result, NSError *error) {
        [self callBackRequest:result Error:error];
    }];

}


-(void)callBackRequest:(id)request Error:(NSError*)error{
    if (_delegate) {
        if (request && !error) {
            [_delegate netOperationSuccess:self result:request];
        }else if(error){
            [_delegate netOperationFail:self error:error];
        }
        
    }else if (_callBack){
        _callBack(request,error);
    }
    //缓存
    [self cache:request];
    
}

-(void)cache:(NSDictionary*)result
{
    [[PINCache sharedCache] setObject:result forKey:NSStringFromClass([self class]) block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        NSLog(@"------dic----cache:%@",(NSDictionary*)object);
    }];
    
    
}



#pragma mark - rewrite method
// 请求URL
- (NSString *)URL {
    return nil;
}

// 请求参数
- (NSDictionary *)requestPara {
    return nil;
}

// 请求参数
- (WKNetOperationMethod)method {
    return WKNetOperationMethodGet;
}

// 超时时间
- (NSTimeInterval)timeoutInterval {
    return 10;
}


















@end
