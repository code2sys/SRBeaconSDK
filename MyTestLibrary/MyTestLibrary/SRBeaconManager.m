//
//  SRBeaconManager.m
//  Canabalt
//
//  Created by cuterabbit on 1/17/14.
//
//

#import "SRBeaconManager.h"
#import "ESTBeaconManager.h"
#import <EstimoteSDK/ESTBeaconRegion.h>

@interface SRBeaconManager() <ESTBeaconManagerDelegate>

@end

@implementation SRBeaconManager

+ (instancetype)sharedInstance
{
    static SRBeaconManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SRBeaconManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.beaconManager = [[ESTBeaconManager alloc] init];
        self.beaconManager.delegate = self;
        self.discovered = NO;
    }
    return self;
}

#pragma mark - Public

/**
 start beacons monitoring in the range
 */
- (void)start {
    // create sample region object (you can additionaly pass major / minor values)
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    
    // start looking for estimote beacons in region
    // when beacon ranged beaconManager:didRangeBeacons:inRegion: invoked
    [self.beaconManager startRangingBeaconsInRegion:region];
}

#pragma mark - ESTBeaconManagerDelegate

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    if([beacons count] > 0)
    {
        if (!self.discovered) {
            [[NSNotificationCenter defaultCenter] postNotificationName:SRBeaconManagerDidInRange
                                                                object:nil];
        }
        self.discovered = YES;
    }
    else {
        if (self.discovered) {
            [[NSNotificationCenter defaultCenter] postNotificationName:SRBeaconManagerDidFailInRange
                                                                object:nil];
        }
        self.discovered = NO;
    }
}

@end
