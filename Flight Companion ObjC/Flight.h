//
//  Flight.h
//  Flight Companion ObjC
//
//  Created by Nathanaël Cherrier on 17/06/2014.
//  Copyright (c) 2014 Simiux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Flight : NSManagedObject

@property (nonatomic, retain) NSString * arrival;
@property (nonatomic, retain) NSDate * dateArrival;
@property (nonatomic, retain) NSDate * dateDeparture;
@property (nonatomic, retain) NSString * departure;

@end
