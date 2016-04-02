//
//  AddCatViewController.m
//  Assessment3
//
//  Created by Ben Bueltmann on 1/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

#import "AddCatViewController.h"
#import "Cat.h"
#import "AppDelegate.h"


@interface AddCatViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property NSManagedObjectContext *moc;
@property NSMutableArray *cats;


@end

@implementation AddCatViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;

}

- (IBAction)onPressedUpdateCat:(UIButton *)sender
{
    Cat *cat = [NSEntityDescription insertNewObjectForEntityForName:@"Cat" inManagedObjectContext:self.moc];
    
    //step 1 after set the relationships
    //beacuse now we are setting a relation from book to member
    //we grab the method from the catowner+CoreDataProperties.h
    [self.catOwner addCatsObject:cat];
    
    cat.name = self.nameTextField.text;
    cat.breed = self.breedTextField.text;
    cat.color = self.colorTextField.text;
    
    NSLog(@"hola");
    NSError *error;
    
    if([self.moc save:&error]){
        [self.cats addObject:cat];
    }else{
        NSLog(@"an error has occurred,...%@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

    

}


@end
