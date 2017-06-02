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
    YHSegmentBarConfig *cog = [[YHSegmentBarConfig alloc] init];
    cog.segmentBarBackColor = [UIColor brownColor];
    
    cog.itemNormalColor = [UIColor lightGrayColor];
    cog.itemSelectColor = [UIColor yellowColor];
    cog.itemFont = [UIFont systemFontOfSize:15];
    
    cog.indicatorBackColor = [UIColor redColor];
    cog.indicatorH = 2;
    cog.indicatorW = 10;
    return cog;
}

@end
