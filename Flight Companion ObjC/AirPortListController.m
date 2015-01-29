//
//  AirPortListController.m
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import "AirPortListController.h"

@interface AirPortListController ()

@end

@implementation AirPortListController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithReturnForDeparture:(BOOL)departure
{
    self = [super init];
    if (self) {
        self->returnDeparture = departure;
        _app = [UIApplication sharedApplication].delegate;
        _managedObjectContext = _app.managedObjectContext;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 10; // meters
    
    [locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self MAJContentDataOfView];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    currentLocation = newLocation;
    
    [self ordonateData];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [airportList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    [cell.textLabel setText:[[airportList objectAtIndex:indexPath.row] objectForKey:@"nom"]];
    [cell.textLabel setTextColor:self.midnightBlueColor];
    
    UILabel* distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 35, 80, 15)];
    [distanceLabel setText:[NSString stringWithFormat:@"%.2f km",[[[airportList objectAtIndex:indexPath.row] objectForKey:@"distance"] doubleValue]/1000]];
    [distanceLabel setTextAlignment:NSTextAlignmentRight];
    [distanceLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
    [distanceLabel setTextColor:self.cloudsColor];
        
    [cell addSubview:distanceLabel];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self->returnDeparture == YES) {
        [[_app getCurrentInfo] setValue:[[airportList objectAtIndex:indexPath.row] objectForKey:@"icao"] forKey:@"departure"];
    }else{
        Flight* newFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Flight" inManagedObjectContext:self.managedObjectContext];
        
        newFlight.dateDeparture = [[_app getCurrentInfo] objectForKey:@"dateDeparture"];
        newFlight.departure = [[_app getCurrentInfo] objectForKey:@"departure"];
        newFlight.arrival = [[airportList objectAtIndex:indexPath.row] objectForKey:@"icao"];
        newFlight.dateArrival = [[_app getCurrentInfo] objectForKey:@"dateArrival"];
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        [[_app getCurrentInfo] setValue:@"" forKey:@"departure"];
        [[_app getCurrentInfo] setValue:@(NO) forKey:@"isInCount"];
        [_app saveInfoPlist];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)MAJStructureofView
{
    
    
}

- (void)MAJContentDataOfView
{
    // Couleurs
    self.midnightBlueColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    self.wetAsphaltColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    self.cloudsColor = [UIColor colorWithRed:0.741 green:0.765 blue:0.780 alpha:1];
    self.pomeGranateColor = [UIColor colorWithRed:0.753 green:0.224 blue:0.169 alpha:1];
    self.alizarinColor = [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1];
    
    // Titre
    [self setTitle:NSLocalizedString(@"Airport List", @"Le nom de l'application")];
    
    [self ordonateData];
    
    // ***************************
    [self destroyStructureOfView];
    [self MAJStructureofView];
    // ***************************
}

- (void)destroyStructureOfView
{
    
}

- (void)ordonateData{
    airportList = [_app getAirPortList];
    CLLocation* locationAirport;
    NSNumber* distance;
    
    for (NSDictionary* airport in airportList) {
        locationAirport = [[CLLocation alloc] initWithLatitude:[[[airport objectForKey:@"position"] objectForKey:@"latitude"] doubleValue] longitude:[[[airport objectForKey:@"position"] objectForKey:@"longitude"] doubleValue]];
        
        distance = [NSNumber numberWithDouble:[locationAirport distanceFromLocation:currentLocation]];
        
        [airport setValue:distance forKey:@"distance"];
        
    }
    
    NSSortDescriptor *nsSortDescriptor;
    nsSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:nsSortDescriptor];
    NSArray *tableauTrie = [[NSArray alloc] init];
    tableauTrie = [airportList sortedArrayUsingDescriptors:sortDescriptors];
    
    airportList = [tableauTrie mutableCopy];
    
}
@end
