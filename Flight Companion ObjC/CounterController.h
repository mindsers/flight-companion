//
//  CounterController.h
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 16/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AirPortListController.h"

@interface CounterController : UIViewController{
    NSTimer *timer;
    NSRunLoop *runLoop;
}

@property (strong, nonatomic) UIColor* midnightBlueColor;
@property (strong, nonatomic) UIColor* wetAsphaltColor;
@property (strong, nonatomic) UIColor* cloudsColor;
@property (strong, nonatomic) UIColor* pomeGranateColor;
@property (strong, nonatomic) UIColor* alizarinColor;
@property (strong, nonatomic) UIColor* turquoiseColor;

@property (strong, nonatomic) AppDelegate* _app;


// view

@property (strong, nonatomic) UILabel* _departureLabel;
@property (strong, nonatomic) UIButton* _departureAirPortButton;
@property (strong, nonatomic) UILabel* _departureDateLabel;
@property (strong, nonatomic) UILabel* _arrivalLabel;
@property (strong, nonatomic) UILabel* _arrivalAirPortLabel;
@property (strong, nonatomic) UILabel* _arrivalDateLabel;
@property (strong, nonatomic) UILabel* _durationLabel;
@property (strong, nonatomic) UIButton* _startAndStopButton;

@end
