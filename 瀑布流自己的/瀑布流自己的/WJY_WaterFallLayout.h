//
//  WJY_WaterFallLayout.h
//  DreamRoomage
//
//  Created by wjy on 15/9/16.
//  Copyright (c) 2015年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol WaterLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;




@end
@interface WJY_WaterFallLayout : UICollectionViewLayout
@property (nonatomic, assign) id<WaterLayoutDelegate> delegate;
// 行数
@property (nonatomic, assign) NSInteger lineCount;
// 水平间距
@property (nonatomic, assign) CGFloat verticalSpacing;
// 垂直间距
@property (nonatomic, assign) CGFloat horizontalSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@end
