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
    // Initialization code
}

- (void)setImage:(NSString *)image{
    _image = [image copy];
    
    self.imageV.image = [UIImage imageNamed:image];
}

@end
