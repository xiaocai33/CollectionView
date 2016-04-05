//
//  ViewController.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/5.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "ViewController.h"

typedef enum{
    /** 流水布局 */
    buttonTypeFlow = 0,
    /** 线性布局 */
    buttonTypeLine,
    /** 块状布局 */
    buttonTypeBlock,
    /** 圆环布局 */
    buttonTypeCircle
} buttonType;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *flowLayoutBtn = [self setupButtonWithTitile:@"流水布局" buttonType:buttonTypeFlow];
    [self.view addSubview:flowLayoutBtn];
    
    UIButton *lineLayoutBtn = [self setupButtonWithTitile:@"线性布局" buttonType:buttonTypeLine];
    [self.view addSubview:lineLayoutBtn];
    
    UIButton *blockLayoutBtn = [self setupButtonWithTitile:@"方块布局" buttonType:buttonTypeBlock];
    [self.view addSubview:blockLayoutBtn];
    
    UIButton *circleLayoutBtn = [self setupButtonWithTitile:@"圆环布局" buttonType:buttonTypeCircle];
    [self.view addSubview:circleLayoutBtn];
    
    flowLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    lineLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    blockLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    circleLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    //X 和 宽度
    NSArray *btnX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[flowLayoutBtn]-20-[lineLayoutBtn(==flowLayoutBtn)]-20-[blockLayoutBtn(==flowLayoutBtn)]-20-[circleLayoutBtn(==flowLayoutBtn)]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn, @"lineLayoutBtn":lineLayoutBtn, @"blockLayoutBtn":blockLayoutBtn, @"circleLayoutBtn":circleLayoutBtn}];
    [self.view addConstraints:btnX];
    
    NSArray *btnW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[flowLayoutBtn]-20-[lineLayoutBtn(==flowLayoutBtn)]-20-[blockLayoutBtn(==flowLayoutBtn)]-20-[circleLayoutBtn(==flowLayoutBtn)]-20-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn, @"lineLayoutBtn":lineLayoutBtn, @"blockLayoutBtn":blockLayoutBtn, @"circleLayoutBtn":circleLayoutBtn}];
    [self.view addConstraints:btnW];
    //Y 和 高度
    NSArray *btnYH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[flowLayoutBtn(50)]-30-|" options:0 metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn}];
    [self.view addConstraints:btnYH];
    
}

/**
 *  添加按钮
 *  @param title 按钮文字
 *  @param type  类型
 */
- (UIButton *)setupButtonWithTitile:(NSString *)title buttonType:(buttonType)type{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//监听按钮的点击事件
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case buttonTypeFlow:
            NSLog(@"buttonTypeFlow");
            break;
        case buttonTypeLine:
            NSLog(@"buttonTypeLine");
            break;
        case buttonTypeBlock:
            NSLog(@"buttonTypeBlock");
            break;
        case buttonTypeCircle:
            NSLog(@"buttonTypeCircle");
            break;
            
        default:
            break;
    }
}

@end
