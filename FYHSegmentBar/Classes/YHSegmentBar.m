//
//  YHSegmentBar.m
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/25.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import "YHSegmentBar.h"
#import "UIView+Extension.h"

@interface YHSegmentBar ()<UIScrollViewDelegate>
{
    UIButton *lastBtn;
    
    CGFloat _startOffX;
}
@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

@property (nonatomic, weak) UIView *indictorView;

@property (nonatomic, strong) YHSegmentBarConfig *config;

@property (nonatomic, weak) UIView *coverView;

@end

@implementation YHSegmentBar

+ (YHSegmentBar *)segmentBarWithFrame: (CGRect)frame
{
    YHSegmentBar *segmentBar = [[YHSegmentBar alloc] initWithFrame:frame];
    
    return segmentBar;
}

- (NSArray<UIButton *> *)itemBtns
{
    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray array];
     }
    return _itemBtns;
}

- (UIView *)coverView
{
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _coverView = coverView;
        coverView.backgroundColor = self.config.coverBackColor;
        coverView.layer.cornerRadius = 12.0;
        coverView.alpha = 0.7;
        coverView.clipsToBounds = YES;
        [self.contentView insertSubview:coverView atIndex:0];
    }
    return _coverView;
}

- (void)updateConfigWith: (void(^)(YHSegmentBarConfig *config))segmentBarCog
{
    if (segmentBarCog) {
        segmentBarCog(self.config);
    }
    
    self.backgroundColor = self.config.segmentBarBackColor;
    
    for (UIButton *btn in _itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    
    if (self.config.isIndicatorShow) {
    self.indictorView.backgroundColor = self.config.indicatorBackColor;
//    self.indictorView.height = self.config.indicatorH;
//    self.indictorView
    }else{
        [self.indictorView removeFromSuperview];
        self.indictorView = nil;
    }
    
    if (self.config.isNeedCoverView) {
        self.coverView.backgroundColor = self.config.coverBackColor;
    }else{
        [self.coverView removeFromSuperview];
        self.coverView = nil;
    }
    
    if (self.config.isNeedSacled) {
        lastBtn.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UIView *)indictorVIew
{
    if (self.config.isIndicatorShow) {
    if (_indictorView == nil) {
        CGFloat indictorHeigth = 2;
        UIView *indictorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indictorHeigth, 0, indictorHeigth)];
        indictorView.backgroundColor = self.config.indicatorBackColor;
        self.indictorView = indictorView;
        [self.contentView addSubview:indictorView];
    }
    
    return _indictorView;
    }
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = self.config.segmentBarBackColor;
    }
    return self;
}

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *item in items) {
        UIButton *itemBtn = [[UIButton alloc] init];
        itemBtn.tag = self.itemBtns.count;
        [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [itemBtn setTitle:item forState:UIControlStateNormal];
        [itemBtn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [itemBtn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        [self.contentView addSubview:itemBtn];
        [self.itemBtns addObject:itemBtn];
    }
    
    // 手动刷新
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 过滤selectIndex
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    
    _selectIndex = selectIndex;
    
    UIButton *btn = self.itemBtns[selectIndex];
    [self itemBtnClick:btn];
}

- (void)itemBtnClick: (UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromeIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:btn.tag fromeIndex:lastBtn.tag];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.config.isNeedSacled) {
        
        lastBtn.transform = CGAffineTransformIdentity;
        lastBtn.y = 0;
        btn.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
        }
    }];
    
    _selectIndex = btn.tag;
    
    lastBtn.selected = NO;
    btn.selected = YES;
    lastBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.config.isIndicatorShow) {
        self.indictorVIew.width = btn.width;
        self.indictorVIew.centerX = btn.centerX;
        }
            
        if (self.config.isNeedCoverView) {
        self.coverView.width = btn.width;
        self.coverView.centerX = btn.centerX;
        self.coverView.height = btn.height - 8;
        self.coverView.centerY = btn.centerY;
        }
    }];
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width){
        
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    // 计算选项卡按钮组之间的margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat margin = (self.width - totalBtnWidth) / (self.items.count + 1);
    CGFloat minMargin = 30;
    
    if (minMargin > margin) {
        margin = minMargin;
    }
    
    CGFloat lastX = margin;
    for (UIButton *btn in _itemBtns) {

        // width  height
        [btn sizeToFit];
        
        // x y
        btn.y = 0;
        btn.x = lastX;
        
        lastX += margin + btn.width;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns <= 0) {
        return;
    }
    
    UIButton *btn = self.itemBtns[self.selectIndex];
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.config.isNeedSacled) {
            
            lastBtn.transform = CGAffineTransformIdentity;
            lastBtn.y = 0;
            btn.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
        }
    }];
    
    if (self.config.isIndicatorShow) {
    self.indictorVIew.width = btn.width + self.config.indicatorW * 2;
    self.indictorVIew.centerX = btn.centerX;
    self.indictorView.height = self.config.indicatorH;
    self.indictorVIew.y = self.height - self.indictorVIew.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.config.isNeedCoverView) {
            self.coverView.width = btn.width;
            self.coverView.centerX = btn.centerX;
            self.coverView.height = btn.height - 8;
            self.coverView.centerY = btn.centerY;
        }
    }];
}

- (YHSegmentBarConfig *)config
{
    if (_config == nil) {
        _config = [YHSegmentBarConfig defaultConfig];
    }
    return _config;
}

@end
