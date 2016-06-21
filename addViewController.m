//
//  addViewController.m
//  coredata
//
//  Created by Jinal on 08/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()

@end

@implementation addViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = delegate.managedObjectContext;
    [self.txtfld_password setSecureTextEntry:YES];
    [self.txtfld_con_pass setSecureTextEntry:YES];
    self.userimage.image=[UIImage imageNamed:@"noimage"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];

}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btn_bdate_tapped:(id)sender {
    [self.view endEditing:YES];
    [self openPicker];
}
- (IBAction)btn_done_tapped:(id)sender {
    
    BOOL genderflag=self.btn_female.selected||self.btn_male.selected;
    if([self.txtfld_con_pass.text isEqualToString:@""]||[self.txtfld_password.text isEqualToString:@""]||[self.txtfld_username.text isEqualToString:@""]||!genderflag){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Enter all the values"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if(![self.txtfld_password.text isEqualToString:self.txtfld_con_pass.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Password and Confirm Passowrd is not same"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        // Add Entry to PhoneBook Data base and reset all fields
        [self.navigationController popViewControllerAnimated:YES];
        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                          inManagedObjectContext:self.managedObjectContext];
        newUser.username = self.txtfld_username.text;
        newUser.password=self.txtfld_password.text;
        newUser.birthdate = pickerView.date;
        
        if(self.btn_female.selected==TRUE)
            newUser.gender=@"Female";
        else
            newUser.gender=@"Male";
        
        NSData *dataImage = UIImageJPEGRepresentation(self.userimage.image, 0.0);
        newUser.userimage=dataImage;
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        
        [self.view endEditing:YES];
    }
}

- (IBAction)btn_male_tapped:(id)sender {
    [self.btn_male setImage:[UIImage imageNamed:@"radiogreen"] forState:UIControlStateNormal];
    [self.btn_female setImage:[UIImage imageNamed:@"radiogrey"] forState:UIControlStateNormal];
    self.btn_female.selected=false;
    self.btn_male.selected=true;
    
}
- (IBAction)btn_female_tapped:(id)sender {
    [self.btn_female setImage:[UIImage imageNamed:@"radiogreen"] forState:UIControlStateNormal];
    [self.btn_male setImage:[UIImage imageNamed:@"radiogrey"] forState:UIControlStateNormal];
    self.btn_female.selected=true;
    self.btn_male.selected=false;
}



#pragma mark picer view mathods
- (void)openPicker
{
    pickerViewWithDoneBtn = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-266, 320, 266)];
    [pickerViewWithDoneBtn setBackgroundColor:[UIColor whiteColor]];
    // createthe picker and add it to the view
    if(pickerView == nil)
        pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    [pickerView addTarget:self action:@selector(ageCount:) forControlEvents:UIControlEventValueChanged];

    [pickerView setHidden:NO];
    pickerView.datePickerMode=UIDatePickerModeDate;
    
    // the UIToolbar is referenced 'using self.datePickerToolbar'
    [UIView beginAnimations:@"showDatepicker" context:nil];
    // animate for 0.3 secs.
    [UIView setAnimationDuration:0.3];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPicker:)];
    [barItems addObject:cancelBtn];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeNumber:)];
    [barItems addObject:doneBtn];
    
    [toolBar setItems:barItems animated:YES];
    [pickerViewWithDoneBtn addSubview:toolBar];
    [UIView commitAnimations];
    [pickerViewWithDoneBtn addSubview:pickerView];
    [self.view addSubview:pickerViewWithDoneBtn];
}
-(void)ageCount:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    [self.btn_bdate setTitle:[NSString stringWithFormat:@"%@",
                              [df stringFromDate:pickerView.date]] forState:UIControlStateNormal];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startdate= [NSString stringWithFormat:@"%@",
                          [dateFormatter stringFromDate: pickerView.date]];
    
    NSDate *End=[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    
    NSCalendar *gregorianCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear
                                                        fromDate:[dateFormatter dateFromString:startdate]
                                                          toDate:End
                                                         options:0];
    self.lbl_age.text=[NSString stringWithFormat:@"%d Years",components.year];
    
}
-(void)changeNumber:(id)sender{
    [pickerViewWithDoneBtn removeFromSuperview];
    
}
-(void)cancelPicker:(id)sender{
    [pickerViewWithDoneBtn removeFromSuperview];
    
}

#pragma mark image uploading
- (IBAction)btn_uploadimg_tapped:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userimage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
