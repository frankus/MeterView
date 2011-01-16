//
//  MeterViewAppDelegate.h
//  MeterView
//
//  Created by Frank Schmitt on 2011-01-15.
//  Copyright 2011 Laika Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeterViewViewController;

@interface MeterViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MeterViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MeterViewViewController *viewController;

@end

