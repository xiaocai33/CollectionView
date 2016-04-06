//
//  BlockLayout.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "BlockLayout.h"

@implementation BlockLayout

/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/** 设置indexPath位置cell的样式 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //设置旋转角度
    NSArray *angles = @[@(0), @(0.5), @(0.3), @(-0.3), @(-0.5)];
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置属性大小
    attr.size = CGSizeMake(130, 130);
    
    //设置属性的中心点
    attr.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    //只显示前5个
    if (indexPath.item >= 5) {
        attr.hidden = YES;
    }else{
        attr.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        
        //值越大的,越在上面
        //attr.zIndex = [self.collectionView numberOfItemsInSection:0] - indexPath.item;
        //NSLog(@"%ld", attr.zIndex);
    }
    
    return attr;

}

/**
 *  设置rect区域的所有item的样式/header/footer等
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attrs = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attrs addObject:attr];
    }
    
    return attrs;
}

@end
