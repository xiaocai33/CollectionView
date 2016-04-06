//
//  ViewController.m
//  CustomLayout
//
//  Created by 小蔡 on 16/4/5.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "LineLayout.h"

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

static NSString  * const ID = @"image";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController

- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
        //假数据
        for (int i = 0; i<20; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d.png", i + 1];
            [_images addObject:imageName];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加按钮
    UIButton *flowLayoutBtn = [self setupButtonWithTitile:@"流水布局" buttonType:buttonTypeFlow];
    [self.view addSubview:flowLayoutBtn];
    
    UIButton *lineLayoutBtn = [self setupButtonWithTitile:@"线性布局" buttonType:buttonTypeLine];
    [self.view addSubview:lineLayoutBtn];
    
    UIButton *blockLayoutBtn = [self setupButtonWithTitile:@"方块布局" buttonType:buttonTypeBlock];
    [self.view addSubview:blockLayoutBtn];
    
    UIButton *circleLayoutBtn = [self setupButtonWithTitile:@"圆环布局" buttonType:buttonTypeCircle];
    [self.view addSubview:circleLayoutBtn];
    
    //禁用按钮的Autoresizing属性
    flowLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    lineLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    blockLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    circleLayoutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    //自动布局
    //X 和 宽度
    NSArray *btnX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[flowLayoutBtn]-20-[lineLayoutBtn(==flowLayoutBtn)]-20-[blockLayoutBtn(==flowLayoutBtn)]-20-[circleLayoutBtn(==flowLayoutBtn)]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn, @"lineLayoutBtn":lineLayoutBtn, @"blockLayoutBtn":blockLayoutBtn, @"circleLayoutBtn":circleLayoutBtn}];
    [self.view addConstraints:btnX];
    
    NSArray *btnW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[flowLayoutBtn]-20-[lineLayoutBtn(==flowLayoutBtn)]-20-[blockLayoutBtn(==flowLayoutBtn)]-20-[circleLayoutBtn(==flowLayoutBtn)]-20-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn, @"lineLayoutBtn":lineLayoutBtn, @"blockLayoutBtn":blockLayoutBtn, @"circleLayoutBtn":circleLayoutBtn}];
    [self.view addConstraints:btnW];
    
    //Y 和 高度
    NSArray *btnYH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[flowLayoutBtn(50)]-30-|" options:0 metrics:nil views:@{@"flowLayoutBtn":flowLayoutBtn}];
    [self.view addConstraints:btnYH];
    
    //添加UICollectionView
    //设置了autoLayout后这个属性没有用
    CGRect rect = CGRectMake(0, 50, self.view.frame.size.width, 200);
    
    //创建UICollectionViewFlowLayout,并设置其中的属性
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置布局中每个cell的大小
    flowLayout.itemSize = CGSizeMake(80, 80);
    
    //设置布局中每个cell的列间距
    //flowLayout.minimumInteritemSpacing = 10;
    
    //设置布局中每个cell的行间距
    flowLayout.minimumLineSpacing = 20;
    
    //设置内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.flowLayout = flowLayout;
    
    //设置滚动方向
    //flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    collection.backgroundColor = [UIColor grayColor];
    collection.dataSource = self;
    collection.delegate = self;
    //设置布局为:UICollectionViewFlowLayout流水布局
    //[collection setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];
    //注册cell(从xib加载)
    [collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collection];
    
    self.collectionView = collection;
    
    collection.translatesAutoresizingMaskIntoConstraints = NO;
    
    //自动布局
    //X 和 宽度
    NSArray *collectionXW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collection]-0-|" options:0 metrics:nil views:@{@"collection":collection}];
    [self.view addConstraints:collectionXW];
    //Y 和 高度
    NSArray *collectionYH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[collection(200)]" options:0 metrics:nil views:@{@"collection":collection}];
    [self.view addConstraints:collectionYH];
}

#pragma mark - UICollectionViewDataSource数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    
    
    return cell;

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
        {
            //if (![self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
                [self.collectionView setCollectionViewLayout:self.flowLayout animated:YES];
            //}
            break;
        }
        case buttonTypeLine:
        {
            if (![self.collectionView.collectionViewLayout isKindOfClass:[LineLayout class]]) {
                [self.collectionView setCollectionViewLayout:[[LineLayout alloc] init] animated:YES];
            }
            break;
        }
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
