//  AppDelegate.m
//  CoreLocal
//
//  Created by David Phillip Oster on 7/6/24.
// this works.
// After: https://old.reddit.com/r/macosprogramming/comments/1dwq8e1/example_of_using_corelocation_on_macos/
//

#import "AppDelegate.h"
#include <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate>

@property (strong) IBOutlet NSWindow *window;
@property (strong) CLLocationManager* mgr;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self setMgr:[[CLLocationManager alloc] init]];
    [self.mgr setDelegate:self];
    [self.mgr setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.mgr setDistanceFilter:2.0];
    [self.mgr requestAlwaysAuthorization];
    [self.mgr startUpdatingLocation];
    NSLog(@"done init\n");
  });
}

- (void)locationManager:(CLLocationManager*)m didFailWithError:(NSError*)e {
  NSLog(@"CLLocationManager error: %s\n",
          [[e localizedDescription] UTF8String]);
}
- (void)locationManager:(CLLocationManager*)m
    didUpdateToLocation:(CLLocation*)l
           fromLocation:(CLLocation*)ol {
  NSLog(@"%f, %f", l.coordinate.latitude, l.coordinate.longitude);
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
  return YES;
}


@end
