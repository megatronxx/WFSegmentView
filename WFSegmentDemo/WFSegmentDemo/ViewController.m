//
//  ViewController.m
//  WFSegmentDemo
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "WFSegmentView.h"
@interface ViewController ()
@property (nonatomic,strong) UIScrollView *contentSV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WFSegmentView *seg = [[WFSegmentView alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 60)];
    seg.titles = @[@"我会",@"你会忙",@"哈哈哈",@"我靠",@"我会",@"你会忙",@"哈哈哈",@"我靠",@"我会",@"你会忙",@"哈哈哈",@"我靠",@"我会",@"你会忙",@"哈哈哈",@"我靠"];
    seg.normalFont = [UIFont systemFontOfSize:16];
    seg.selectFont = [UIFont systemFontOfSize:20];
    seg.selectColor = [UIColor blueColor];
    [seg layoutSubviews];
    [self.view addSubview:seg];
    
    [self.view addSubview:self.contentSV];
    seg.contentSV = self.contentSV;
    
}

-(UIScrollView *)contentSV
{
    if (!_contentSV) {
        _contentSV = [UIScrollView new];
        _contentSV.frame = CGRectMake(0, 150, self.view.frame.size.width, 300);
        _contentSV.backgroundColor = [UIColor redColor];
        _contentSV.pagingEnabled = YES;
        _contentSV.bounces = NO;
    }
    return _contentSV;
}
@end
