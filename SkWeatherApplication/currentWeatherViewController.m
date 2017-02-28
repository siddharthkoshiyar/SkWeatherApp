//
//  currentWeatherViewController.m
//  SkWeatherApplication
//
//  Created by Student P_04 on 31/01/17.
//  Copyright © 2017 TechnoMatrix. All rights reserved.
//

#import "currentWeatherViewController.h"
#define kUnitMetric @"metric"
#define kUnitImperial @"imperial"

@interface currentWeatherViewController ()

@end

@implementation currentWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *currentTemp = [[_currentDict valueForKey:@"main"]valueForKey:@"temp"];
    currentTemp = [self getTemperatureStringFromString:currentTemp unit:kUnitMetric];
    NSString *cityName = [_currentDict valueForKey:@"name"];
    NSString *currentMaxTemp = [[_currentDict valueForKey:@"main"]valueForKey:@"temp_max"];
    currentMaxTemp = [self getTemperatureStringFromString:currentMaxTemp unit:kUnitMetric];
    _nameOfCity.text = [NSString stringWithFormat:@"%@",cityName];
    _currentMaxTemp.text = [NSString stringWithFormat:@"%@",currentMaxTemp];
    _currentTemp.text = [NSString stringWithFormat:@"%@",currentTemp];
    NSString *day = [_currentDict valueForKey:@"dt"];
    day = [self convertUNIXTimeToDate:day];
    _dayToDate.text = [NSString stringWithFormat:@"%@",day];
    
}
-(NSString *)convertUNIXTimeToDate:(NSString *)dateString {
    NSTimeInterval timeInterval = dateString.doubleValue;
    
    NSDate *weatherDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    
    dateString = [dateFormatter stringFromDate:weatherDate];
    
    return dateString;
}
-(NSString *)getTemperatureStringFromString:(NSString *)tempString unit:(NSString *)unit {
    
    if ([unit isEqualToString:kUnitMetric]) {
        int temp = tempString.intValue;
        
        tempString = [NSString stringWithFormat:@"%d °C",temp];
        
        return tempString;
    }
    else if ([unit isEqualToString:kUnitImperial]) {
        int temp = tempString.intValue;
        
        tempString = [NSString stringWithFormat:@"%d °F",temp];
        
        return tempString;
    }
    else {
        int temp = tempString.intValue;
        tempString = [NSString stringWithFormat:@"%d K",temp];
        return tempString;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
