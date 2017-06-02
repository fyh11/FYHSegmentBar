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

@property (nonatomic, strong) UIColor *segmentBarBackColor;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIFont *itemFont;

@property (nonatomic, strong) UIColor *indicatorBackColor;
@property (nonatomic, assign) CGFloat indicatorH;
@property (nonatomic, assign) CGFloat indicatorW;


+ (instancetype)defaultConfig;
@end
