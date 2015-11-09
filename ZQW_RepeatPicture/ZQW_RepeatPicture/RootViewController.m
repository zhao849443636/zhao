//
//  RootViewController.m
//  ZQW_RepeatPicture
//
//  Created by dllo on 15/10/31.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "RootViewController.h"
#import "ZQW_ScrollView.h"
#import "ZQW_AppTools.h"
@interface RootViewController ()<ZQWScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *repeatArray;
@property(nonatomic,strong)ZQW_ScrollView *zqw;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
#pragma mark - 三方创建
    _zqw = [[ZQW_ScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 220)];
//    _zqw.backgroundColor = [UIColor blueColor];
    _zqw.currentColor = [UIColor yellowColor];
    _zqw.allColor = [UIColor whiteColor];
    _zqw.autoScrollTimeInterval = 2;
    _zqw.Delegate = self;
    
    //把轮播图的标题放此数组中
    _zqw.titleArray = @[@"你好",@"再见"];
    [self getAFNetWorkingData];
}
//解析数据 得到轮播图url网址
-(void)getAFNetWorkingData
{
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/auto/list/5aSn6L2Be/20-20.html"];
    [ZQW_AppTools getMessage:string Block:^(id result) {
        //NSLog(@"=%ld",self.nextPage);
        //        //NSLog(@"yule = %@",result);
        
        NSMutableDictionary *dic = result;
        NSMutableArray *bigArray = [dic objectForKey:@"list"];
        for (NSMutableDictionary *dic1 in bigArray) {
            
        }
        
#pragma mark - 轮播图
        //数组保护
        if (bigArray.count != 0) {
            
            
            self.repeatArray = [NSMutableArray array];
            NSMutableArray *array2 = [NSMutableArray array];
            NSMutableDictionary *dic2 = bigArray[0];
            //        //NSLog(@"array = %@",array[0]);
            array2 = [dic2 objectForKey:@"ads"];
            
            for (NSDictionary *dic in array2) {
                [self.repeatArray addObject:[dic objectForKey:@"imgsrc"]];
//                self.repeatUrl = [dic objectForKey:@"url"];
            }
            [self.repeatArray addObject:[dic2 objectForKey:@"imgsrc"]];
            //调用轮播图方法
        }
        
            _zqw.pictureArray = _repeatArray;
           [self.view addSubview:_zqw];
            
        
    } and:^(id result1) {
        
     
        
    }];
}
//轮播图点击事件
-(void)selectScrollView:(NSInteger)index
{
    NSLog(@"点了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
