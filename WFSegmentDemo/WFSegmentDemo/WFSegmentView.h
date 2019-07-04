//
//  WFSegmentView.h
//  WFSegmentDemo
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFSegmentView : UIView
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,weak) UIScrollView *contentSV;
@property (nonatomic,strong) UIFont *normalFont;
@property (nonatomic,strong) UIFont *selectFont;
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectColor;
@property (nonatomic,strong) UIView *lineV;
@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,assign) NSInteger specialIndex;
@property (nonatomic,strong) UIFont *specialNormalFont;
@property (nonatomic,strong) UIFont *specialSelectFont;
@end

NS_ASSUME_NONNULL_END
