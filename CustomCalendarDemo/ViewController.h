//
//  ViewController.h
//  CustomCalendarDemo
//
//  Created by Junwei Lyu on 15/4/8.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRoadCalendarTableView.h"
#import "CalendarHeaderView.h"

@interface ViewController : UIViewController<TRoadCalendarTableViewDelegate>

@property (nonatomic, strong) TRoadCalendarTableView *calendarView;
@property (nonatomic, strong) CalendarHeaderView *calendarHeaderView;

@end

