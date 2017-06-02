//
//  YHSegmentBar.h
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/25.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSegmentBarConfig.h"

@class YHSegmentBar;

@protocol YHsegmentBarDelegate <NSObject>

- (void)segmentBar: (YHSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromeIndex: (NSInteger)fromeIndex;

@end

@interface YHSegmentBar : UIView

+ (YHSegmentBar *)segmentBarWithFrame: (CGRect)frame;

@property (nonatomic, strong) NSArray <NSString *>*items;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id<YHsegmentBarDelegate> delegate;

- (void)updateConfigWith: (void(^)(YHSegmentBarConfig *config))segmentBarCog;

@end
