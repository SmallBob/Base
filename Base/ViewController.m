//
//  ViewController.m
//  Base
//
//  Created by 王凯 on 16/3/11.
//  Copyright © 2016年 kai wang. All rights reserved.
//

#import "ViewController.h"
#import "TestNetOperation.h"

//typedef void (^BackBlock)(void);

@interface ViewController ()
//@property(nonatomic,copy)BackBlock backBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testRequest];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)testRequest
{
    
    
    
    //__weak typeof(self) weakSelf = self;
    
    
    [TestNetOperation operationWithCallBack:^(NSDictionary *result, NSError *error) {
        
        NSLog(@"0000---%@",result);
        BaseLog(@"asdfasdf-%@",result);
        
        
    }];
    
}

-(void)testAlertController
{
    
    __weak typeof(self) weakSelf = self;
    WKRequest*request = [WKRequest shareInstance];
    
    [request.requestSerializer setValue:@"xiaoma" forHTTPHeaderField:@"token"];
    
    NSMutableDictionary*params = [NSMutableDictionary dictionary ];
    [params setObject:@"1.2" forKey:@"version"];
    [params setObject:@"1" forKey:@"newVersion"];
    [params setObject:@"730" forKey:@"ios_version"];
    [request.requestSerializer setValue:@"xiaoma" forHTTPHeaderField:@"token"];
    
    [request AFNetworkStatus];
    
    [request GetUrl:@"http://center.xiaomatuofu.com/readingQuestion/readingList.action" RequestPara:params RequestSuccess:^(id request, NSError *error) {
        NSLog(@"111");
        
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
            UITextField*textUser = alertController.textFields.firstObject;
            UITextField*textPass = alertController.textFields.lastObject;
            NSLog(@"user = %@, password = %@",textUser.text,textPass.text);
        }];
        
        UIAlertAction*cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
        }];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"用户名";
            textField.secureTextEntry = YES;
            
            
            
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"密码";
            textField.secureTextEntry = YES;
        }];
        
        
        
        [alertController addAction:cancleAction];
        [alertController addAction:action];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
        
    } RequestFail:^(id result, NSError *error) {
        NSLog(@"1112222");
        
    }];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
