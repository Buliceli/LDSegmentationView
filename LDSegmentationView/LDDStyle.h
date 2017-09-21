//
//  LDDStyle.h
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDDStyle : NSObject
//title的高度
@property(nonatomic,assign)CGFloat titleViewHeight;
//是否是滚动的Title
@property(nonatomic,assign)BOOL isScrollEnable;
//选中Title颜色
@property(nonatomic,strong)UIColor *  selectedColor;
//普通Title颜色
@property(nonatomic,strong)UIColor *  normalColor;
//Title字体大小
@property(nonatomic,strong)UIFont *  font;
//滚动Title的字体间距
@property(nonatomic,assign)CGFloat titleMargin;
//是否进行缩放
@property(nonatomic,assign)BOOL isNeedScale;
@property(nonatomic,assign)CGFloat scaleRange;
//是否进行遮盖
@property(nonatomic,assign)BOOL isShowCover;
//遮盖背景颜色
@property(nonatomic,strong)UIColor * coverBgColor;
//文字&遮盖间隙
@property(nonatomic,assign)CGFloat coverMargin;
//遮盖的高度
@property(nonatomic,assign)CGFloat coverH;
//设置圆角大小
@property(nonatomic,assign)CGFloat coverRadius;
//是否显示底部滚动条
@property(nonatomic,assign)BOOL isShowBottomLine;
//底部滚动条颜色
@property(nonatomic,strong)UIColor* bottomLineColor;
//底部滚动条的高度
@property(nonatomic,assign)CGFloat bottomLineH;
@end
