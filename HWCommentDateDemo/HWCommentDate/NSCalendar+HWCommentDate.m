//
//  NSCalendar+HWCommentDate.m
//  BuDeJie
//
//  Created by 曹航玮 on 16/9/19.
//  Copyright © 2016年 曹航玮. All rights reserved.
//

#import "NSCalendar+HWCommentDate.h"

@implementation NSCalendar (HWCommentDate)

+ (NSString *)commentDateByOriginalDate:(NSString *)originalDate withDateFormat:(NSString *)dateFormat {
    
    if (!originalDate.length || !dateFormat.length) return nil;
    
    // 创建日期格式器
    NSDateFormatter * deteFormatter = [[NSDateFormatter alloc] init];
    deteFormatter.dateFormat = dateFormat;
    // 获得原始时间
    NSDate * originalTime = [deteFormatter dateFromString:originalDate];
    
    
    // 判断是否为同年
    if (![self isSameYearWithOriginalDate:originalTime]) return originalDate;
    
    // 详细日期判断
    if ([self isTheSameDayWithOriginalDate:originalTime]) { // 今天
        
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDateComponents * cmp = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:originalTime toDate:[NSDate date] options:NSCalendarWrapComponents];
        if (cmp.hour >= 1) { // 大于一小时
            
            deteFormatter.dateFormat = @"HH:mm";
            return [deteFormatter stringFromDate:originalTime];
        } else if (cmp.minute > 1) { // 小于一小时
            
            return [NSString stringWithFormat:@"%zd分钟前", cmp.minute];
        } else { // 小于一分钟
            return @"刚刚";
        }
        
    } else if ([self isTheYesterdayDayWithOriginalDate:originalTime]) { // 昨天
        
        deteFormatter.dateFormat = @"昨天 HH:mm:ss";
        return [deteFormatter stringFromDate:originalTime];
    } else { // 昨天之前
        
        deteFormatter.dateFormat = @"MM-dd HH:mm:ss";
        return [deteFormatter stringFromDate:originalTime];
    }
    
    
    return nil;
}


// 判断是否为同年
+ (BOOL)isSameYearWithOriginalDate:(NSDate *)originalDate {
    
    BOOL isSameYear = YES; // 是否为同一年
    // 获得当前时间
    NSDate * currentTime = [NSDate date];

    NSCalendar * calendar = [NSCalendar currentCalendar];
    // 当前年份
    NSInteger currentYear = [calendar components:NSCalendarUnitYear fromDate:currentTime].year;
    // 传入时间年份
    NSInteger originalYear = [calendar components:NSCalendarUnitYear fromDate:originalDate].year;
    
    // 判断是否为同一年
    if (currentYear < originalYear) { // 当前年份小于传入时间年份 返回nil 传入原始时间不正确
        
        return nil;
        
    } else if (currentYear > originalYear) {
        
        isSameYear = NO;
    }

    return isSameYear;
}


// 判断是否为今天
+ (BOOL)isTheSameDayWithOriginalDate:(NSDate *)originalDate {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:originalDate];
}

// 是否为昨天
+ (BOOL)isTheYesterdayDayWithOriginalDate:(NSDate *)originalDate {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    return [calendar isDateInYesterday:originalDate];
}

@end
