//
//  FirstViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "showmoreViewController.h"

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *table;
    IBOutlet UIImageView *lostPhotoView;
    
    int segue;
    
   
    NSString *testr;
    NSString *str;
    
    NSMutableArray *textarray;
    NSMutableArray *imagearray;
    
    PFFile *testimage;
}
-(IBAction)refresh;
@end