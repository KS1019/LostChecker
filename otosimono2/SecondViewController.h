//
//  SecondViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"


@interface SecondViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    IBOutlet UIImageView *LostPhoto;
    IBOutlet UITextView *Comment;
    IBOutlet UIImageView  *testimageview;

    
    UIImage *Sendimage;
    
    
    NSString *comstr;

    
    int i;
}
-(IBAction)Photo;
-(IBAction)SEND;
-(IBAction)test;
@end