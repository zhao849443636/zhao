//
//  ZQW_AppTools.h
//  XiaoBao_Paper
//
//  Created by dllo on 15/9/28.
//  Copyright (c) 2015年 赵庆文. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AppToolBlock)(id result);
typedef void(^ToolBlock)(id result1);

@interface ZQW_AppTools : NSObject
+(void)getMessage:(NSString *)string Block:(AppToolBlock)block and:(ToolBlock)block1;
@end
