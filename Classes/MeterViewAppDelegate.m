//
//  MeterViewAppDelegate.m
//  MeterView
//
//  Created by Frank Schmitt on 2011-01-15.
//  Copyright 2011 Laika Systems. All rights reserved.
//

#import "MeterViewAppDelegate.h"
#import "MeterViewViewController.h"

@implementation MeterViewAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
