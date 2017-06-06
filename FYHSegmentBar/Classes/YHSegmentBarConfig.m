//
//  YHSegmentBarConfig.m
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/27.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import "YHSegmentBarConfig.h"

@implementation YHSegmentBarConfig

+ (instancetype)defaultConfig
{
    YHSegmentBarConfig *config = [[YHSegmentBarConfig alloc] init];
    config.segmentBarBackColor = [UIColor brownColor];
    
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor yellowColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.maxScale = 1;
    config.isNeedSacled = YES;
    
    config.indicatorBackColor = [UIColor redColor];
    config.isIndicatorShow = YES;
    config.indicatorH = 2;
    config.indicatorW = 10;
    
    config.isNeedCoverView = YES;
    // 遮盖的背景颜色默认为黑色
    config.coverBackColor = [UIColor blackColor];
    
    return config;
}

@end
