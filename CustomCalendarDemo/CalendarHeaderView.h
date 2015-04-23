//
//  CalendarHeaderView.h
//  CustomCalendarDemo
//
//  Created by Junwei Lyu on 15/4/13.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarHeaderView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
 
- (id)initWithFrame:(CGRect)frame;

@end
