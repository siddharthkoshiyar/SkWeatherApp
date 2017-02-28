//
//  currentWeatherViewController.h
//  SkWeatherApplication
//
//  Created by Student P_04 on 31/01/17.
//  Copyright © 2017 TechnoMatrix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currentWeatherViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *currentTemp;
@property (strong, nonatomic) IBOutlet UILabel *currentMaxTemp;
@property (strong, nonatomic) IBOutlet UILabel *nameOfCity;
@property (strong, nonatomic) IBOutlet UILabel *dayToDate;
@property(nonatomic,strong)NSDictionary *currentDict;
@end
