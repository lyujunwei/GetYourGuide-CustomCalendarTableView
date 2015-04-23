//
//  ViewController.m
//  CustomCalendarDemo
//
//  Created by Junwei Lyu on 15/4/8.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewCell.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kWidth                [UIScreen mainScreen].bounds.size.width
#define kHeight               [UIScreen mainScreen].bounds.size.height
const NSTimeInterval kSecondsInDay = 86400;
const CGFloat kDIDatepickerSpaceBetweenItems = 15.;

@interface ViewController () {
    NSMutableArray *weekdays;
    NSMutableArray *months;
    
    NSInteger todayDate;
    
    NSInteger rowNum;
    NSInteger sectionNum;
    NSMutableDictionary *dict;
    NSMutableDictionary *weekDict;
    
    NSMutableDictionary *yearDict;
    NSMutableArray *years;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    weekdays = [NSMutableArray new];
    years = [NSMutableArray new];
    months = [NSMutableArray new];
    dict = [NSMutableDictionary new];
    weekDict = [NSMutableDictionary new];
    yearDict = [NSMutableDictionary new];
    _calendarView = [[TRoadCalendarTableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, 44)];
    _calendarView.delegate = self;
    [self.view addSubview:_calendarView];
    
    [self fillDatesFromCurrentDate:180];
}

- (void)fillDatesFromCurrentDate:(NSInteger)nextDatesCount
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger day = 0; day < nextDatesCount; day++) {
        [dates addObject:[NSDate dateWithTimeIntervalSinceNow:day * kSecondsInDay]];
    }

    NSString *lastMonth = [NSString new];
    
    for (NSInteger index = 0 ; index < dates.count; index++) {
        NSDate *date = dates[index];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *yearFormattedString = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"dd"];
        NSString *dayFormattedString = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"EEE"];
        NSString *dayInWeekFormattedString = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"MMM"];
        NSString *monthFormattedString = [[dateFormatter stringFromDate:date] uppercaseString];
        
        if (index == 0) {
            todayDate = [dayFormattedString integerValue];
        }
        
        if (![monthFormattedString isEqualToString:lastMonth]) {
            [months addObject:monthFormattedString];
            weekdays = [NSMutableArray array];
            years = [NSMutableArray array];
        }
        
        NSMutableArray *arrayCities = [NSMutableArray array];
        if ([monthFormattedString isEqualToString:lastMonth] || index == 0 || [dayFormattedString isEqualToString:@"01"]) {
            [arrayCities addObject:dayFormattedString];
            [weekdays addObject:dayInWeekFormattedString];
            [years addObject:yearFormattedString];
        }
        
        lastMonth = monthFormattedString;
        [dict setObject:arrayCities forKey:monthFormattedString];
        [weekDict setObject:weekdays forKey:monthFormattedString];
        [yearDict setObject:years forKey:monthFormattedString];
    }
    
}

#pragma mark - TRoadCalendarTableViewDelegate
- (NSInteger)tableView:(TRoadCalendarTableView *)calendarTableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            NSInteger count = [[[dict valueForKey:months[0]]firstObject]integerValue];
            return count - todayDate + 1;
        }
            break;
        default:
        {
            return  [[[dict valueForKey:months[section]]firstObject]integerValue];
        }
            break;
    }
}

- (NSUInteger)numberOfSectionsInTableView:(TRoadCalendarTableView *)calendarTableView {
    return months.count;
}

- (UITableViewCell *)tableView:(TRoadCalendarTableView *)calendarTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarViewCell *cell = [calendarTableView.tableView dequeueReusableCellWithIdentifier:@"CalendarViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CalendarViewCell" owner:self options:nil] lastObject];
    }
    
    cell.dayLabel.text = [weekDict valueForKey:months[indexPath.section]][indexPath.row];
    switch (indexPath.section) {
        case 0:
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",todayDate + indexPath.row];
        }
            break;
        default:
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        }
            break;
    }
    
    if (rowNum == indexPath.row && sectionNum == indexPath.section) {
        cell.icon_image.hidden = NO;
        cell.dayLabel.textColor = RGB(255, 255, 255);
        cell.dateLabel.textColor = RGB(255, 255, 255);
    } else {
        cell.icon_image.hidden = YES;
        cell.dayLabel.textColor = RGB(192, 192, 192);
        cell.dateLabel.textColor = RGB(0, 0, 0);
    }
    
    return cell;
}

- (CGFloat)tableView:(TRoadCalendarTableView *)calendarTableView widthForCellAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView*)tableView:(TRoadCalendarTableView *)calendarTableView viewForHeaderInSection:(NSInteger)section{
    _calendarHeaderView = [[CalendarHeaderView alloc]initWithFrame:CGRectMake(0, 0, 26, 44)];
    _calendarHeaderView.title = [NSString stringWithFormat:@"%@",months[section]];
    return _calendarHeaderView;
}

- (void)tableView:(TRoadCalendarTableView *)calendarTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    rowNum = indexPath.row;
    sectionNum = indexPath.section;
    
    NSString *time;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [calendarTableView.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    NSString *string = months[indexPath.section];
    int b= [[string substringWithRange:NSMakeRange(0,[string length] - 1)] intValue];
    
    NSString *monthString;
    if ( b < 10 ) {
        monthString = [NSString stringWithFormat:@"0%d",b];
    } else {
        monthString = [NSString stringWithFormat:@"%d",b];
    }

    NSInteger day;
    if (indexPath.section == 0) {
        day = indexPath.row + todayDate;
    } else {
        day = indexPath.row + 1;
    }
    
    NSString *dayString;
    if (day < 10) {
        dayString = [NSString stringWithFormat:@"0%ld",(long)day];
    } else {
        dayString = [NSString stringWithFormat:@"%ld",(long)day];
    }
    
    time = [NSString stringWithFormat:@"%@%@%@",[yearDict valueForKey:months[indexPath.section]][indexPath.row],monthString,dayString];

    NSLog(@"你选中 -> %@",time );
    
    CalendarViewCell *cell = (CalendarViewCell *)[calendarTableView.tableView cellForRowAtIndexPath:indexPath];
    cell.icon_image.hidden = NO;
    cell.dayLabel.textColor = RGB(255, 255, 255);
    cell.dateLabel.textColor = RGB(255, 255, 255);
    [calendarTableView.tableView reloadData];
}

- (void)tableView:(TRoadCalendarTableView *)calendarTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarViewCell *cell = (CalendarViewCell *)[calendarTableView.tableView cellForRowAtIndexPath:indexPath];
    cell.icon_image.hidden = YES;
    cell.dayLabel.textColor = RGB(192, 192, 192);
    cell.dateLabel.textColor = RGB(0, 0, 0);
    [calendarTableView.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
