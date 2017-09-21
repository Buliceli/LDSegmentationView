//
//  LDDStyle.m
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDDStyle.h"

@implementation LDDStyle
- (CGFloat)titleViewHeight
{
    if (_titleViewHeight) {
        return _titleViewHeight;
    }else{
        return 44;
    }
}
- (UIFont *)font
{
    if (_font) {
        return _font;
    }else{
        return [UIFont systemFontOfSize:14];
    }
}
- (UIColor *)normalColor
{
    if (_normalColor) {
        return _normalColor;
    }else{
        return [UIColor colorWithRed:0 / 255.0 green:0 /255.0 blue:0 / 255.0 alpha:1];
    }
}
- (UIColor *)selectedColor
{
    if (_selectedColor) {
        return _selectedColor;
    }else{
        return [UIColor colorWithRed:255 / 255.0 green:127 / 255.0 blue:0 / 255.0 alpha:1];

    }
}
- (CGFloat)titleMargin
{
    if (_titleMargin) {
        return _titleMargin;
    }else{
        return 20;
    }
}
- (BOOL)isNeedScale
{
    if (_isNeedScale) {
        return _isNeedScale;
    }else{
        return NO;
    }
}
- (CGFloat)scaleRange
{
    if (_scaleRange) {
        return _scaleRange;
    }else{
        return 1.2;
    }
    
}
- (BOOL)isShowCover
{
    if (_isShowCover) {
        return _isShowCover;
    }else{
        return NO;
    }
}
- (UIColor *)coverBgColor
{
    if (_coverBgColor) {
        return _coverBgColor;
    }else{
        return [UIColor lightGrayColor];
    }
}
- (CGFloat)coverMargin
{
    if (_coverMargin) {
        return _coverMargin;
    }else{
        return 5;
    }
}
- (CGFloat)coverH
{
    if (_coverH) {
        return _coverH;
    }else{
        return 25;
    }
}
- (CGFloat)coverRadius
{
    if (_coverRadius) {
        return _coverRadius;
    }else{
        return 12;
    }
}
- (BOOL)isShowBottomLine
{
    if (_isShowBottomLine) {
        return _isShowBottomLine;
    }else{
        return NO;
    }
}
- (UIColor *)bottomLineColor
{
    if (_bottomLineColor) {
        return _bottomLineColor;
    }else{
        return [UIColor orangeColor];
    }
}
- (CGFloat)bottomLineH
{
    if (_bottomLineH) {
        return _bottomLineH;
    }else{
        return 2;
    }
}
@end













