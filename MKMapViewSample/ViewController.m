//
//  ViewController.m
//  MKMapViewSample
//
//  Created by samayaaan on 12/09/16.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import "ViewController.h"

#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"

@implementation ViewController

@synthesize locationManager;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [mapView setDelegate: self];
    locationManager = [[CLLocationManager alloc] init];
    
    // 現在地系
    // 位置情報サービスが利用できるかどうかをチェック
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        // 測位開始
//        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services not available.");
    }
    
    // 指定地系
    // 地図の表示位置と縮尺設定
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(35.681666,139.764869);
    MKCoordinateRegion region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.01, 0.01));
    [mapView setCenterCoordinate:location];
    [mapView setRegion:region];
    
    // ピンの地図表示
    [mapView addAnnotation:
     [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.685623,139.763153)
                                                    title:@"大手町駅"
                                                 subtitle:@"千代田線・半蔵門線・丸ノ内線・東西線・三田線"]];
    [mapView addAnnotation:
     [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.690747,139.756866)
                                                    title:@"竹橋駅"
                                                 subtitle:@"東西線"]];
    [mapView addAnnotation:
     [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.681666,139.764869)
                                                    title:@"東京駅"
                                                 subtitle:@"いっぱい"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// 現在地系：情報更新時
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    //緯度・経度を出力
    NSLog(@"didUpdateToLocation latitude=%f, longitude=%f",
          [newLocation coordinate].latitude,
          [newLocation coordinate].longitude);
    
    // 地図の表示位置と縮尺設定
    MKCoordinateRegion region2 = MKCoordinateRegionMake([newLocation coordinate], [mapView region].span);
    [mapView setCenterCoordinate:[newLocation coordinate]];
    [mapView setRegion:region2];
    
    [self onPause];
}

// 現在地系：測位失敗時や、5位置情報の利用をユーザーが「不許可」とした場合などに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    
    [self onPause];
}

// ピンの加工
-(MKAnnotationView*)mapView:(MKMapView*)mapView
          viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (annotation == mapView.userLocation) {
        return nil;
    } else {
        CustomAnnotationView *annotationView;
        NSString* identifier = @"flag"; // 再利用時の識別子
        
        // 再利用可能な MKAnnotationView を取得
        annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(nil == annotationView) {
            //再利用可能な MKAnnotationView がなければ新規作成
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        annotationView.annotation = annotation;
        return annotationView;
    }
}



// 現在地へ移動
- (IBAction)nowLocation:(id)sender {
    NSLog(@"nowLocation");
    [self onResume];
}



// 現在地系：測位再開
-(void) onResume {
    if (nil != locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager startUpdatingLocation];
}

// 現在地系：測位停止
-(void) onPause {
    if (nil != locationManager && [CLLocationManager locationServicesEnabled])
        [locationManager stopUpdatingLocation];
}

@end
