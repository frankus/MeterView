//
//  MeterView.m
//  MeterTest
//
//  Created by Frank Schmitt on 2010-12-04.
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

#import "MeterView.h"
#import <math.h>

@implementation MeterNeedle

@synthesize length, width;
@synthesize tintColor = tintColor_;

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx {	
	CGContextSaveGState(ctx);

	CATransform3D transform = layer.transform;
	
	layer.transform = CATransform3DIdentity;
	
	CGContextSetFillColorWithColor(ctx, self.tintColor.CGColor);
	CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
	CGContextSetLineWidth(ctx, self.width);
	
	CGFloat centerX = layer.frame.size.width / 2.0;
	CGFloat centerY = layer.frame.size.height / 2.0;
	
	CGFloat ellipseRadius = self.width * 2.0;
	
	CGContextFillEllipseInRect(ctx, CGRectMake(centerX - ellipseRadius, centerY - ellipseRadius, ellipseRadius * 2.0, ellipseRadius * 2.0));
	
	CGFloat endX = (1 + self.length) * centerX;
	
	CGContextBeginPath(ctx);
	CGContextMoveToPoint(ctx, centerX, centerY);
	CGContextAddLineToPoint(ctx, endX, centerY);	
	CGContextStrokePath(ctx);
		
	layer.transform = transform;
	
	CGContextRestoreGState(ctx);
}

- (void)dealloc {
	[tintColor_ release];
	
	[super dealloc];
}
@end

@implementation MeterView

@synthesize minNumber, maxNumber, startAngle, arcLength, lineWidth;
@synthesize tickInset, tickLength, minorTickLength;
@synthesize value;

@synthesize textLabel = textLabel_;
@synthesize needle = needle_;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self initialize];
	}
    return self;
}

- (void)awakeFromNib {
	[self initialize];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	int maxNumberOfTicks = (arcLength * self.frame.size.width) / (self.textLabel.font.pointSize * 10.0);
	
	float range = self.maxNumber - self.minNumber;
	
	float maxTickIncrement = range / maxNumberOfTicks;
	
	int power = 0;
	float temp = maxTickIncrement;
	
	while (temp >= 1.0) {
		temp = temp / 10.0;
		power ++;
	}
	
	float exponent = pow(10, power);
	if (temp < 0.2) {
		tickIncrement = 0.1 * exponent;
		minorTickIncrement = tickIncrement / 5.0;
	} else if (temp < 0.5) {
		tickIncrement = 0.2 * pow(10, power);
		minorTickIncrement = tickIncrement / 4.0;
	} else if (temp < 1.0) {
		tickIncrement = 0.5 * pow(10, power);
		minorTickIncrement = tickIncrement / 5.0;
	} else {
		tickIncrement = 1.0 * pow(10, power);		
		minorTickIncrement = tickIncrement / 5.0;
	}
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	CGFloat centerX = self.frame.size.width / 2.0;
	CGFloat centerY = self.frame.size.height / 2.0;
	CGFloat radius = fmin(self.frame.size.width, self.frame.size.height) / 2;
	
	int numberOfMinorTicks = (self.maxNumber - self.minNumber) / minorTickIncrement;
	
	CGPoint *points = (CGPoint*)malloc(sizeof(CGPoint) * numberOfMinorTicks * 2 + 2);
	
	CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
	CGContextFillRect(ctx, layer.bounds);
	
	CGContextSetStrokeColorWithColor(ctx, self.textLabel.textColor.CGColor);
	CGContextSetFillColorWithColor(ctx, self.textLabel.textColor.CGColor);
	
	CGContextSetLineWidth(ctx, self.lineWidth);
	CGContextBeginPath(ctx);
	
	CGContextSetTextDrawingMode(ctx, kCGTextFill);
	CGContextSelectFont(ctx, [self.textLabel.font.fontName UTF8String], self.textLabel.font.pointSize, kCGEncodingMacRoman);
	CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
	CGContextSetTextMatrix(ctx, transform);
	
	float minorTickAngleIncrement = self.arcLength / (float)numberOfMinorTicks;
	
	float textHeight = self.textLabel.font.lineHeight;
	float textInset = textHeight + tickLength;
	
	float angle = startAngle;
	int i = 0;
	for (float f = self.minNumber; f <= self.maxNumber; f += minorTickIncrement) {
		points[i++] = CGPointMake(centerX + cos(angle) * (radius - tickInset), centerY + sin(angle) * (radius - tickInset));
		
		CGFloat myTickLength;
		
		if (fabs((f / tickIncrement - (int)(f / tickIncrement))) < 0.05) { // if is major tick
			myTickLength = self.tickLength;
			NSString *string = [[NSString alloc] initWithFormat:@"%1.0f", f];
							
			float textWidth = textHeight * [string length] / 2;
			CGContextShowTextAtPoint(ctx, centerX + cos(angle) * (radius - textInset) - textWidth / 2.0, centerY + sin(angle) * (radius - textInset) + textHeight / 4.0, [string UTF8String], [string length]);
			[string release];
		} else {
			myTickLength = self.minorTickLength;
		}
		
		points[i++] = CGPointMake(centerX + cos(angle) * (radius - myTickLength - tickInset), centerY + sin(angle) * (radius - myTickLength - tickInset));
		
		angle += minorTickAngleIncrement;
	}
	
	CGContextStrokeLineSegments(ctx, points, numberOfMinorTicks * 2 + 2);
	free(points);
	
	CGContextBeginPath(ctx);
	float epsilon = lineWidth / (radius * M_PI * 2);
	CGContextAddArc(ctx, centerX, centerY, radius - self.tickInset, self.startAngle - epsilon, self.startAngle + self.arcLength + epsilon, NO);
	CGContextStrokePath(ctx);
}

- (void)drawRect:(CGRect)rect {
}

- (void)initialize {
	CGFloat span = fmin(self.frame.size.width, self.frame.size.height);
	
	self.minNumber = 0.0;
	self.maxNumber = 100.0;
	self.startAngle = M_PI;
	self.arcLength = 3.0 * M_PI / 2.0;
	self.lineWidth = span / 200.0;
	self.tickLength = span / 12.0;
	self.minorTickLength = span / 16.0;
	self.tickInset = self.lineWidth;
	
	textLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 3.0 * self.frame.size.height / 10.0, self.frame.size.width, self.frame.size.height / 10.0)];
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.backgroundColor = [UIColor clearColor];
	self.textLabel.textAlignment = UITextAlignmentCenter;
	self.textLabel.font = [UIFont systemFontOfSize:span / 17.77];
	[self addSubview:self.textLabel];
	
	needle_ = [[MeterNeedle alloc] init];
	self.needle.tintColor = [UIColor orangeColor];
	self.needle.width = 2.0;
	self.needle.length = 0.8;
		
	needleLayer = [[CALayer layer] retain];
	needleLayer.bounds = self.bounds;
	needleLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
	needleLayer.needsDisplayOnBoundsChange = YES;
	needleLayer.delegate = self.needle;
	
	[self.layer addSublayer:needleLayer];
	
	[needleLayer setNeedsDisplay];
}

- (void)setValue:(float)val {
	if (val > self.maxNumber)
		val = self.maxNumber;
	if (val < self.minNumber)
		val = self.minNumber;
	
	CGFloat angle = self.startAngle + arcLength * val / (self.maxNumber - self.minNumber) - arcLength * (self.minNumber / (self.maxNumber - self.minNumber));
		
	needleLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
}

- (void)dealloc {
	[needle_ release];
	[textLabel_ release];
	
	[needleLayer release];
	
    [super dealloc];
}

@end

