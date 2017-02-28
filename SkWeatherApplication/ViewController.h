//
//  ViewController.h
//  SkWeatherApplication
//
//  Created by Student P_04 on 31/01/17.
//  Copyright © 2017 TechnoMatrix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSArray *array;
    NSArray *dayArray;
    NSDictionary *dictionary;
    NSString *weatherUrl;
    NSString *urlString;
    BOOL flage;
    
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)currentWeatherAction:(id)sender;


@end

