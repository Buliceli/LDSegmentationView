//
//  LDContentView.h
//  LDSegmentationView
//
//  Created by 李洞洞 on 14/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDContentView;
@protocol LDContentViewProtocol <NSObject>

- (void)contentView:(LDContentView*)contentView progress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;
@optional
- (void)contentViewEndScroll:(LDContentView*)contentView;
@end
@interface LDContentView : UIView
@property(nonatomic,assign)id<LDContentViewProtocol>delegate;
- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray<UIViewController *> *)viewControllers parentVC:(UIViewController *)parentVC;
- (void)setCurrentIndex:(int)currentIndex;
@end
