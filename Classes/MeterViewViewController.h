//
//  MeterViewViewController.h
//  MeterView
//
//  Created by Frank Schmitt on 2011-01-15.
//  Copyright 2011 Laika Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeterView;

@interface MeterViewViewController : UIViewController {
	MeterView *speedometerView;
	MeterView *voltmeterView;
}

@property (nonatomic, retain) IBOutlet MeterView *speedometerView;
@property (nonatomic, retain) IBOutlet MeterView *voltmeterView;

@end

