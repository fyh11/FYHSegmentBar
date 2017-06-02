//
//  YHSegmentBarVC.h
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/26.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSegmentBar.h"

@interface YHSegmentBarVC : UIViewController

@property (nonatomic, weak) YHSegmentBar *segmentBar;

- (void)setUpItems: (NSArray <NSString *>*)items childVc: (NSArray<UIViewController *> *)childVc;

@end
