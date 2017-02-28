//
//  ViewController.m
//  SkWeatherApplication
//
//  Created by Student P_04 on 31/01/17.
//  Copyright © 2017 TechnoMatrix. All rights reserved.
//
#define kAPIKey @"84cd6f22b7d6d482e8d5b245d43e9cce"
#define kUnitMetric @"metric"
#define kUnitImperial @"imperial"
#import "ViewController.h"
#import "coustomCell.h"
#import "currentWeatherViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateLocatoin];
    
    
}
-(void)updateLocatoin{
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    
    [locationManager startUpdatingLocation];
    
    if (flage) {
        [self latitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        
    }else{
        [self getForcastOfDays:7 APIKey:kAPIKey units:kUnitMetric latitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        
     }

}
-(void)latitude:(double)latitude
      longitude:(double)longitude{
    weatherUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&APPID=84cd6f22b7d6d482e8d5b245d43e9cce&units=metric",latitude,longitude];
    [self parseJson];
    
    
}
-(void)getForcastOfDays:(int)day
                 APIKey:(NSString *)key
                  units:(NSString *)unit
               latitude:(double)latitude
              longitude:(double)longitude
{
    
    
        urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&APPID=%@&units=%@&cnt=%d",latitude,longitude,key,unit,day];
        [self parseJson];
    
    
   
}
-(void)parseJson{
    NSString *string = [[NSString alloc]init];
    if (flage) {
        
        string = [NSString stringWithFormat:@"%@",weatherUrl];
        
        }else{
             string = [NSString stringWithFormat:@"%@",urlString];
            }
    NSURL *url = [NSURL URLWithString:string];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *mydata,NSURLResponse*myResponce,NSError *error){
        if (mydata != nil) {
            dictionary = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
            NSLog(@"%@",dictionary);
            if (flage) {
                [self performSegueWithIdentifier:@"segue" sender:self];
                flage = NO;
                [self updateLocatoin];
                
            }else{
                [_tableView reloadData];
            }
            
            
           // NSLog(@"%@",dictionary);
        } else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    [dataTask resume];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segue"]) {
        
        // Get destination view
        currentWeatherViewController *vc = [segue destinationViewController];
        vc.currentDict = [dictionary mutableCopy];
           }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
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




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dictionary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"Cell";
    coustomCell *cell = [_tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[coustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    array = [[dictionary valueForKey:@"list"]valueForKey:@"temp"];
    
    dayArray = [[[dictionary valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"dt"];
    NSString *cityName = [NSString stringWithFormat:@"%@",  [[dictionary valueForKey:@"city"]valueForKey:@"name" ]];
    
    cell.city.text = [NSString stringWithFormat:@"%@",cityName];
    
    NSString *strOne = [[array objectAtIndex:indexPath.row]valueForKey:@"max"];
    strOne = [self getTemperatureStringFromString:strOne unit:kUnitMetric];
    
    //NSLog(@"%@",strOne);
    NSString *strTwo = [[array objectAtIndex:indexPath.row]valueForKey:@"min"];
    strTwo = [self getTemperatureStringFromString:strTwo unit:kUnitMetric];
    NSString *day = [NSString stringWithFormat:@"%@",dayArray];
    day = [self convertUNIXTimeToDate:day];
    cell.day.text = [NSString stringWithFormat:@"%@",day];
    cell.maxTemp.text = [NSString stringWithFormat:@"%@",strOne];
    cell.minTemp.text = [NSString stringWithFormat:@"%@",strTwo];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)currentWeatherAction:(id)sender {
    flage = YES;
    [self updateLocatoin];
    
}
@end
