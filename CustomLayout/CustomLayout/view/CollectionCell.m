//
//  CollectionCell.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//纯代码创建cell

#import "CollectionCell.h"
static NSString  * const ID = @"image";

@interface CollectionCell()

@property (nonatomic, weak) UIImageView *imageV;

@end

@implementation CollectionCell


+ (instancetype)collectionCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}



- (UIImageView *)imageV{
    if (_imageV ==nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        //添加相框
        //设置imageView视图的边框大小
        imageV.layer.borderWidth = 3;
        //设置imageView视图的边框颜色
        imageV.layer.borderColor = [UIColor whiteColor].CGColor;
        //设置imageView视图的边框圆角
        imageV.layer.cornerRadius = 3;
        //裁剪图片到imageView视图
        imageV.clipsToBounds = YES;
        _imageV = imageV;
    }
    return _imageV;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageV.translatesAutoresizingMaskIntoConstraints = NO;
    
    //自动布局
    //X 和 宽度
    NSArray *imageVXW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageV]-0-|" options:0 metrics:nil views:@{@"imageV":self.imageV}];
    [self addConstraints:imageVXW];
    //Y 和 高度
    NSArray *imageVYH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageV]-0-|" options:0 metrics:nil views:@{@"imageV":self.imageV}];
    [self addConstraints:imageVYH];
}

- (void)setImage:(NSString *)image{
    _image = [image copy];
    
    self.imageV.image = [UIImage imageNamed:image];
}

@end
