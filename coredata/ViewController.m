//
//  ViewController.m
//  coredata
//
//  Created by Jinal on 08/09/14.
//  Copyright (c) 2014 sttl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
            

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}
-(void)viewWillAppear:(BOOL)animated
{
    array_user=[self getRecords];
    
    if(array_user.count==0)
        self.tabel_user.hidden=TRUE;
    else
        self.tabel_user.hidden=false;
    
    [self.tabel_user reloadData];
    
}
-(NSArray*)getRecords
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

#pragma mark tableview methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array_user count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIImageView *categoryImageView = (UIImageView *)[cell viewWithTag:2];
    UILabel *categoryNameLabel = (UILabel *)[cell viewWithTag:1];
    
    User *user = [array_user objectAtIndex:indexPath.row];

    NSData *imageData=user.userimage;
    if(imageData==nil){
        categoryImageView.image=[UIImage imageNamed:@"noimage"];
    }
    else{
        categoryImageView.image=[UIImage imageWithData:imageData];
    }
    categoryNameLabel.text = user.username;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    userInfoController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"userInfoController"];
    detailViewController.user=[array_user objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
