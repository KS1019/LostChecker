//
//  MapViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/08/28.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize LatitudeNum2;
@synthesize LongitudeNum2;
@synthesize AlertNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
        [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"AlertNum is %d",AlertNum);
       if (AlertNum == 0) {
           NSLog(@"LatitudeNum2 is %@",LatitudeNum2);
           NSLog(@"LongitudeNum2 is %@",LongitudeNum2);
           
        LatitudeDouble = [LatitudeNum2 doubleValue];
        LongitudeDouble = [LongitudeNum2 doubleValue];
           NSLog(@"%f,%f",LatitudeDouble,LongitudeDouble);
        CLLocationDegrees LatitudeDeg = LatitudeDouble;
        CLLocationDegrees LongitudeDeg = LongitudeDouble;
        CLLocationCoordinate2D co;
        co.latitude = LatitudeDeg; // 経度
        co.longitude = LongitudeDeg; // 緯度

    // 生成
    mv = [[MKMapView alloc] init];
    mv.delegate = self;
    mv.frame = CGRectMake(0, 0, 320, 524);
    mv.mapType = MKMapTypeHybrid;
    [mv setCenterCoordinate:co animated:NO];
    
    // 縮尺を指定
    MKCoordinateRegion cr = mv.region;
    cr.center = co;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mv setRegion:cr animated:NO];
    

    // addSubview
    [self.view addSubview:mv];
    
    pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = co;
    [mv addAnnotation:pin];
    }else if (AlertNum == 1){
        [self AddPin];
    }else if(AlertNum == 2){
        [self NowLocation];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AddPin{
    CLLocationCoordinate2D co;
    co.latitude = 35.68664111; // 経度
    co.longitude =139.6948839; // 緯度
    mv = [[MKMapView alloc] init];
    mv.delegate = self;
    mv.frame = CGRectMake(0, 0, 320, 524);
    mv.mapType = MKMapTypeHybrid;
    // 縮尺を指定
    MKCoordinateRegion cr = mv.region;
    
    cr.center = co;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mv setRegion:cr animated:NO];
    // addSubview
    [self.view addSubview:mv];
    UILongPressGestureRecognizer* tapGestureRecognizer
    = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [mv addGestureRecognizer:tapGestureRecognizer];


}
-(void)NowLocation{
    CLLocationCoordinate2D co;
    co.latitude = 35.68664111; // 経度
    co.longitude =139.6948839; // 緯度

    mv = [[MKMapView alloc] init];
    mv.delegate = self;
    mv.frame = CGRectMake(0, 0, 320, 524);
    mv.mapType = MKMapTypeHybrid;
    // 縮尺を指定
    MKCoordinateRegion cr = mv.region;
        cr.center = co;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mv setRegion:cr animated:NO];
    // addSubview
    [self.view addSubview:mv];
    lm = [[CLLocationManager alloc] init];
    if([lm locationServicesEnabled]){
        lm.delegate = self;
        lm.distanceFilter = 100.0;
        lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [lm startUpdatingLocation];
        [self performSelector:@selector(stopUpdatingLocation:)
                   withObject:nil
                   afterDelay:1.0];
    }else{
        NSLog(@"Location service can't use");
    }

}

- (void)stopUpdatingLocation:(NSObject *)args{
    [lm stopUpdatingLocation]; //測位停止
    CLLocation *NowCLL = [lm location];
    pin = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D LM = [NowCLL coordinate];
    SendCO = LM;
    pin.coordinate = LM;
    [mv addAnnotation:pin];

}

    
-(MKAnnotationView*)mapView:(MKMapView*)mapView
viewForAnnotation:(id)annotation{
    
    static NSString *PinIdentifier = @"Pin";
    MKPinAnnotationView *pinn =
    (MKPinAnnotationView*)
    [mv dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
    if(pinn == nil){
        pinn = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
        pinn.animatesDrop = YES;  // アニメーションをする
        pinn.pinColor=MKPinAnnotationColorPurple;  // ピンの色を紫にする
        pinn.draggable = YES;
        pinn.canShowCallout = YES;  // ピンタップ時にコールアウトを表示する
        
    }
    return pinn;
    
}






//  地図タップ対応
- (void)tap:(UILongPressGestureRecognizer*)gestureRecognizer
{
    
    
    pin = [[MKPointAnnotation alloc] init];
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    [mv removeAnnotations:mv.annotations];
    //ここでMKPointAnnotationを追加
    CGPoint pt = [gestureRecognizer locationInView:gestureRecognizer.view];
    CLLocationCoordinate2D coordinate = [mv convertPoint:pt
                                          toCoordinateFromView:gestureRecognizer.view];
    SendCO = coordinate;
    pin.coordinate = coordinate;
    [mv addAnnotation:pin];

    
}

-(IBAction)OK{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SecondViewController *SVC = segue.destinationViewController;
     if ([segue.identifier isEqualToString:@"MapSegue"]) {
         SVC.LatitudeDouble2 =  SendCO.latitude;
         SVC.LongitudeDouble2 = SendCO.longitude;
              }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
