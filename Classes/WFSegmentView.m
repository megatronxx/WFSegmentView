//
//  WFSegmentView.m
//  WFSegmentDemo
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WFSegmentView.h"

@interface WFSegmentView ()<UIScrollViewDelegate>
{
    CGFloat fromFontSize;
    CGFloat toFontSize;
}
@property (nonatomic,strong) UIScrollView *titleSV;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *itemFonts;
@end

@implementation WFSegmentView
#pragma mark - event
-(void)btnSelect:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (tag == _currentIndex) {
        
    }else{
        self.currentIndex = tag;
        //
        [_contentSV setContentOffset:CGPointMake(_currentIndex * _contentSV.frame.size.width, 0)];
    }
}
#pragma mark - method
#pragma mark - life
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleSV];
        self.titleSV.frame = self.bounds;
        [self.titleSV addSubview:self.lineV];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.titleSV.frame = self.bounds;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIButton *btn in self.items) {
        [btn removeFromSuperview];
    }
    CGFloat fwidth = 0;
    NSMutableArray *marr = [NSMutableArray new];
    NSMutableArray *fmarr = [NSMutableArray new];
    for (NSInteger i = 0; i < _titles.count; i++) {
        NSString *title = _titles[i];
        UIButton *btn = [UIButton new];
        btn.tag = i;
        CGFloat width = title.length * self.selectFont.pointSize  + 10;
        if (i == _specialIndex) {
            btn.titleLabel.font = self.specialNormalFont;
            width = title.length * self.specialSelectFont.pointSize  + 10;
        }else{
            btn.titleLabel.font = self.normalFont;
            width = title.length * self.selectFont.pointSize  + 10;
        }
        
        CGFloat height = self.frame.size.height;
        CGFloat xx = fwidth;
        btn.frame = CGRectMake(xx, 0, width, height);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleSV addSubview:btn];
        [marr addObject:btn];
        fwidth += width;
        if (i == _titles.count - 1) {
            self.titleSV.contentSize = CGSizeMake(fwidth, 0);
        }
        [fmarr addObject:btn.titleLabel.font];
    }
    self.items = marr;
    self.itemFonts = fmarr;
    CGFloat yy = self.frame.size.height - self.lineV.frame.size.height;
    self.lineV.frame = CGRectMake(self.lineV.frame.origin.x, yy, self.lineV.frame.size.width, self.lineV.frame.size.height);
    self.currentIndex = _currentIndex;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - delegate
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_contentSV == scrollView) {
        CGFloat mark = scrollView.contentOffset.x - _currentIndex * scrollView.frame.size.width;
        NSInteger oritaion = mark > 0 ? 1 : (mark == 0 ? 0 : -1);
        NSInteger toIndex = _currentIndex + oritaion;
//        NSLog(@"current index: %ld",_currentIndex);
//        NSLog(@"to index: %ld",toIndex);
        UIButton *toBtn = self.items[toIndex];
        UIButton *fromBtn = self.items[_currentIndex];
        CGFloat mScale = mark / scrollView.frame.size.width;
        CGFloat linevoffset = mScale * toBtn.frame.size.width;
//        NSLog(@"linevoffset: %.2f",linevoffset);
        self.lineV.center = CGPointMake(fromBtn.frame.origin.x + fromBtn.frame.size.width / 2 + linevoffset, self.lineV.center.y);
//        NSLog(@"mScale: %.2f",mScale);
        CGFloat fromscale = fabs(mScale);
        CGFloat toscale = fabs(mScale);
        UIFont *fromfont = self.itemFonts[_currentIndex];
        UIFont *fromnormalfont = _currentIndex == _specialIndex ? self.specialNormalFont : self.normalFont;
        CGFloat fromfontchange = fromfont.pointSize - (fromfont.pointSize - fromnormalfont.pointSize) * fromscale;
//        NSLog(@"fromfontchange: %.2f",fromfontchange);
        fromBtn.titleLabel.font = [UIFont systemFontOfSize:fromfontchange];
        
        UIFont *tofont = self.itemFonts[toIndex];
        UIFont *toselectfont = toIndex == _specialIndex ? self.specialSelectFont : self.selectFont;
        CGFloat tofontchange = (toselectfont.pointSize - tofont.pointSize) * toscale + tofont.pointSize;
//        NSLog(@"tofontchange: %.2f",tofontchange);
        toBtn.titleLabel.font = [UIFont systemFontOfSize:tofontchange];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_contentSV == scrollView) {
        CGFloat pageWidth =_contentSV.frame.size.width; //scrollView
        NSInteger page = floor((scrollView.contentOffset.x - pageWidth /2) / pageWidth) +1;
        self.currentIndex = page;
    }
}
#pragma mark - getter and setter
-(UIScrollView *)titleSV
{
    if (!_titleSV) {
        _titleSV = [UIScrollView new];
        _titleSV.frame = self.bounds;
        _titleSV.delegate = self;
        _titleSV.backgroundColor = [UIColor lightGrayColor];
        _titleSV.userInteractionEnabled = YES;
        _titleSV.bounces = NO;
        _titleSV.showsHorizontalScrollIndicator = NO;
    }
    return _titleSV;
}
-(UIFont *)normalFont
{
    if (!_normalFont) {
        _normalFont = [UIFont systemFontOfSize:13];
    }
    return _normalFont;
}
-(UIFont *)selectFont
{
    if (!_selectFont) {
        _selectFont = [UIFont systemFontOfSize:16];
    }
    return _selectFont;
}
-(UIFont *)specialNormalFont
{
    if (!_specialNormalFont) {
        _specialNormalFont = [UIFont systemFontOfSize:16];
    }
    return _specialNormalFont;
}
-(UIFont *)specialSelectFont
{
    if (!_specialSelectFont) {
        _specialSelectFont = [UIFont systemFontOfSize:19];
    }
    return _specialSelectFont;
}
-(UIColor *)normalColor
{
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}
-(UIColor *)selectColor
{
    if (!_selectColor) {
        _selectColor = [UIColor redColor];
    }
    return _selectColor;
}
-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.frame = CGRectMake(0, 0, 40, 5);
        _lineV.backgroundColor = self.selectColor;
    }
    return _lineV;
}

-(void)setTitles:(NSMutableArray *)titles
{
    _titles = titles;
}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    for (NSInteger i = 0; i < self.items.count; i++) {
        UIButton *btn = self.items[i];
        if (_currentIndex == btn.tag) {
            btn.selected = YES;
            btn.titleLabel.font = self.selectFont;
        }else{
            btn.selected = NO;
            btn.titleLabel.font = self.normalFont;
        }
        
        if (btn.tag ==_specialIndex) {
            if (btn.selected) {
                btn.titleLabel.font = self.specialSelectFont;
            }else{
                btn.titleLabel.font = self.specialNormalFont;
            }
        }
        [self.itemFonts setObject:btn.titleLabel.font atIndexedSubscript:i];
    }
    UIButton *btn = self.items[_currentIndex];
    self.lineV.center = CGPointMake(btn.frame.origin.x + btn.frame.size.width / 2, self.lineV.center.y);
    self.lineV.frame = CGRectMake(self.lineV.frame.origin.x, self.lineV.frame.origin.y, btn.frame.size.width / 2, self.lineV.frame.size.height);
    CGRect rect = [self.titleSV convertRect:btn.frame toView:self];
    if (rect.origin.x + rect.size.width > self.titleSV.frame.origin.x + self.titleSV.frame.size.width) {
        CGFloat offsetx = btn.frame.origin.x;
        [self.titleSV setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    }else if (rect.origin.x < self.titleSV.frame.origin.x) {
        CGFloat offsetx = rect.origin.x;
        [self.titleSV setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    }
}
-(void)setContentSV:(UIScrollView *)contentSV
{
    _contentSV = contentSV;
    _contentSV.contentSize = CGSizeMake(_contentSV.frame.size.width * _titles.count, 0);
    _contentSV.delegate = self;
}
@end
