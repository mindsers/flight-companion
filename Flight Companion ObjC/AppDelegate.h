//
//  AppDelegate.h
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableDictionary* current;
    NSMutableArray* airports;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) UINavigationController* _navigationController;
@property (strong,nonatomic) UITabBarController* _tabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)saveInfoPlist;
- (NSMutableDictionary*)getCurrentInfo;
- (NSMutableArray*)getAirPortList;
- (NSArray*)getAllFlight;

@end

