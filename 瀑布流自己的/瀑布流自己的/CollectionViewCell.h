//
//  CollectionViewCell.h
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *picImageView;
@property(nonatomic,strong)Model *model;

@end
