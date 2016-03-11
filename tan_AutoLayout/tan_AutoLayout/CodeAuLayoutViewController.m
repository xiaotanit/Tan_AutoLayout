//
//  CodeAuLayoutViewController.m
//  tan_AutoLayout
//
//  Created by PX_Tan on 16/1/3.
//  Copyright © 2016年 tanxiaoming. All rights reserved.
//

//如果我们想要使用masonry,而不想是使用mas_前缀,那么就定义这个宏
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//如果你想自动装箱给沙盒就定义这个宏
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "CodeAuLayoutViewController.h"
#import "Masonry.h"

@interface CodeAuLayoutViewController ()
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@end

@implementation CodeAuLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initControllers];
    [self testMasonry]; //测试使用Masonry来进行自动布局
    [self testLayoutAnimal]; //测试布局动画
    
}


#pragma mark - 初始化控件信息
- (void)initControllers{
    /*
     需求：一个红色view，和一个蓝色view，红色view左、右、顶部间距都为20，
     两个view高度相同，右对齐，蓝色view宽度为红色view宽度一半
    */
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //2、创建红色View和蓝色view
    UIView *redView = [[UIView alloc] init];
    [redView setBackgroundColor:[UIColor redColor]];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    [blueView setBackgroundColor:[UIColor blueColor]];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
     
    //3、设置约束
    //3.1 设置redView距离父控件左边距20px :
    //NSLayoutAttributeLeft = NSLayoutAttributeLeading = NSLayoutAttributeLeftMargin
    NSLayoutConstraint *leftMargin = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    [self.view addConstraint:leftMargin];
    
    //3.2 设置右边距
    NSLayoutConstraint *rightMargin = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.0];
    [self.view addConstraint:rightMargin];
    
    //3.3 top : 设置距离顶部40px
    NSLayoutConstraint *topMargin = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
    [self.view addConstraint:topMargin];

    //3.4 height ,设置高度： 50px;
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0];
    [self.view addConstraint:height];
    
    //3.5 开始设置blueView的约会
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self.view addConstraint:blueRight];
    //3.6 blueView y
    NSLayoutConstraint *blueY = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0];
    [self.view addConstraint:blueY];
    //3.7 blueView height = redView height
    NSLayoutConstraint *blueHeight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [self.view addConstraint:blueHeight];
    //3.8 blueView width
    NSLayoutConstraint *blueWidth = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0];
    [self.view addConstraint:blueWidth];
    
    //添加返回按钮
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, 80, 30)];
    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnPage) forControlEvents:UIControlEventTouchUpInside];
    [returnBtn setBackgroundColor:[UIColor blueColor]];
    [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview: returnBtn];
}

- (void)returnPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//测试用是Masonry来进行自动布局
- (void)testMasonry{
    /**
     1、创建一个红色View和蓝色View，蓝色宽度为红色宽度一半
     */
    UIView *redView = [[UIView alloc] init];
    [redView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    [blueView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:blueView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //第一种写法
        make.top.equalTo(self.view.mas_top).offset(200);
        //make.left.equalTo(self.view.mas_left).offset(20);  //这三种写法效果一样
        //make.leading.equalTo(self.view.mas_leading).offset(20);
        make.leadingMargin.equalTo(self.view.mas_leadingMargin).offset(20);
        make.height.offset(50);
        make.right.equalTo(self.view.mas_right).offset(-20);
        
//        //第二种写法
//        make.top.equalTo(self.view).offset(200);
//        make.left.equalTo(self.view).offset(20);
//        make.height.offset(50);
//        make.right.equalTo(self.view).offset(-20);
        
        //第三种写法
        //make.top.bottom.equalTo(self.view).offset(20);
        //.....
        
        //第四种写法: 设置顶部、左、下、右边距
        //make.edges.equalTo(UIEdgeInsetsMake(200, 20, 0, -20));
        //....
    }];
//    [redView makeConstraints:^(MASConstraintMaker *make) {
//       //如果使用宏MAS_SHORTHAND就
//    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.equalTo(redView.mas_width).multipliedBy(0.5);
        make.height.equalTo(redView.mas_height);
    }];
    
    //修改约束
    [blueView updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(redView.mas_width).multipliedBy(0.5).offset(50);
    }];
    
//    //清空之前的约会，重置约束
//    [blueView remakeConstraints:^(MASConstraintMaker *make) {
//       //....
//    }];
}

//测试自动布局来改变动画
- (void)testLayoutAnimal{
    UIView *greenView = [[UIView alloc] init];
    [greenView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:greenView];
    greenView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftCons = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:leftCons];
    
    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:180];
    [self.view addConstraint:topCons];
    
    NSLayoutConstraint *widthCons = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:widthCons];
    
    NSLayoutConstraint *heightCons = [NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:heightCons];
    
    self.topConstraint = topCons;
}

//触动事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.topConstraint.constant += 30;
    [UIView beginAnimations:nil context:nil];  //开始动画
    [UIView setAnimationDuration:2.0];
    [self.view layoutIfNeeded];
    [UIView commitAnimations]; //提交动画
}

/*
 typedef NS_ENUM(NSInteger, NSLayoutAttribute) {
 NSLayoutAttributeLeft = 1,
 NSLayoutAttributeRight,
 NSLayoutAttributeTop,
 NSLayoutAttributeBottom,
 NSLayoutAttributeLeading,
 NSLayoutAttributeTrailing,
 NSLayoutAttributeWidth,
 NSLayoutAttributeHeight,
 NSLayoutAttributeCenterX,
 NSLayoutAttributeCenterY,
 NSLayoutAttributeBaseline,
 NSLayoutAttributeLastBaseline = NSLayoutAttributeBaseline,
 NSLayoutAttributeFirstBaseline NS_ENUM_AVAILABLE_IOS(8_0),
 
 
 NSLayoutAttributeLeftMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeRightMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeTopMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeBottomMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeLeadingMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeTrailingMargin NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeCenterXWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
 NSLayoutAttributeCenterYWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
 
 NSLayoutAttributeNotAnAttribute = 0
 };
 
 typedef NS_ENUM(NSInteger, NSLayoutRelation) {
 NSLayoutRelationLessThanOrEqual = -1,
 NSLayoutRelationEqual = 0,
 NSLayoutRelationGreaterThanOrEqual = 1,
 };
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
