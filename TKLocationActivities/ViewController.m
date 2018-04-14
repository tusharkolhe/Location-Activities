//
//  ViewController.m
//  TKLocationActivities
//
//  Created by Tushar Kolhe on 14/04/18.
//  Copyright © 2018 Tushar Kolhe. All rights reserved.
//

#import "ViewController.h"
#import "CustomLocationVC.h"
@interface ViewController ()
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    float langvalue,latvalue;
    double latitude_UserLocation, longitude_UserLocation;
    NSString *longstr,*latstr,*locality,*cntry,*address;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setHidden:YES];

    geocoder = [[CLGeocoder alloc] init];
    _textView.editable = NO;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)locationBtn:(id)sender {
    [self startLocationUpdates];
}

- (void)startLocationUpdates
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    address = _textView.text;
}

#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager* )manager didUpdateLocations:(NSArray* )locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks, NSError* error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            latstr = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            //            NSLog(@"Latitude %@",latstr);
            latitude_UserLocation=newLocation.coordinate.latitude;
            NSLog(@"Latitude %f",latitude_UserLocation);
            longstr = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            longitude_UserLocation=newLocation.coordinate.longitude;
            NSLog(@"Longitude %f",longitude_UserLocation);
            

            
            NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            
            NSString *Address = [[NSString alloc]initWithString:locatedAt];
            NSLog(@"Full Address is %@",Address);
            
            NSString *postalCode=[@"\n" stringByAppendingString:placemark.postalCode];
            NSLog(@"PostalCode is %@",postalCode);
            
            _textView.text = [[[[[Address stringByAppendingString:postalCode] stringByAppendingString:@"\nLatitide: "] stringByAppendingString:[NSString stringWithFormat:@"%0.2f", latitude_UserLocation] ] stringByAppendingString:@"\nLongitude: "] stringByAppendingString:[NSString stringWithFormat:@"%0.2f", longitude_UserLocation]];

            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    
    [manager stopUpdatingLocation];
}

-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
    
}

- (IBAction)nextVC:(id)sender {
    CustomLocationVC *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CustomLocationVC"];
    //    ss.demo = [orders objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:rvc animated:YES];

//    CustomLocationVC *vc2 = [[CustomLocationVC alloc] init];
//    [self.navigationController pushViewController:vc2 animated:YES];
}
@end
