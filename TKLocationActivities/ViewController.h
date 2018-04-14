//
//  ViewController.h
//  TKLocationActivities
//
//  Created by Tushar Kolhe on 14/04/18.
//  Copyright © 2018 Tushar Kolhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

- (IBAction)locationBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

