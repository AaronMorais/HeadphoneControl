//
//  HPCAppDelegate.m
//  HeadphoneControl
//
//  Created by Aaron Morais on 2013-10-22.
//  Copyright (c) 2013 Aaron Morais. All rights reserved.
//

#import "HPCAppDelegate.h"

@implementation HPCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"relaunchOnLogin":@YES}];
}

@end
