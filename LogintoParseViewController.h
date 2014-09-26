//
//  LogintoParseViewController.h
//  LostChecker
//
//  Created by Kotaro Suto on 2014/09/26.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogintoParseViewController : UIViewController{
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *Label;
    IBOutlet UIImageView *im;
}
- (IBAction)loginButtonTouchHandler:(id)sender;
@end
