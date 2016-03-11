//
//  ViewController.m
//  tan_AutoLayout
//
//  Created by PX_Tan on 15/12/28.
//  Copyright © 2015年 tanxiaoming. All rights reserved.
// 

#import "ViewController.h"
#import "CodeAuLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)codeAulayout:(id)sender{
    CodeAuLayoutViewController *controller = [[CodeAuLayoutViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
