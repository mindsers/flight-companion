//
//  AirPortListController.h
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "Flight.h"

@interface AirPortListController : UITableViewController<CLLocationManagerDelegate>{
    BOOL returnDeparture;
    CLLocationManager* locationManager;
    CLLocation* currentLocation;
    
    NSMutableArray* airportList;
}

@property (strong, nonatomic) UIColor* midnightBlueColor;
@property (strong, nonatomic) UIColor* wetAsphaltColor;
@property (strong, nonatomic) UIColor* cloudsColor;
@property (strong, nonatomic) UIColor* pomeGranateColor;
@property (strong, nonatomic) UIColor* alizarinColor;

@property (strong, nonatomic) AppDelegate* app;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithReturnForDeparture:(BOOL)departure;

@end
