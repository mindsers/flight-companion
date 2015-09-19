//
//  FlightListController.m
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import "FlightListController.h"

@interface FlightListController ()

@end

@implementation FlightListController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [self MAJContentDataOfView];
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
    return [[_app getAllFlight] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    Flight* cellFlight = (Flight*)[[_app getAllFlight] objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDateFormatter *heureFormatter = [[NSDateFormatter alloc] init];
    [heureFormatter setDateFormat:@"HH:mm"];
    
    UILabel* formatCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 126, 300, 14)];
    [formatCode setTextAlignment:NSTextAlignmentCenter];
    [formatCode setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    [formatCode setTextColor:self.cloudsColor];

    formatCode.text = [NSString stringWithFormat:@"%@ - %@ %@ - %@ %@ - %@", [dateFormatter stringFromDate:cellFlight.dateDeparture], cellFlight.departure, [heureFormatter stringFromDate:cellFlight.dateDeparture], cellFlight.arrival, [heureFormatter stringFromDate:cellFlight.dateArrival], [self getStringDurationFromDeparture:cellFlight.dateDeparture andArrival:cellFlight.dateArrival]];
    
    UILabel* durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 200, 35)];
    [durationLabel setTextAlignment:NSTextAlignmentCenter];
    [durationLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0]];
    [durationLabel setTextColor:self.wetAsphaltColor];
    
    [durationLabel setText:[self getStringDurationFromDeparture:cellFlight.dateDeparture andArrival:cellFlight.dateArrival]];
    
    UILabel* departureLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 70, 25)];
    [departureLabel setTextAlignment:NSTextAlignmentCenter];
    [departureLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0]];
    [departureLabel setTextColor:[UIColor whiteColor]];
    [departureLabel.layer setBackgroundColor:self.turquoiseColor.CGColor];
    [departureLabel.layer setCornerRadius:10];
    [departureLabel.layer setBorderWidth:1];
    [departureLabel.layer setBorderColor:self.turquoiseColor.CGColor];
    
    [departureLabel setText:cellFlight.departure];
    
    UILabel* arrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 70, 25)];
    [arrivalLabel setTextAlignment:NSTextAlignmentCenter];
    [arrivalLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0]];
    [arrivalLabel setTextColor:[UIColor whiteColor]];
    [arrivalLabel.layer setBackgroundColor:self.pomeGranateColor.CGColor];
    [arrivalLabel.layer setCornerRadius:10.0];
    [arrivalLabel.layer setBorderWidth:1];
    [arrivalLabel.layer setBorderColor:self.pomeGranateColor.CGColor];
    [arrivalLabel setText:cellFlight.arrival];
    
    [cell addSubview:arrivalLabel];
    [cell addSubview:departureLabel];
    [cell addSubview:formatCode];
    [cell addSubview:durationLabel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150.0;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.managedObjectContext deleteObject:[[_app getAllFlight] objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

        [tableView endUpdates];
    }  
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    self.turquoiseColor = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1];
    
    // Titre
    [self setTitle:NSLocalizedString(@"Flight List", @"Le nom de l'application")];
    
    _app = [UIApplication sharedApplication].delegate;
    
    // ***************************
    [self destroyStructureOfView];
    [self MAJStructureofView];
    // ***************************
}

- (void)destroyStructureOfView
{
    
}

- (NSString*)getStringDurationFromDeparture:(NSDate*)departure andArrival:(NSDate*)arrival{
    NSCalendarUnit calendrier =  NSDayCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *timerCalcule = [[NSCalendar currentCalendar] components:calendrier fromDate:departure toDate:arrival options:0];
    
    NSString* returnString = @"";
    
    returnString = [NSString stringWithFormat:@"%ldj %.2ld:%.2ld:%.2ld", (long)[timerCalcule day], (long)[timerCalcule hour], (long)[timerCalcule minute], (long)[timerCalcule second]];
    
    return returnString;
}

- (NSString*)getNameOfAirPortFromICAO:(NSString*)icao{
    
    for (NSDictionary* airport in [_app getAirPortList]) {
        if ([[airport objectForKey:@"icao"] isEqualToString:icao]) {
            return [airport objectForKey:@"nom"];
        }
    }
    
    return @"";
}

@end
