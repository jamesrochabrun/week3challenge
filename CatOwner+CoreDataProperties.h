//
//  CatOwner+CoreDataProperties.h
//  Assessment3
//
//  Created by James Rochabrun on 01-04-16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CatOwner.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatOwner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Cat *> *cats;

@end

@interface CatOwner (CoreDataGeneratedAccessors)

- (void)addCatsObject:(Cat *)value;
- (void)removeCatsObject:(Cat *)value;
- (void)addCats:(NSSet<Cat *> *)values;
- (void)removeCats:(NSSet<Cat *> *)values;

@end

NS_ASSUME_NONNULL_END
