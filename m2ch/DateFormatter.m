//
//  DateFormatter.m
//  Tabula
//
//  Created by Alexander Tewpin on 02/08/14.
//  Copyright (c) 2014 Alexander Tewpin. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+(NSString *)dateFromTimestamp:(NSInteger)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSCalendarUnit units = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date toDate:[NSDate date] options:0];
    NSDateComponents *yearComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *currentYearComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (yearComponent.year != currentYearComponent.year) {
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"dd.MM.yy"];
        return [formatter stringFromDate:date];
    } else if (components.month > 1) {
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"dd.MM"];
        return [formatter stringFromDate:date];
    } else if (components.day > 1) {
        return [NSString stringWithFormat:@"%ld д.", components.day];
    } else if (components.hour > 1) {
        return [NSString stringWithFormat:@"%ld ч.", components.hour];
    } else if (components.minute > 1){
        return [NSString stringWithFormat:@"%ld мин.", components.minute];
    } else if (components.second > 15){
        return [NSString stringWithFormat:@"%ld сек.", components.second];
    } else {
        return @"Только что";
    }
    return [NSString stringWithFormat:@"%ld %ld", (long)components.minute, (long)components.second];
}

@end
