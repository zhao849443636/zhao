//
//  ZQW_AppTools.m
//  XiaoBao_Paper
//
//  Created by dllo on 15/9/28.
//  Copyright (c) 2015年 赵庆文. All rights reserved.
//

#import "ZQW_AppTools.h"
#import "AFNetworking.h"
@implementation ZQW_AppTools

+(void)getMessage:(NSString *)string Block:(AppToolBlock)block and:(ToolBlock)block1

{
    
    
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    //[NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];  代表支持所有的接口类型
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id result) {
        [netWorkManager stopMonitoring];
        //        //NSLog(@"%@",result);
        block(result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block1(error);
        
        
        
        
        //NSLog(@"失败==== %@",error);
        
    }];
    
    
    
    
    
    
}

@end
