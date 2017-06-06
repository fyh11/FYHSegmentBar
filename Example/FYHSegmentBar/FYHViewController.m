//
//  FYHViewController.m
//  FYHSegmentBar
//
//  Created by fyh11 on 05/31/2017.
//  Copyright (c) 2017 fyh11. All rights reserved.
//

#import "FYHViewController.h"
#import <FYHSegmentBar/YHSegmentBarVC.h>

@interface FYHViewController ()

@property (nonatomic, weak) YHSegmentBarVC *segmentBarVC;

@end

@implementation FYHViewController

#pragma mark -- 懒加载segmentBarVC
- (YHSegmentBarVC *)segmentBarVC
{
    if (_segmentBarVC == nil) {
        YHSegmentBarVC *vc = [[YHSegmentBarVC alloc] init];
        [self addChildViewController:vc];
        self.segmentBarVC = vc;
    }
    
    return _segmentBarVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 35);
    self.segmentBarVC.segmentBar.backgroundColor = [UIColor greenColor];
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    
    NSArray *items = @[@"推荐",@"热点",@"直播",@"视频",@"阳光视频",@"社会热点",@"娱乐",@"科技",@"汽车"];
    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<items.count; i++) {
        UITableViewController * vc=[[UITableViewController alloc]init];
        vc.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        [childVcs addObject:vc];
    }
    
    [self.segmentBarVC setUpItems:items childVc:childVcs];

    [self.segmentBarVC.segmentBar updateConfigWith:^(YHSegmentBarConfig *config) {
        
        config.segmentBarBackColor = [UIColor redColor];
        
        // 正常状态下选项卡字体的颜色
        config.itemNormalColor = [UIColor greenColor];
        // 选中状态下选项卡字体的颜色
        config.itemSelectColor = [UIColor yellowColor];
        // 选项卡字体的大小
        config.itemFont = [UIFont systemFontOfSize:16];
        
        config.indicatorH = 2;
        config.indicatorW = 10;
        config.indicatorBackColor = [UIColor brownColor];
        // 是否显示指示器
        config.isIndicatorShow = YES;
        
        config.isNeedSacled = YES;
        config.maxScale = 1.2;
        
        config.coverBackColor = [UIColor blueColor];
        config.isNeedCoverView = YES;
    }];
}

@end
