//
//  YHSegmentBar.m
//  YHSegmentBar
//
//  Created by 樊义红 on 17/5/25.
//  Copyright © 2017年 fyh11. All rights reserved.
//

#import "YHSegmentBar.h"
#import "UIView+Extension.h"

@interface YHSegmentBar ()
{
    UIButton *lastBtn;
}
@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

@property (nonatomic, weak) UIView *indictorView;

@property (nonatomic, strong) YHSegmentBarConfig *config;

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
    
    self.indictorView.backgroundColor = self.config.indicatorBackColor;
//    self.indictorView.height = self.config.indicatorH;
//    self.indictorView
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UIView *)indictorVIew
{
    if (_indictorView == nil) {
        CGFloat indictorHeigth = 2;
        UIView *indictorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indictorHeigth, 0, indictorHeigth)];
        indictorView.backgroundColor = self.config.indicatorBackColor;
        self.indictorView = indictorView;
        [self.contentView addSubview:indictorView];
    }
    
    return _indictorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
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
    
    _selectIndex = btn.tag;
    
    lastBtn.selected = NO;
    btn.selected = YES;
    lastBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indictorVIew.width = btn.width;
        self.indictorVIew.centerX = btn.centerX;
        
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
    self.indictorVIew.width = btn.width + self.config.indicatorW * 2;
    self.indictorVIew.centerX = btn.centerX;
    self.indictorView.height = self.config.indicatorH;
    self.indictorVIew.y = self.height - self.indictorVIew.height;
}

- (YHSegmentBarConfig *)config
{
    if (_config == nil) {
        _config = [YHSegmentBarConfig defaultConfig];
    }
    return _config;
}

@end
