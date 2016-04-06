//
//  CircleLayout.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attr.size = CGSizeMake(100, 100);
    
    //设置圆心
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    //半径
    CGFloat circleR = 100;
    
    //设置初始化角度
    CGFloat rangeInit = M_PI * 2 / ([self.collectionView numberOfItemsInSection:indexPath.section]);
    
    //设置每个item的中心点在圆上
    CGFloat attrCenterX = circleCenter.x + circleR * cosf(indexPath.item * rangeInit);
    CGFloat attrCenterY = circleCenter.y - circleR * sinf(indexPath.item * rangeInit);
    attr.center = CGPointMake(attrCenterX, attrCenterY);
    
    attr.zIndex = indexPath.item;
    
    return attr;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attrs = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i =0; i<count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attrs addObject:attr];
    }
    
    return attrs;
    
}

@end
