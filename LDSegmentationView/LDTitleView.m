//
//  LDTitleView.m
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDTitleView.h"

@interface LDTitleView ()
@property(nonatomic,strong)NSArray<NSString*>* titles;
@property(nonatomic,strong)LDDStyle * style;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIView * spliteLineView;
@property(nonatomic,strong)NSMutableArray * titleLabels;
@property(nonatomic,strong)UIView * bottomLine;
@property(nonatomic,strong)UIView * coverView;
@property(nonatomic,assign)int currentIndex;
@end
@implementation LDTitleView
- (NSArray *)normalColorRGB
{
    if (_normalColorRGB) {
        return _normalColorRGB;
    }else{
        return [self getRGBWithColor:self.style.normalColor];
    }
}
- (NSArray<NSNumber*> *)selectedColorRGB
{
    if (_selectedColorRGB) {
        return _selectedColorRGB;
    }else{
        return [self getRGBWithColor:self.style.selectedColor];
    }
    
}
- (void)normalColorRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    [self getRGBWithColor:self.style.normalColor];
}
- (NSArray*)getRGBWithColor:(UIColor*)color
{
    CGColorRef  cgcolor = color.CGColor;
    const CGFloat *colorComponents = CGColorGetComponents(cgcolor);
    if (!colorComponents) {
        NSLog(@"请使用RGB方式给Title赋值颜色");
    }
    NSLog(@"%f---%f---%f",colorComponents[0] * 255,colorComponents[1] * 255,colorComponents[2] * 255);
    return @[@(colorComponents[0] * 255),@(colorComponents[1] * 255),@(colorComponents[2] *255)];
  
}
- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = self.style.coverBgColor;
        _coverView.alpha = 0.7;
    }
    return _coverView;
}
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = self.style.bottomLineColor;
    }
    return _bottomLine;
}
- (NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = self.bounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}
- (UIView *)spliteLineView
{
    if (!_spliteLineView) {
        _spliteLineView = [[UIView alloc]init];
        _spliteLineView.backgroundColor = [UIColor lightGrayColor];
        CGFloat h = 0.5;
        _spliteLineView.frame = CGRectMake(0, self.frame.size.height - h, self.frame.size.width, h);
    }
    return _spliteLineView;
}
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray<NSString *> *)titles style:(LDDStyle *)style
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    [self addSubview:self.scrollView];
    [self addSubview:self.spliteLineView];
    [self setUpTitleLabels];
    [self setUpTitleLabelsPosition];
    //设置底部的滚动条
    if (self.style.isShowBottomLine) {
        [self setupBottomLine];
    }
    //设置遮盖的View
    if (self.style.isShowCover) {
        [self setUpCoverView];
    }
}
- (void)setUpTitleLabels
{
    for (int i = 0; i < self.titles.count; i++) {
        UILabel * label = [[UILabel alloc]init];
        label.tag = i;
        label.text = self.titles[i];
        label.textColor = i == 0?self.style.selectedColor : self.style.normalColor;
        label.font = self.style.font;
        label.textAlignment = YES;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
        [self.titleLabels addObject:label];
        [self.scrollView addSubview:label];
    }
}
#pragma mark --- 事件处理
- (void)titleLabelClick:(UITapGestureRecognizer*)tap
{
    UILabel * currentLabel = (UILabel*)tap.view;
    if (!currentLabel || currentLabel.tag == self.currentIndex) {
        return;
    }
    //获取之前的label
    UILabel * oldLabel = self.titleLabels[self.currentIndex];
    //切换文字的颜色
    currentLabel.textColor = self.style.selectedColor;
    oldLabel.textColor = self.style.normalColor;
    self.currentIndex = currentLabel.tag;
    
    //通知代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(ldTitleView:selectedIndex:)]) {
        [self.delegate ldTitleView:self selectedIndex:self.currentIndex];
    }
    //居中显示
    [self contentViewDidEndScroll];
    //调整bottonLine
    if (self.style.isShowBottomLine) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.bottomLine.frame;
            rect.origin.x = currentLabel.frame.origin.x;
            rect.size.width = currentLabel.frame.size.width;
            self.bottomLine.frame = rect;
        }];
    }
    //调整比例
    if (self.style.isNeedScale) {
        oldLabel.transform = CGAffineTransformIdentity;
        currentLabel.transform = CGAffineTransformMakeScale(self.style.scaleRange, self.style.scaleRange);
    }
    //遮盖移动
    if (self.style.isShowCover) {
        CGFloat coverX = self.style.isScrollEnable?(currentLabel.frame.origin.x - self.style.coverMargin) : currentLabel.frame.origin.x;
        CGFloat coverW = self.style.isScrollEnable?(currentLabel.frame.size.width + self.style.coverMargin*2) : currentLabel.frame.size.width;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.coverView.frame;
            rect.origin.x = coverX;
            rect.size.width = coverW;
            self.coverView.frame = rect;
        }];
    }
    
}
- (void)contentViewDidEndScroll
{
    //如不需要滚动 则不需要调整中间的位置
    if (!self.style.isScrollEnable) {
        return;
    }
    //获取目标label
    UILabel * targetLabel = self.titleLabels[self.currentIndex];
    //计算和中间位置的偏移量
    CGFloat offSetX = targetLabel.center.x - self.bounds.size.width * 0.5;
    if (offSetX < 0) {
        offSetX = 0;
    }
    CGFloat maxOffset = self.scrollView.contentSize.width - self.bounds.size.width;
    if (offSetX > maxOffset) {
        offSetX = maxOffset;
    }
    [self.scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}
- (void)setUpTitleLabelsPosition
{
    CGFloat titleX = 0.0;
    CGFloat titleW = 0.0;
    CGFloat titleY = 0.0;
    CGFloat titleH = self.frame.size.height;
    
    for (int i = 0; i < self.titleLabels.count; i++) {
        UILabel * label = self.titleLabels[i];
        if (self.style.isScrollEnable) {
            CGRect rect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.style.font} context:nil];
            titleW = rect.size.width;
            if (i == 0) {
                titleX = self.style.titleMargin * 0.5;
            }else{
                UILabel * preLabel = self.titleLabels[i- 1];
                titleX = CGRectGetMaxX(preLabel.frame) + self.style.titleMargin;
            }
        }else{
            titleW = self.frame.size.width / self.titleLabels.count;
            titleX = titleW * i;
        }
        label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        //放大代码
        if(i == 0){
            CGFloat scale = self.style.isNeedScale ? self.style.scaleRange : 1.0;
            label.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
    if (self.style.isScrollEnable) {
        UILabel * lastLabel = self.titleLabels.lastObject;
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + self.style.titleMargin*0.5, 0);
    }
}
- (void)setupBottomLine
{
    [self.scrollView addSubview:self.bottomLine];
    UILabel * firstL = self.titleLabels.firstObject;
    self.bottomLine.frame = firstL.frame;
    CGRect rect = self.bottomLine.frame;
    rect.size.height = self.style.bottomLineH;
    rect.origin.y = self.bounds.size.height - self.style.bottomLineH;
    self.bottomLine.frame = rect;
    
}
- (void)setUpCoverView
{
    [self.scrollView insertSubview:self.coverView atIndex:0];
    UILabel * firstL = self.titleLabels[0];
    CGFloat coverW = firstL.frame.size.width;
    CGFloat coverH = self.style.coverH;
    CGFloat coverX = firstL.frame.origin.x;
    CGFloat coverY = (self.bounds.size.height -coverH) * 0.5;
    if (self.style.isScrollEnable) {
        coverX -= self.style.coverMargin;
        coverW += self.style.coverMargin * 2;
    }
    self.coverView.frame = CGRectMake(coverX, coverY, coverW, coverH);
    self.coverView.layer.cornerRadius = self.style.coverRadius;
    self.coverView.layer.masksToBounds = YES;
}
#pragma mark --- 对外界暴露的方法
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex
{
    UILabel * sourceLabel = self.titleLabels[sourceIndex];
    UILabel * targetLabel = self.titleLabels[targetIndex];
    //颜色的渐变
    CGFloat r = [self.selectedColorRGB[0] integerValue] - [self.normalColorRGB[0] integerValue];
    CGFloat g = [self.selectedColorRGB[1] integerValue] - [self.normalColorRGB[1] integerValue];
    CGFloat b = [self.selectedColorRGB[2] integerValue] - [self.normalColorRGB[2] integerValue];
    //变化sourceLabel
    sourceLabel.textColor = [UIColor colorWithRed:([self.selectedColorRGB[0] integerValue] - r * progress) / 255 green:([self.selectedColorRGB[1] integerValue] - g * progress) / 255 blue:([self.selectedColorRGB[2] integerValue] - b * progress) / 255 alpha:1];
    //变化targetLabel
    
    targetLabel.textColor = [UIColor colorWithRed:([self.normalColorRGB[0] integerValue] + r * progress) / 255 green:([self.normalColorRGB[1] integerValue] + g * progress) / 255 blue:([self.normalColorRGB[2] integerValue] + b * progress) / 255 alpha:1];
    //记录最新的index
    self.currentIndex = targetIndex;
    
    CGFloat moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
    CGFloat moveTotalW = targetLabel.frame.size.width - sourceLabel.frame.size.width;
    //计算滚动的范围差值
    if (self.style.isShowBottomLine) {
        CGRect rect = self.bottomLine.frame;
        rect.size.width = sourceLabel.frame.size.width + moveTotalW * progress;
        rect.origin.x = sourceLabel.frame.origin.x + moveTotalX * progress;
        self.bottomLine.frame = rect;
    }
    //放大的比例
    if (self.style.isNeedScale) {
        CGFloat scaleDelte = (self.style.scaleRange - 1.0) * progress;
        sourceLabel.transform = CGAffineTransformMakeScale(self.style.scaleRange - scaleDelte, self.style.scaleRange - scaleDelte);
        targetLabel.transform = CGAffineTransformMakeScale(1.0 + scaleDelte, 1.0 + scaleDelte);
        
    }
    //计算cover的滚动
    if (self.style.isShowCover) {
        CGRect rect = self.coverView.frame;
        rect.size.width = self.style.isScrollEnable?(sourceLabel.frame.size.width + 2* self.style.coverMargin + moveTotalW * progress) :(sourceLabel.frame.size.width + moveTotalW * progress);
        rect.origin.x = self.style.isScrollEnable?(sourceLabel.frame.origin.x - self.style.coverMargin + moveTotalX * progress):(sourceLabel.frame.origin.x + moveTotalX * progress);
        self.coverView.frame = rect;
    }
    
}
@end












