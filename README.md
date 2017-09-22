```
Installation【安装】

From CocoaPods【使用CocoaPods】

pod search LDSegmentationView

Use 【使用】
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

```
