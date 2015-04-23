//
//  TRoadCalendarTableView.h
//  CustomCalendarDemo
//
//  Created by Junwei Lyu on 15/4/8.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRoadCalendarTableView;

@protocol TRoadCalendarTableViewDelegate <NSObject>

- (NSInteger)tableView:(TRoadCalendarTableView *)calendarTableView
 numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(TRoadCalendarTableView *)calendarTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSUInteger)numberOfSectionsInTableView:(TRoadCalendarTableView *)calendarTableView;

- (void)tableView:(TRoadCalendarTableView *)calendarTableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(TRoadCalendarTableView *)calendarTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView*)tableView:(TRoadCalendarTableView*)calendarTableView
viewForHeaderInSection:(NSInteger)section;

- (UIView*)tableView:(TRoadCalendarTableView*)calendarTableView
viewForFooterInSection:(NSInteger)section;

- (CGFloat)tableView:(TRoadCalendarTableView *)calendarTableView
widthForCellAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TRoadCalendarTableView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet id<TRoadCalendarTableViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic) CGFloat rowWidth;
@property (nonatomic, readonly) CGSize contentSize;
@property (nonatomic) CGPoint contentOffset;
- (void)setContentOffset:(CGPoint)offset
                animated:(BOOL)animated;

@end
