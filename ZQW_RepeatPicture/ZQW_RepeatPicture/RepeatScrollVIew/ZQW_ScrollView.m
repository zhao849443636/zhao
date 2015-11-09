//
//  ZQW_ScrollView.m
//  ZQW_RepeatPicture
//
//  Created by dllo on 15/10/31.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "ZQW_ScrollView.h"
#import "UIImageView+WebCache.h"

#define ZQWWIDTH self.bounds.size.width

@interface ZQW_ScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,weak)NSTimer *time;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ZQW_ScrollView

-(void)setPictureArray:(NSMutableArray *)pictureArray
{
    
    _pictureArray = pictureArray;
        self.time=[NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(Action) userInfo:nil repeats:YES];
        self.index = 1;
        [self creatScrollView];
        [self creatPageControl];
        [self creatTitleLabel];

}


-(void)creatScrollView;
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollsToTop = NO;
    _scrollView.contentSize = CGSizeMake(ZQWWIDTH * (_pictureArray.count + 2), 0);
    for (int i = 0; i < _pictureArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ZQWWIDTH * (i+1), 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height )];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_pictureArray[i]] placeholderImage:_placeholder];
        [self.scrollView addSubview:imageView];
        imageView.tag = 10000+i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
    }
    
    //设置第一张图片
    UIImageView *imageView1 = [[UIImageView alloc]init];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:_pictureArray[_pictureArray.count - 1]] placeholderImage:_placeholder];
    [self.scrollView addSubview:imageView1];
    imageView1.frame = CGRectMake(0, 0, _scrollView.frame.size.width,_scrollView.frame.size.height );
    
    //设置最后一张图片
    UIImageView *imageView2 = [[UIImageView alloc]init];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:_pictureArray[0]] placeholderImage:_placeholder];
    [self.scrollView addSubview:imageView2];
    imageView2.frame = CGRectMake(ZQWWIDTH * (_pictureArray.count + 1), 0, self.scrollView.frame.size.width,_scrollView.frame.size.height );
    
    //按页翻
    self.scrollView.pagingEnabled = YES;
    //滚到边缘是否有反弹效果
    self.scrollView.bounces = NO;
    //取消横向滑条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //偏移量
    self.scrollView.contentOffset = CGPointMake(ZQWWIDTH, 0);
    //签订代理
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    
}

-(void)creatPageControl
{
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((ZQWWIDTH / 1.7)  , (self.bounds.size.height - 30) , ZQWWIDTH / 2 , 20 )];
    //        [self.scrollView addSubview:self.pageControl];
    //设置页数
    _pageControl.numberOfPages=_pictureArray.count;
    //设置当前页码的颜色
    _pageControl.currentPageIndicatorTintColor=_currentColor;
    //设置所有页码的颜色
    self.pageControl.pageIndicatorTintColor=_allColor;
    //设置事件
    //        [self.pageControl addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
}

-(void)creatTitleLabel
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.height - 30, self.bounds.size.width, 30)];
    [self addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
//    _titleLabel.backgroundColor = [UIColor greenColor];
}

#pragma mark - 定时器方法
-(void)Action
{   ////NSLog(@"%f",self.scrollView.contentOffset.x);
//    _index = 1;
    //    //NSLog(@"%ld",self.pageControl.currentPage);
//    if (_scrollView.contentOffset.x > ZQWWIDTH * _pictureArray.count) {
//        _scrollView.contentOffset = CGPointMake(ZQWWIDTH, 0);
//    }
    [UIView animateWithDuration:0.5 animations:^{
        [_scrollView setContentOffset:CGPointMake(ZQWWIDTH * (self.index + 1), 0)];
        
    }];
    
    self.index++;
    if (_scrollView.contentOffset.x >= ZQWWIDTH * (_pictureArray.count + 1)) {
        self.scrollView.contentOffset = CGPointMake(ZQWWIDTH, 0);
        self.index = 1;
    }
    self.pageControl.currentPage = self.scrollView.contentOffset.x / ZQWWIDTH - 1;
    NSLog(@"%.f",_scrollView.contentOffset.x);
    if (_scrollView.contentOffset.x <= ZQWWIDTH * _pictureArray.count) {
        
        _titleLabel.text = _titleArray[(NSInteger)self.scrollView.contentOffset.x / (NSInteger)ZQWWIDTH - 1];
    }

}

//图片减速停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x == 0) {
        _scrollView.contentOffset=CGPointMake(ZQWWIDTH * _pictureArray.count, 0);
    }
    if (_scrollView.contentOffset.x >= ZQWWIDTH * (_pictureArray.count + 1)) {
        _scrollView.contentOffset = CGPointMake(ZQWWIDTH, 0);
    }
    self.pageControl.currentPage = (_scrollView.contentOffset.x - ZQWWIDTH) / ZQWWIDTH;
    _titleLabel.text = _titleArray[(NSInteger)self.scrollView.contentOffset.x / (NSInteger)ZQWWIDTH - 1];

}

//将要开始拖拽图片时触发
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.time invalidate];
}

//图片停止时触发
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.time = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(Action) userInfo:nil repeats:YES];
    self.index = self.scrollView.contentOffset.x / ZQWWIDTH;
    if (_index == _pictureArray.count) {
        _index = 1;
    }
    //    NSLog(@"index: %ld",self.index);
    
}
//滑动时触发
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"move: %.f",_scrollView.contentOffset.x);
//    NSInteger move = scrollView.contentOffset.x;
//    
//    if (move % (NSInteger)ZQWWIDTH == 0) {
//        _titleLabel.text = _titleArray[(move - (NSInteger)ZQWWIDTH * 2)  / (NSInteger)ZQWWIDTH];
//    }
//}
//手势方法
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:tap.view.tag - 10000];
    [self.Delegate selectScrollView:imageView.tag];
}



















@end
