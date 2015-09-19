//
//  CounterController.m
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import "CounterController.h"

@interface CounterController ()

@end

@implementation CounterController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Titre
    [[UINavigationBar appearance] setBarTintColor:[self pomeGranateColor]];
    [[UINavigationBar appearance] setTintColor:self.cloudsColor];

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[self cloudsColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-Thin" size:21.0], NSFontAttributeName, nil]];
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        
        self._departureLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 80.0, 85.0, 25.0)];
        self._departureAirPortButton = [[UIButton alloc] initWithFrame:CGRectMake(107.0, 80.0, 50, 25.0)];
        self._departureDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(159.0, 80.0, 140, 25.0)];
        
        self._arrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 130.0, 85.0, 25.0)];
        self._arrivalAirPortLabel = [[UILabel alloc] initWithFrame:CGRectMake(107.0, 130.0, 50, 25.0)];
        self._arrivalDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(159.0, 130.0, 140, 25.0)];
        
        self._durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 200, 260, 60.0)];
        
        self._startAndStopButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 320, 140, 140)];
    }
    else
    {
        //iphone 3.5 inch screen iphone 3g,4s
        
        self._departureLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 80.0, 85.0, 25.0)];
        self._departureAirPortButton = [[UIButton alloc] initWithFrame:CGRectMake(107.0, 80.0, 50, 25.0)];
        self._departureDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(159.0, 80.0, 140, 25.0)];
        
        self._arrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 130.0, 85.0, 25.0)];
        self._arrivalAirPortLabel = [[UILabel alloc] initWithFrame:CGRectMake(107.0, 130.0, 50, 25.0)];
        self._arrivalDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(159.0, 130.0, 140, 25.0)];
        
        self._durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 200, 260, 60.0)];
        
        self._startAndStopButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 295, 100, 100)];
    }
    
    [self._departureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [self._departureLabel setTextColor:self.midnightBlueColor];
    
    [self._arrivalLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [self._arrivalLabel setTextColor:self.midnightBlueColor];
    
    [self._arrivalAirPortLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [self._arrivalAirPortLabel setTextAlignment:NSTextAlignmentCenter];
    [self._arrivalAirPortLabel setTextColor:self.midnightBlueColor];
    
    [self._departureAirPortButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    //[self._departureAirPortButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self._departureAirPortButton setTitleColor:self.alizarinColor forState:UIControlStateNormal];
    [self._departureAirPortButton setTitleColor:self.midnightBlueColor forState:UIControlStateDisabled];
    [self._departureAirPortButton addTarget:self action:@selector(chooseDepartureAirport) forControlEvents:UIControlEventTouchDown];
    
    [self._arrivalDateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [self._arrivalDateLabel setTextAlignment:NSTextAlignmentCenter];
    [self._arrivalDateLabel setTextColor:self.midnightBlueColor];
    
    [self._departureDateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [self._departureDateLabel setTextAlignment:NSTextAlignmentCenter];
    [self._departureDateLabel setTextColor:self.midnightBlueColor];
    
    [self._durationLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:50.0]];
    [self._durationLabel setTextAlignment:NSTextAlignmentCenter];
    [self._durationLabel setTextColor:self.pomeGranateColor];
    
    [self._startAndStopButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0]];
    [self._startAndStopButton setTitleColor:self.turquoiseColor forState:UIControlStateNormal];
    [self._startAndStopButton setTitleColor:self.cloudsColor forState:UIControlStateDisabled];
    [self._startAndStopButton.layer setBorderColor:self.turquoiseColor.CGColor];
    [self._startAndStopButton.layer setCornerRadius:self._startAndStopButton.frame.size.height/2];
    [self._startAndStopButton.layer setBorderWidth:2.0];
    [self._startAndStopButton addTarget:self action:@selector(startAndStopAction:) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:[self _startAndStopButton]];
    [self.view addSubview:[self _durationLabel]];
    [self.view addSubview:[self _arrivalLabel]];
    [self.view addSubview:[self _arrivalDateLabel]];
    [self.view addSubview:[self _arrivalAirPortLabel]];
    [self.view addSubview:[self _departureLabel]];
    [self.view addSubview:[self _departureDateLabel]];
    [self.view addSubview:[self _departureAirPortButton]];
    
}

- (void)MAJContentDataOfView
{
    self._app = [UIApplication sharedApplication].delegate;
    
    // Couleurs
    self.midnightBlueColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    self.wetAsphaltColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    self.cloudsColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.pomeGranateColor = [UIColor colorWithRed:0.753 green:0.224 blue:0.169 alpha:1];
    self.alizarinColor = [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1];
    self.turquoiseColor = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1];
    
    // Titre
    [self setTitle:NSLocalizedString(@"Flight Timer", @"Le nom de l'application")];

    
    // ***************************
    [self destroyStructureOfView];
    [self MAJStructureofView];
    // ***************************
    
    [[self _departureLabel] setText:NSLocalizedString(@"Departure : ", nil)];
    [[self _arrivalLabel] setText:NSLocalizedString(@"Arrival : ", nil)];
    [[self _durationLabel] setText:@"0j 00:00:00"];
    
    if ([[[[self _app] getCurrentInfo] objectForKey:@"isInCount"]  isEqual: @(NO)]){ // si pas en train de compter
        if (![[[[self _app] getCurrentInfo] objectForKey:@"departure"] isEqualToString:@""]) { // si lieu de départ enregistrer
            [[self _departureAirPortButton] setTitle:[[[self _app] getCurrentInfo] objectForKey:@"departure"] forState:UIControlStateNormal];
            [[self _departureAirPortButton] setEnabled:YES];
            
            [[self _startAndStopButton] setEnabled:YES];
            [self._startAndStopButton.layer setBorderColor:self.turquoiseColor.CGColor];
            [self._startAndStopButton setTitleColor:self.turquoiseColor forState:UIControlStateNormal];
            [[self _startAndStopButton] setTitle:@"Start" forState:UIControlStateNormal];
            [[self _startAndStopButton] setTitle:@"Start" forState:UIControlStateDisabled];
        }else{ // si lieu de depart non enregistrer
            [[self _departureAirPortButton] setTitle:NSLocalizedString(@"choose..", nil) forState:UIControlStateNormal];
            [[self _departureAirPortButton] setFrame:CGRectMake(107.0, 80.0, 100, 25.0)];
            [[self _departureAirPortButton] setEnabled:YES];
            
            [[self _startAndStopButton] setEnabled:NO];
            [self._startAndStopButton.layer setBorderColor:self.cloudsColor.CGColor];
            [self._startAndStopButton setTitleColor:self.turquoiseColor forState:UIControlStateNormal];
            [[self _startAndStopButton] setTitle:@"Start" forState:UIControlStateNormal];
            [[self _startAndStopButton] setTitle:@"Start" forState:UIControlStateDisabled];
        }
        
        [[self _arrivalAirPortLabel] setText:NSLocalizedString(@" - - - ", nil)];
    }else{ // si en train de compter
        [self setTimerFlight];
        [[self _departureAirPortButton] setTitle:[[[self _app] getCurrentInfo] objectForKey:@"departure"] forState:UIControlStateDisabled];
        [[self _departureAirPortButton] setEnabled:NO];
        [self._departureAirPortButton setTitleColor:self.midnightBlueColor forState:UIControlStateDisabled];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
        
        NSDate*  departureDate = [[[self _app] getCurrentInfo] objectForKey:@"dateDeparture"];
        
        [[self _departureDateLabel] setText:[dateFormatter stringFromDate:departureDate]];
        [[self _arrivalAirPortLabel] setText:NSLocalizedString(@" - - - ", nil)];
        
        [[self _startAndStopButton] setEnabled:YES];
        [self._startAndStopButton.layer setBorderColor:self.alizarinColor.CGColor];
        [self._startAndStopButton setTitleColor:self.alizarinColor forState:UIControlStateNormal];
        
        [[self _startAndStopButton] setTitle:@"Stop" forState:UIControlStateNormal];
        [[self _startAndStopButton] setTitle:@"Stop" forState:UIControlStateDisabled];
        
        
        
        self->timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setTimerFlight) userInfo:nil repeats:YES];
        self->runLoop = [NSRunLoop currentRunLoop];
        [self->runLoop addTimer:self->timer forMode:NSDefaultRunLoopMode];
    }
    
    
}

- (void)destroyStructureOfView
{
    [[self _departureLabel] removeFromSuperview];
    [[self _arrivalLabel] removeFromSuperview];
    [[self _arrivalAirPortLabel] removeFromSuperview];
    [[self _arrivalDateLabel] removeFromSuperview];
    [[self _departureAirPortButton] removeFromSuperview];
    [[self _departureDateLabel] removeFromSuperview];
    [[self _durationLabel] removeFromSuperview];
    [[self _startAndStopButton] removeFromSuperview];
    
    self._startAndStopButton = nil;
    self._durationLabel = nil;
    self._departureDateLabel = nil;
    self._departureAirPortButton = nil;
    self._arrivalDateLabel = nil;
    self._arrivalAirPortLabel = nil;
    self._arrivalLabel = nil;
    self._departureLabel = nil;
}

- (void)chooseDepartureAirport{
    AirPortListController* airportlist = [[AirPortListController alloc] initWithReturnForDeparture:YES];
    
    [self.navigationController pushViewController:airportlist animated:YES];
}

- (void)startAndStopAction:(id)sender{
    UIButton* buttonSender = (UIButton*) sender;
    
    if ([[[buttonSender titleLabel] text] isEqualToString:@"Start"]) {
        
        [[[self _app] getCurrentInfo] setValue:[NSDate date] forKey:@"dateDeparture"];
        [[[self _app] getCurrentInfo] setValue:@(YES) forKey:@"isInCount"];
        [[self _app] saveInfoPlist];
        
        [self MAJContentDataOfView];
    }else if ([[[buttonSender titleLabel] text] isEqualToString:@"Stop"]){
        
        [[[self _app] getCurrentInfo] setValue:[NSDate date] forKey:@"dateArrival"];
        
        AirPortListController* airportarrival = [[AirPortListController alloc] initWithReturnForDeparture:NO];
        
        [self.navigationController pushViewController:airportarrival animated:YES];
    }
    
}

- (void)setTimerFlight{
    if ([[[[self _app] getCurrentInfo] objectForKey:@"isInCount"]  isEqual: @(NO)]){
        [[self _durationLabel] setText:@"0j 00:00:00"];
    }else{
        NSCalendarUnit calendrier =  NSDayCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *timerCalcule = [[NSCalendar currentCalendar] components:calendrier fromDate:[[[self _app] getCurrentInfo] objectForKey:@"dateDeparture"] toDate:[NSDate date] options:0];
        
        [self._durationLabel setText:[NSString stringWithFormat:@"%ldj %.2ld:%.2ld:%.2ld", (long)[timerCalcule day], (long)[timerCalcule hour], (long)[timerCalcule minute], (long)[timerCalcule second]]];
    }
}

@end
