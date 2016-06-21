//
//  userInfoController.m
//  coredata
//
//  Created by Jinal on 26/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import "userInfoController.h"

@interface userInfoController ()

@end

@implementation userInfoController

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
    NSData *imageData=self.user.userimage;
    if(imageData==nil){
        self.image_profile.image=[UIImage imageNamed:@"noimage"];
    }
    else{
        self.image_profile.image=[UIImage imageWithData:imageData];
    }
    self.lbl_name.text=self.user.username;
    self.lbl_gender.text=self.user.gender;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.lbl_bdate.text=[dateFormatter stringFromDate:self.user.birthdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
