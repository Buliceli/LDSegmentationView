//
//  LDTitleView.h
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDStyle.h"
@class LDTitleView;
@protocol LDTitleViewProtocol <NSObject>

- (void)ldTitleView:(LDTitleView*)titleView selectedIndex:(int)index;

@end
@interface LDTitleView : UIView
@property(nonatomic,assign)id<LDTitleViewProtocol>delegate;
@property(nonatomic,strong)NSArray * normalColorRGB;
@property(nonatomic,strong)NSArray * selectedColorRGB;
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray<NSString*>*)titles style:(LDDStyle*)style;
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;
- (void)contentViewDidEndScroll;

@end

















