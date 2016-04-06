//
//  LineLayout.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "LineLayout.h"

static const CGFloat ItemWH = 100;

@implementation LineLayout
/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout{
    
    //设置内部每个cell的大小
    self.itemSize = CGSizeMake(ItemWH, ItemWH);
    
    //设置滚动方向为水平
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置各个列(水平)/列(竖直)的间距
    self.minimumLineSpacing = 60;
    
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - ItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

/** 有效距离:当item的中间x距离屏幕的中间x在HMActiveDistance以内,才会开始放大, 其它情况都是缩小 */
static CGFloat const maxDistance = 150;
/** 缩放因素: 值越大, item就会越大 */
static CGFloat const scaleFactor = 0.6;


/**
 *  设置rect区域的所有item的样式/header/footer等
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //获取屏幕可见区域
    CGRect vRect;
    vRect.origin = self.collectionView.contentOffset;
    vRect.size = self.collectionView.frame.size;
    
    //计算屏幕的中心x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //得到所有的cell的属性attrs
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    //便利所有的属性
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        //判断是否在可见区域(CGRectIntersectsRect(1,2) 1, 2中是否有边界相交)
        if ( !CGRectIntersectsRect(vRect, attr.frame)) continue;
        
        //计算当前cell的中心
        CGFloat itemCenterX = attr.center.x;
        
        CGFloat scale = 1 + scaleFactor * (1 - (ABS(itemCenterX - centerX)) / maxDistance);
        
        //设置缩放
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs;
}

@end
