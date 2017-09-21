//
//  LDContentView.m
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDContentView.h"
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
static NSString * const kContentCellID = @"kContentCellID";
@interface LDContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSArray<UIViewController *> *viewControllers;
@property(nonatomic,strong)UIViewController * parentVC;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,assign)BOOL isForbidScrollDelegate;
@property(nonatomic,assign)CGFloat startOffsetX;
@end
@implementation LDContentView

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
        _collectionView.scrollsToTop = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    }
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray<UIViewController *> *)viewControllers parentVC:(UIViewController *)parentVC
{
    if (self = [super initWithFrame:frame]) {
        self.viewControllers = viewControllers;
        self.parentVC = parentVC;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    for (int i = 0; i < self.viewControllers.count; i++) {
        [self.parentVC addChildViewController:self.viewControllers[i]];
    }
    [self addSubview:self.collectionView];
}
#pragma mark ---- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    [cell.contentView.subviews respondsToSelector:@selector(removeFromSuperview)];
    UIViewController * vc = self.viewControllers[indexPath.item];
    vc.view.backgroundColor = HWRandomColor;
    [cell.contentView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    return cell;
}
#pragma mark ---- UICollectionViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScrollDelegate = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isForbidScrollDelegate) {
        return;
    }
    //定义获取需要的数据
    CGFloat progress = 0;
    int sourceIndex = 0;
    int targetIndex = 0;
    //判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > self.startOffsetX) {//左滑
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        sourceIndex = (int)(currentOffsetX / scrollViewW);
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.viewControllers.count) {
            targetIndex = self.viewControllers.count - 1;
        }
        //如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
        }
    }else{ // 右滑
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        targetIndex = (int)(currentOffsetX / scrollViewW);
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.viewControllers.count) {
            sourceIndex = self.viewControllers.count - 1;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:progress:sourceIndex:targetIndex:)]) {
        [self.delegate contentView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:progress:sourceIndex:targetIndex:)]) {
        [self.delegate contentViewEndScroll:self];
    }
}
- (void)setCurrentIndex:(int)currentIndex
{
    //记录需要禁止执行代理方法
    self.isForbidScrollDelegate = YES;
    //滚到正确的位置
    CGFloat offsetX = currentIndex * self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}
@end























