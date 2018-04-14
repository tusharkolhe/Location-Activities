//
//  CustomLocationVC.m
//  LocationDemo
//
//  Created by Tushar Kolhe on 14/04/18.
//  Copyright © 2018 Sysfort Systems. All rights reserved.
//

#import "CustomLocationVC.h"

@interface CustomLocationVC ()
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    float langvalue,latvalue;
    double latitude_UserLocation, longitude_UserLocation;
    NSString *longstr,*latstr,*locality,*cntry,*address;
}

@end

@implementation CustomLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:NO];

    geocoder = [[CLGeocoder alloc] init];
    _textView.editable = NO;
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
- (IBAction)getBtn:(id)sender {
    
    NSString *address=_textField.text;
    
    CLLocationCoordinate2D coordinates = [self getLocationFromAddressString:address];
    
    NSLog(@"Lati %f", coordinates.latitude);
    NSLog(@"Longi %f", coordinates.longitude);
    
    _textView.text = [[[@"Latitude: " stringByAppendingString:[NSString stringWithFormat:@"%0.2f", coordinates.latitude]] stringByAppendingString:@"\nLongitude: "] stringByAppendingString:[NSString stringWithFormat:@"%0.2f", coordinates.longitude]];
}
@end
