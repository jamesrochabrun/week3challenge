//
//  CatsViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "CatsViewController.h"
#import "AppDelegate.h"
#import "Cat.h"
#import "AddCatViewController.h"

@interface CatsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *CatsTableView;
@property NSManagedObjectContext *moc;
@property NSMutableArray *cats;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.catOwner.name;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    self.cats = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    //step 2 now we show all objects from the relationship and pass it to self.books
    //we put this in this view because the textfield is here, we can put it in other Vc if this vc contained a independent VC with a textField
    
    //for this we use the father.child
    self.cats = [[self.catOwner.cats allObjects] mutableCopy] ;
    [self.tableView reloadData];
}




#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.cats.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CatCell"];
    //TODO: UPDATE THIS ACCORDINGLY
    Cat *cat = [self.cats objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", cat.breed, cat.color];
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddCatSegue"])
    {
        AddCatViewController *destination = segue.destinationViewController;
        //passing the same catOwner to the next Segue
        destination.catOwner = self.catOwner;
    }
    else
    {
        
    }
}

@end
