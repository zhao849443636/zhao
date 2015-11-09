//
//  ViewController.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "ViewController.h"
#import "WJY_WaterFallLayout.h"
#import "ZQW_AppTools.h"
#import "Model.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *pixclArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pixclArray = [NSMutableArray array];
    
    WJY_WaterFallLayout *waterFallLayout = [[WJY_WaterFallLayout alloc]init];
    waterFallLayout.lineCount = 2;
    waterFallLayout.verticalSpacing = 10;
    waterFallLayout.horizontalSpacing = 10;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:waterFallLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self getAFNetWorkingData];

}

-(void)getAFNetWorkingData
{
    [ZQW_AppTools getMessage:@"http://pic.jiajuol.com/api/iphone/0500/pic_photo.php?act=like_photo_list&page=1&pagesize=24&time=day&v=5.5" Block:^(id result) {
        
        NSArray *resultArray = result;
        NSArray *smallArray = resultArray[0];
        for (NSDictionary *dic in smallArray) {
            Model *model = [Model new];
            [model setValuesForKeysWithDictionary:dic];
            [self.pixclArray addObject:model];
        }
        
        [_collectionView reloadData];
    } and:^(id result1) {
        
        
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _pixclArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Model *model = _pixclArray[indexPath.item];
    cell.model = model;
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((375 - 30) / 2, arc4random()%200 + 150);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
