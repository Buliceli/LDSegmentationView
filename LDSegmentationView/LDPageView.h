//
//  LDPageView.h
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//
#import "LDDStyle.h"
#import <UIKit/UIKit.h>

@interface LDPageView : UIView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString*>*)titles viewControllers:(NSArray<UIViewController*>*)viewControllers parentView:(UIViewController*)parentVC style:(LDDStyle*)style;
@end
