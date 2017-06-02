//
//  YHSegmentBarVC.m
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/26.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import "YHSegmentBarVC.h"
#import "UIView+Extension.h"

@interface YHSegmentBarVC ()<UIScrollViewDelegate, YHsegmentBarDelegate>

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation YHSegmentBarVC

// 懒加载子控件segmentBar
- (YHSegmentBar *)segmentBar
{
    if (_segmentBar == nil) {
        YHSegmentBar *segmentBar = [YHSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        segmentBar.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        [self.view addSubview:contentView];
        contentView.pagingEnabled = YES;
        contentView.delegate = self;
        self.contentView = contentView;
    }
    return _contentView;
}

#pragma mark YHSegmentBarDelegate
- (void)segmentBar:(YHSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromeIndex:(NSInteger)fromeIndex
{
    [self showChildVcViewAtIndex: toIndex];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    self.segmentBar.selectIndex = index;
}

- (void)showChildVcViewAtIndex: (NSInteger)index
{
    if (self.childViewControllers.count == 0 || index < 0 || index > (self.childViewControllers.count - 1)) {
        return;
    }
    
    // 根据index取出对应的控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:YES];
}

- (void)setUpItems: (NSArray <NSString *>*)items childVc: (NSArray<UIViewController *> *)childVc
{
    NSAssert(items > 0 && items.count == childVc.count, @"个数不一致,请确认items和childVc的个数是否正确");
    self.segmentBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加新的控制器
    for (UIViewController *vc in childVc) {
        [self addChildViewController:vc];
    }
    
    // 设置contentView的contentSize
    self.contentView.contentSize =CGSizeMake(self.view.width * items.count, 0);
    self.segmentBar.selectIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        self.contentView.frame = CGRectMake(0, contentViewY, self.contentView.width, self.view.height - contentViewY);
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.contentView.width, 0);
    }
    
    CGRect contentFrame = CGRectMake(0, 60 ,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}


@end
