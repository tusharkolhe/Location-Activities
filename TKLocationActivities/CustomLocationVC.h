//
//  CustomLocationVC.h
//  LocationDemo
//
//  Created by Tushar Kolhe on 14/04/18.
//  Copyright © 2018 Sysfort Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CustomLocationVC : UIViewController<CLLocationManagerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)getBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
