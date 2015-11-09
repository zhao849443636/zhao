//
//  ZQW_ScrollView.h
//  ZQW_RepeatPicture
//
//  Created by dllo on 15/10/31.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQWScrollViewDelegate <NSObject>

//轮播图点击事件方法
-(void)selectScrollView:(NSInteger)index;

@end

@interface ZQW_ScrollView : UIView

@property(nonatomic,assign)id<ZQWScrollViewDelegate>Delegate;



//图片网址数组
@property(nonatomic,strong)NSMutableArray *pictureArray;
//轮播图标题数组
@property(nonatomic,strong)NSArray *titleArray;
//占位图
@property(nonatomic,strong)UIImage *placeholder;
//Page选中颜色
@property(nonatomic,strong)UIColor *currentColor;
//Page全部颜色
@property(nonatomic,strong)UIColor *allColor;
//轮播图滚动时间
@property(nonatomic,assign)CGFloat autoScrollTimeInterval;



@end
