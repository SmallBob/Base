//
//  WKRequest.h
//  Base
//
//  Created by 王凯 on 16/3/11.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccessBlock)(id result,NSError *error);
typedef void (^RequestFailBlock)(id result,NSError*error);
typedef void (^RequestBodyBlock)(id<AFMultipartFormData> formData);
@interface WKRequest : AFHTTPSessionManager



+(WKRequest*)shareInstance;
-(void)GetUrl:(NSString*)url
  RequestPara:(NSDictionary*)para
RequestSuccess:(RequestSuccessBlock)successCallBack
  RequestFail:(RequestFailBlock)failCallBack;
-(void)PostUrl:(NSString*)url
   RequestPara:(NSDictionary*)para
RequestSuccess:(RequestSuccessBlock)successCallBack
   RequestFail:(RequestFailBlock)failCallBack;
- (void)PostUrl:(NSString *)url
    RequestPara:(NSDictionary *)para
           Body:(RequestBodyBlock)bodyBlock
 RequestSuccess:(RequestSuccessBlock)successCallBack
    RequestFail:(RequestFailBlock)failCallBack;
- (void)AFNetworkStatus;


@end
