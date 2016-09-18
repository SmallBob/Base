//
//  TestNetOperation.m
//  Base
//
//  Created by 王凯 on 16/3/14.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import "TestNetOperation.h"

@implementation TestNetOperation

-(NSString *)URL
{
    return @"http://center.xiaomatuofu.com/readingQuestion/readingList.action";
}


-(NSDictionary *)requestPara
{
   
    
    NSMutableDictionary*params = [NSMutableDictionary dictionary ];
    [params setObject:@"1.2" forKey:@"version"];
    [params setObject:@"1" forKey:@"newVersion"];
    [params setObject:@"730" forKey:@"ios_version"];
    
    return params;

}

//- (WKNetOperationMethod)method {
//    return WKNetOperationMethodGet;
//}
//
-(NSTimeInterval)timeoutInterval
{
    
    return 10;
}
@end
