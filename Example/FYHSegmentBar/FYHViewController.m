//
//  FYHViewController.m
//  FYHSegmentBar
//
//  Created by fyh11 on 05/31/2017.
//  Copyright (c) 2017 fyh11. All rights reserved.
//

#import "FYHViewController.h"
#import "YHSegmentBarVC.h"


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
    
    
    NSArray *items = @[@"hh", @"gg", @"dd",@"ee",@"ll",@"kk"];
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc6 = [UIViewController new];
    vc6.view.backgroundColor = [UIColor yellowColor];
    
    [self.segmentBarVC setUpItems:items childVc:@[vc1,vc2,vc3,vc4,vc5,vc6]];

}

@end
