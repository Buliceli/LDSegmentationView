//
//  ViewController.m
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "LDPageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titles = @[@"资讯",@"体育",@"财经",@"游戏"];
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIViewController * vc = [[UIViewController alloc]init];
        [viewControllers addObject:vc];
    }
    LDDStyle * style = [[LDDStyle alloc]init];
    style.isShowCover = YES;
    style.isShowBottomLine = YES;
    style.selectedColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    style.isNeedScale = YES;
    LDPageView * pageView = [[LDPageView alloc]initWithFrame:self.view.bounds titles:titles viewControllers:viewControllers parentView:self style:style];
    
    [self.view addSubview:pageView];
}

@end
