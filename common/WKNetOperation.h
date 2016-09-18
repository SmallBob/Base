//
//  WKNetOperation.h
//  Base
//
//  Created by 王凯 on 16/3/14.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKRequest.h"


typedef void(^CallBack)(NSDictionary*result , NSError * error);

typedef NS_ENUM(NSUInteger,WKNetOperationMethod) {
    WKNetOperationMethodGet = 1,
    WKNetOperationMethodPost ,
    WKNetOperationMethodData,//文件传输数据

};

@class WKNetOperation;
@protocol WKNetOperationProtocol <NSObject>

@required

-(void)netOperationStarted:(WKNetOperation*)operation;
-(void)netOperationSuccess:(WKNetOperation*)operation result:(id)result;
-(void)netOperationFail:(WKNetOperation*)operation error:(NSError*)error;


@end

@interface WKNetOperation : NSObject

@property(nonatomic,strong)RequestBodyBlock bodyBlock;

@property(nonatomic,assign)id<WKNetOperationProtocol>delegate;

// 请求URL
- (NSString *)URL;

// 请求参数
- (NSDictionary *)requestPara;

// 请求参数
- (WKNetOperationMethod)method;

// 超时时间
- (NSTimeInterval)timeoutInterval;

/**
 *  开始请求
 */
- (void)startOperation;

/**
 *  请求block回调方法
 *
 *  @param callBack 请求回调
 */
+ (void)operationWithCallBack:(CallBack)callBack;

/**
 *  缓存block回调方法
 *
 *  @param callBack 缓存回调
 */
+ (void)operationCacheWithBlock:(CallBack)callBack;





@end
