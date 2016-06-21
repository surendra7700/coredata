//
//  addViewController.h
//  coredata
//
//  Created by Jinal on 08/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface addViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{    
    
    UIDatePicker *pickerView;    
    UIView *pickerViewWithDoneBtn;
    UIButton *btnAd;

}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *txtfld_username;
@property (weak, nonatomic) IBOutlet UITextField *txtfld_password;
@property (weak, nonatomic) IBOutlet UITextField *txtfld_con_pass;

- (IBAction)btn_bdate_tapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_bdate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_age;

- (IBAction)btn_male_tapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_male;
- (IBAction)btn_female_tapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_female;

@property (weak, nonatomic) IBOutlet UIButton *btn_done;
- (IBAction)btn_done_tapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_uploadimage;
- (IBAction)btn_uploadimg_tapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;

@end
