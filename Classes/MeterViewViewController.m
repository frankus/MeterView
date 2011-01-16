//
//  MeterViewViewController.m
//  MeterView
//
//  Created by Frank Schmitt on 2011-01-15.
//  Copyright © 2011 Laika Systems
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
