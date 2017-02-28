//
//  coustomCell.h
//  SkWeatherApplication
//
//  Created by Student P_04 on 31/01/17.
//  Copyright © 2017 TechnoMatrix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *day;
@property (strong, nonatomic) IBOutlet UILabel *maxTemp;
@property (strong, nonatomic) IBOutlet UILabel *minTemp;

@end
