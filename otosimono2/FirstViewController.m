//
//  FirstViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
        table.delegate=self;
    table.dataSource=self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
    if (segue==1) {
   segue=0;
    }else{
        [self refresh]; 
    }
    NSLog(@"44444444444444444");
}

-(IBAction)refresh{
    NSLog(@"111111!!!!1");
    
      textarray=[[NSMutableArray alloc] init];
    imagearray=[[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    //query.skip = 0;
    //query.limit = 10; // limit to at most 10 results
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *testobject in objects) {
            // Do something with the returned PFObject in the gameScore variable.
            //NSLog(@"%@", testobject);
            NSLog(@"%@",str);
            str = [testobject objectForKey:@"foo"];
            
            NSLog(@"str->%@",str);
            [textarray addObject:str];
            NSLog(@"textarray->%@",textarray);
            //NSLog(@"%@",teststr);
            
            PFFile *testimage=[testobject objectForKey:@"image"];
            [imagearray addObject:testimage];
            //UIImage *testimage2=[[UIImage alloc]initWithData:testimage];
            //[lostPhotoView setImage:testimage2];
            
           // NSString *testooooo=[testobject objectForKey:@"objectId"];
            //NSLog(@"objectId->%@",testooooo);
            NSLog(@"%@",textarray[0]);
            [table reloadData];
        }
    }];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"I want to kill you."sender:self];
    segue++;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"I want to kill you."]) {
        showmoreViewController *resultVC=segue.destinationViewController;
        UIImage *img=[imagearray objectAtIndex:indexPath.row];

        resultVC.showimage=
    }
}
#pragma mark- テーブルビュー
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [textarray count];
    //return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[textarray objectAtIndex:indexPath.row];
    
    cell.imageView.backgroundColor = [UIColor grayColor];
    PFFile *img = [imagearray objectAtIndex:indexPath.row];
     [img getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.imageView.image = [UIImage imageWithData:imageData];
            [table reloadData];
        }
    }];
    
//    cell.imageView.image =
    //cell.textLabel.text=@"あ";

    return cell;
}


@end
