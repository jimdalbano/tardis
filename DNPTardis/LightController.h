//
//  BrightnessController.h
//  DNPTardis
//
//  Created by Joseph Fiorini on 3/3/14.
//  Copyright (c) 2014 densitypop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LightController : NSObject

@property (readwrite) float brightness;

- (void) fadeDisplay;
- (void) fadeUp:(float)percent in:(float)seconds token:(CGDisplayFadeReservationToken)token;
- (void) fadeDown:(float)percent in:(float)seconds token:(CGDisplayFadeReservationToken)token;

@end
