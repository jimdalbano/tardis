//
//  BrightnessController.m
//  DNPTardis
//
//  Created by Joseph Fiorini on 3/3/14.
//  Copyright (c) 2014 densitypop. All rights reserved.
//

#import "LightController.h"
#include <IOKit/graphics/IOGraphicsLib.h>

@implementation LightController

- (void) fadeUp:(float)percent in:(float)seconds token:(CGDisplayFadeReservationToken)token {
        NSLog(@"fading up to: %f", percent);
        NSLog(@"over: %f seconds", seconds);
        CGDisplayFade (token, seconds, kCGDisplayBlendNormal,
                             percent, 0, 0, 0, true); // 2
}

- (void) fadeDown:(float)percent in:(float)seconds token:(CGDisplayFadeReservationToken)token {
        NSLog(@"fading down to: %f", percent);
        NSLog(@"over: %f seconds", seconds);
        CGDisplayFade (token, seconds, percent,
                             kCGDisplayBlendNormal, 0, 0, 0, true); // 4
}

- (void)fadeDisplay {
    CGDisplayFadeReservationToken token;
    CGError err;

    err = CGAcquireDisplayFadeReservation (kCGMaxDisplayReservationInterval, &token); // 1
    if (err == kCGErrorSuccess)
    {
        err = CGDisplayFade (token, 5.0, kCGDisplayBlendNormal,
                             kCGDisplayBlendSolidColor, 255, 255, 255, true); // 2
        err = CGDisplayCapture (kCGDirectMainDisplay); // 3
        /* draw something on the captured display */
        err = CGDisplayFade (token, 5.0, kCGDisplayBlendSolidColor,
                             kCGDisplayBlendNormal, 255, 255, 255, true); // 4
        err = CGReleaseDisplayFadeReservation (token); // 5
    }
}
- (float)brightness {
    return 0;
}

// almost completely from: http://mattdanger.net/2008/12/adjust-mac-os-x-display-brightness-from-the-terminal/
- (void) setBrightness:(float) newBrightness {
    io_iterator_t iterator;
    kern_return_t result = IOServiceGetMatchingServices(kIOMasterPortDefault,
                                                        IOServiceMatching("IODisplayConnect"),
                                                        &iterator);

    // If we were successful
    if (result == kIOReturnSuccess)
    {
        io_object_t service;
        while ((service = IOIteratorNext(iterator))) {
            IODisplaySetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), newBrightness);

            // Let the object go
            IOObjectRelease(service);

            NSLog(@"Changed brightness to: %f", newBrightness);
            return;
        }
    }

}


@end
