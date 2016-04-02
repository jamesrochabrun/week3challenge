//
//  ViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CatOwner.h"
#import "CatsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *catOwners;
@property NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.moc = appDelegate.managedObjectContext;
    self.catOwners = [NSMutableArray new];
    
    self.title = @"Cat Owners";
    
    //do this only once
    
//    [self getDataFromPlist];
    
    [self loadMembers];
}


//getting data from Plist
-(void)getDataFromPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"catowners" ofType:@"plist"];
    
    //this is only for checking if the file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSLog(@"The file exists");
    } else {
        NSLog(@"The file does not exist");
    }
    
    //populating the array with the p.list. It is an array of dictionaries.
    self.catOwners = [[[NSArray alloc] initWithContentsOfFile:path]mutableCopy];

    
//populating the values of the name attribute of the catOwner entity
    //staging area
    for (NSDictionary *people in self.catOwners) {
        CatOwner *catOwner = [NSEntityDescription insertNewObjectForEntityForName:@"CatOwner" inManagedObjectContext:self.moc];
        catOwner.name = [people valueForKey:@"name"];
    }
    
    //saving in coredata
    NSError *error;
    
    if([self.moc save:&error]){
        [self.tableView reloadData];
    }else{
        NSLog(@"an error has occurred,...%@", error);
    }

}

-(void)loadMembers
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CatOwner"];
    
    //here is where we are populating the array with data from the staging area
    NSError *error;
    //the & is using the addres of error
    self.catOwners = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
    if(error == nil){
        [self.tableView reloadData];
    }else{
        NSLog(@"Error: %@", error);
    }
}


#pragma mark - UITableView Delegate Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.catOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellID"];
    CatOwner *catOwner = [self.catOwners objectAtIndex:indexPath.row];
    catOwner.name = [catOwner valueForKey:@"name"];
    cell.textLabel.text = catOwner.name;
    

    return cell;
}




//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose a default color!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *purple = [UIAlertAction actionWithTitle:@"Purple" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }];
    UIAlertAction *blue = [UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }];
    UIAlertAction *orange = [UIAlertAction actionWithTitle:@"Orange" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }];
    UIAlertAction *green = [UIAlertAction actionWithTitle:@"Green" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:purple];
    [alertController addAction:blue];
    [alertController addAction:orange];
    [alertController addAction:green];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:true completion:^{
        
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        CatOwner *catOwner = [self.catOwners objectAtIndex:path.row];
        
        CatsViewController *catVC = segue.destinationViewController;
        
        //here we are assigning one item in the members array to the member property of the ProfileViewController
        catVC.catOwner = catOwner;
    
    
}
















@end
