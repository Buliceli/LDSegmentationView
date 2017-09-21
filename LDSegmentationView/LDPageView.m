//
//  LDPageView.m
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDPageView.h"
#import "LDTitleView.h"
#import "LDContentView.h"
@interface LDPageView ()<LDTitleViewProtocol,LDContentViewProtocol>
@property(nonatomic,strong)LDTitleView * titleView;
@property(nonatomic,strong)LDContentView * contentView;
@property(nonatomic,strong)LDDStyle * style;
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)UIViewController * parentVc;
@property(nonatomic,strong)NSArray<UIViewController*>*childVcs;
@end
@implementation LDPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles viewControllers:(NSArray<UIViewController *> *)viewControllers parentView:(UIViewController *)parentVC style:(LDDStyle *)style
{
    if (self = [super initWithFrame:frame]) {
        _style = style;
        _parentVc = parentVC;
        _childVcs = viewControllers;
        parentVC.automaticallyAdjustsScrollViewInsets = NO;
        NSAssert(titles.count == viewControllers.count,@"标题&控制器个数不同,请检测");
        _titleView = [[LDTitleView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _style.titleViewHeight) Titles:titles style:style];
        _titleView.delegate = self;
        [self addSubview:_titleView];
        
        _contentView = [[LDContentView alloc]initWithFrame:CGRectMake(0, _style.titleViewHeight, self.bounds.size.width, self.bounds.size.height - _style.titleViewHeight) viewControllers:viewControllers parentVC:parentVC];
        _contentView.delegate = self;
        _contentView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_contentView];
        
    }
    return self;
}
#pragma mark --- LDContentViewDelegate
- (void)contentView:(LDContentView *)contentView progress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex
{
    [self.titleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}
- (void)contentViewEndScroll:(LDContentView *)contentView
{
    [self.titleView contentViewDidEndScroll];
}
#pragma mark --- LDTitleViewDelegate
- (void)ldTitleView:(LDTitleView *)titleView selectedIndex:(int)index
{
    [self.contentView setCurrentIndex:index];
}
@end
