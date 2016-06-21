//
//  ViewController.h
//  coredata
//
//  Created by Jinal on 08/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "userInfoController.h"

@interface ViewController : UIViewController{
    NSArray *array_user;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_add;
@property (weak, nonatomic) IBOutlet UITableView *tabel_user;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

