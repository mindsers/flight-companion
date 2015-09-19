//
//  AppDelegate.m
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import "AppDelegate.h"
#import "CounterController.h"
#import "FlightListController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *newpath = [documentsDirectory stringByAppendingPathComponent:@"current.plist"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:newpath]){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"currentCounter" ofType:@"plist"];
        current = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        [current writeToFile:newpath atomically: YES];
    }else{
        current = [[NSMutableDictionary alloc] initWithContentsOfFile:newpath];
    }
    
    NSString *pathForAirPort = [[NSBundle mainBundle] pathForResource:@"airPortList" ofType:@"plist"];
    airports = [[NSMutableArray alloc] initWithContentsOfFile:pathForAirPort];
    
    CounterController* rootController = [[CounterController alloc] init];
    FlightListController* secondViewController = [[FlightListController alloc] init];
    
    UINavigationController* rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
    UINavigationController* secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    
    self._tabBarController = [[UITabBarController alloc] init];
    [self._tabBarController setViewControllers:@[rootNavigationController, secondNavigationController] animated:YES];
    [self._tabBarController.view setTintColor:[UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1]];
    
    UITabBarItem* counterItem = [self._tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem* listItem = [self._tabBarController.tabBar.items objectAtIndex:1];
    
    counterItem.title = @"Flight Timer";
    listItem.title = @"Flight List";
    
    [counterItem setImage:[UIImage imageNamed:@"timer"]];
    [listItem setImage:[UIImage imageNamed:@"list"]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self._tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Flight_Companion_ObjC" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Flight_Companion_ObjC.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSMutableDictionary*)getCurrentInfo{
    return current;
}

- (NSMutableArray*)getAirPortList{
    return airports;
}

- (NSArray*)getAllFlight
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Flight"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Sorting by date
    NSSortDescriptor *sortDescriptorForDate = [[NSSortDescriptor alloc] initWithKey:@"dateArrival" ascending:NO];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptorForDate, nil];
    [fetchRequest setSortDescriptors:descriptors];
    
    NSError* error;
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

- (void)saveInfoPlist{
    NSString *DD = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [DD stringByAppendingPathComponent:@"current.plist"];
    [current writeToFile:path atomically: YES];
}

- (void)makeAirPortList{ // Créer un plist formaté comme j'ai envie
    NSString *sourceFileString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"raw-airfields" ofType:@"csv"] encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray *csvArray = [[NSMutableArray alloc] init];
    NSMutableArray *airportArray = [[NSMutableArray alloc] init];
    
    csvArray = [[sourceFileString componentsSeparatedByString:@"\n"] mutableCopy];
    
    for (NSString* keysString in csvArray) {
        NSArray *keysArray = [keysString componentsSeparatedByString:@","];
        
        NSMutableDictionary* airport = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* position = [[NSMutableDictionary alloc] init];
        
        NSArray* nomArray = [[keysArray objectAtIndex:0] componentsSeparatedByString:@"\""];
        
        NSString* icao = [[nomArray objectAtIndex:1] substringWithRange:NSMakeRange(0,4)];
        
        [airport setObject:[nomArray objectAtIndex:1] forKey:@"nom"];
        [airport setObject:icao forKey:@"icao"];
        [position setObject:[keysArray objectAtIndex:1] forKey:@"latitude"];
        [position setObject:[keysArray objectAtIndex:2] forKey:@"longitude"];
        [airport setObject:position forKey:@"position"];
        
        [airportArray addObject:airport];
    }
    
    NSString *DD = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [DD stringByAppendingPathComponent:@"AirPortListAutoGenerate.plist"];
    [airportArray writeToFile:path atomically: YES];

}

@end
