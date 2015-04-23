//
//  CalendarHeaderView.m
//  CustomCalendarDemo
//
//  Created by Junwei Lyu on 15/4/13.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "CalendarHeaderView.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation CalendarHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = RGB(250, 239, 226);
        
        _titleLabel = [[UILabel alloc]initWithFrame:frame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _titleLabel.textColor = RGB(167, 167, 167);
        if (CGAffineTransformEqualToTransform(_titleLabel.transform, CGAffineTransformIdentity))
        {
            int xOrigin	= (_titleLabel.bounds.size.width - _titleLabel.bounds.size.height) / 2.0;
            int yOrigin	= (_titleLabel.bounds.size.height - _titleLabel.bounds.size.width) / 2.0;
            _titleLabel.frame = CGRectMake(xOrigin, yOrigin, _titleLabel.bounds.size.height, _titleLabel.bounds.size.width);
            _titleLabel.transform = CGAffineTransformMakeRotation(M_PI/ -2.0);
        }
        [self addSubview:_titleLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width - 1, 0, 1, frame.size.height - 1)];
        _lineView.backgroundColor = RGB(225, 215, 202);
        [self addSubview:_lineView];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    [super layoutSubviews];
}

@end
