//
//  CollectionViewCell.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/6.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    //添加相框
    //设置imageView视图的边框大小
    self.imageV.layer.borderWidth = 3;
    //设置imageView视图的边框颜色
    self.imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置imageView视图的边框圆角
    self.imageV.layer.cornerRadius = 3;
    //裁剪图片到imageView视图
    self.imageV.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image{
    _image = [image copy];
    
    self.imageV.image = [UIImage imageNamed:image];
}

@end
