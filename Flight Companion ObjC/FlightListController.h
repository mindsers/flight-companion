//
//  FlightListController.h
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Flight.h"

@interface FlightListController : UITableViewController

@property (strong, nonatomic) UIColor* midnightBlueColor;
@property (strong, nonatomic) UIColor* wetAsphaltColor;
@property (strong, nonatomic) UIColor* cloudsColor;
@property (strong, nonatomic) UIColor* pomeGranateColor;
@property (strong, nonatomic) UIColor* alizarinColor;
@property (strong, nonatomic) UIColor* turquoiseColor;

@property (strong, nonatomic) AppDelegate* app;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
