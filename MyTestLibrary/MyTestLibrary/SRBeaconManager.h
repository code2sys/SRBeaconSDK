//
//  SRBeaconManager.h
//  Canabalt
//
//  Created by cuterabbit on 1/17/14.
//
//

#import <UIKit/UIKit.h>

#define SRBeaconManagerDidInRange       @"didInRange"
#define SRBeaconManagerDidFailInRange   @"didFailInRange"

@class ESTBeaconManager;

@interface SRBeaconManager : NSObject

/// indicate whether the beacons has been discovered or not in a range
@property (nonatomic, assign) BOOL discovered;

/// ESTBeaconManager
@property (nonatomic, strong) ESTBeaconManager *beaconManager;

+ (instancetype)sharedInstance;

- (void)start;

@end
