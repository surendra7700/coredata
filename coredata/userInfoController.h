//
//  userInfoController.h
//  coredata
//
//  Created by Jinal on 26/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface userInfoController : UIViewController
@property (strong, nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UIImageView *image_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_bdate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_;

@end
