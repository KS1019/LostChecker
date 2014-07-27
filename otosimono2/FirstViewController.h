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
    int cellcolor;
    
    UIImage *img;

    NSString *testr;
    NSString *str;
    NSString *comstr;
    
    NSNumber *CellColorNum;
    
    NSMutableArray *textarray;
    NSMutableArray *imagearray;
    NSMutableArray *CellColorArray;
    
    UIImage *passImage;
    
    PFFile *testimage;
}
-(IBAction)refresh;
@end
