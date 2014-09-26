//
//  MapViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/08/28.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SecondViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>{
    double LatitudeDouble;
    double LongitudeDouble;
    MKMapView *mv;
    MKPointAnnotation* pin;
    
    NSNumber *LatitudeNum2;
    NSNumber *LongitudeNum2;
    
    int AlertNum;
    
    CLLocationManager *lm;
    
    CLLocationCoordinate2D SendCO;
    
    BOOL MapBOOL;


}
@property(nonatomic)NSNumber *LatitudeNum2;
@property(nonatomic)NSNumber *LongitudeNum2;
@property(nonatomic)int AlertNum;

@end
