//
//  ViewController.h
//  MKMapViewSample
//
//  Created by samayaaan on 12/09/16.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)nowLocation:(id)sender;

-(void) onResume;
-(void) onPause;

@end
