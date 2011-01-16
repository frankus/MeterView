//
//  MeterViewViewController.m
//  MeterView
//
//  Created by Frank Schmitt on 2011-01-15.
//  Copyright 2011 Laika Systems. All rights reserved.
//

#import "MeterViewViewController.h"
#import "MeterView.h"

@implementation MeterViewViewController

@synthesize speedometerView, voltmeterView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.speedometerView.textLabel.text = @"km/h";
	self.speedometerView.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:18.0];
	self.speedometerView.lineWidth = 2.5;
	self.speedometerView.minorTickLength = 15.0;
	self.speedometerView.needle.width = 3.0;
	self.speedometerView.textLabel.textColor = [UIColor colorWithRed:0.7 green:1.0 blue:1.0 alpha:1.0];

	self.speedometerView.value = 0.0;
	
	self.voltmeterView.startAngle = -3.0 * M_PI / 4.0;
	self.voltmeterView.arcLength = M_PI / 2.0;
	self.voltmeterView.value = 0.0;
	self.voltmeterView.textLabel.text = @"Volts";
	self.voltmeterView.minNumber = 5.0;
	self.voltmeterView.maxNumber = 20.0;
	self.voltmeterView.textLabel.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:15.0];
	self.voltmeterView.textLabel.textColor = [UIColor blackColor];
	self.voltmeterView.needle.tintColor = [UIColor brownColor];
	self.voltmeterView.needle.width = 1.0;
	
	self.voltmeterView.value = 14.4;
}

- (void)viewDidUnload {
	self.speedometerView = nil;
	self.voltmeterView = nil;
}

- (void)dealloc {
	[speedometerView release];
	[voltmeterView release];
	
    [super dealloc];
}

@end
