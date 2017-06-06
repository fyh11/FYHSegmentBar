//
//  YHSegmentBarConfig.h
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/27.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YHSegmentBarConfig : NSObject

// 选项卡的背景颜色
@property (nonatomic, strong) UIColor *segmentBarBackColor;

// 选项卡文字正常状态下的颜色
@property (nonatomic, strong) UIColor *itemNormalColor;
// 选项卡文字选中状态下的颜色
@property (nonatomic, strong) UIColor *itemSelectColor;
// 选项卡文字大小
@property (nonatomic, strong) UIFont *itemFont;


// 指示器的背景颜色
@property (nonatomic, strong) UIColor *indicatorBackColor;
// 只是器的高度
@property (nonatomic, assign) CGFloat indicatorH;
// 指示器比按钮多出的长度(单面)
@property (nonatomic, assign) CGFloat indicatorW;
// 是否展示指示器(默认为yes)
@property (nonatomic, assign) BOOL isIndicatorShow;

// 选项卡按钮文字是否需要缩放
@property (nonatomic, assign) BOOL isNeedSacled;
// 选项卡字体缩放系数
@property (nonatomic, assign) CGFloat maxScale;

// 是否需要遮盖
@property (nonatomic, assign) BOOL isNeedCoverView;
// 遮盖的背景颜色
@property (nonatomic, strong) UIColor *coverBackColor;


+ (instancetype)defaultConfig;
@end
