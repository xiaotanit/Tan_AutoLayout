//
//  ViewController.m
//  tan_Autoresizing
//
//  Created by PX_Tan on 15/12/30.
//  Copyright © 2015年 tanxiaoming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *supView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initInfo];
}

- (void)initInfo{
    //创建一个父控件
    UIView *supView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 250, 150)];
    [supView setBackgroundColor:[UIColor purpleColor]];
    supView.alpha = 0.9;
    [self.view addSubview:supView];
    self.supView = supView;
    
    //2、创建子控件
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 250, 30)];
    [subView setBackgroundColor:[UIColor redColor]];
    subView.alpha = 0.8;
    [self.supView addSubview:subView];
    
    //3、设置子控件的自动变化属性
    /*
     UIViewAutoresizingNone                 = 0,
     UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
     UIViewAutoresizingFlexibleWidth        = 1 << 1,
     UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
     UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
     UIViewAutoresizingFlexibleHeight       = 1 << 4,
     UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     */
    //设置宽度自动随父控件变化，顶部边距自动变化
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

//控制器触摸事件开始: 改变父级控件变化
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGRect rect = self.supView.frame;
    rect.size.width += 20;
    rect.size.height += 20;
    self.supView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
