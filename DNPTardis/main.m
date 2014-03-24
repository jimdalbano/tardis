//
//  main.m
//  DNPTardis
//
//  Created by Joseph Fiorini on 3/3/14.
//  Copyright (c) 2014 densitypop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LightController.h"
#import "TardisController.h"
#include <unistd.h>

void adjustBrightness(float start, float end, LightController* controller, float duration) {

    float current = start;
    int fps = 30 * duration;
    float diff = start - end;
    float step = (diff) / fps;
    float delay = duration / fps;

    float sleepCounter = 0;

    NSLog(@"fps: %d", fps);
    NSLog(@"step: %f", step);
    NSLog(@"pauseFor: %f", delay);
    controller.brightness = current;
    current -= step;

    for (int i=0; i < fps; i++) {
        controller.brightness = current;
        current -= step;
        usleep(delay * 1000000);
        sleepCounter += delay;
    }

    NSLog(@"faded for: %f", sleepCounter);
    NSLog(@"diff: %f", duration - sleepCounter);
}

void pauseFor(float secs) {
    usleep(secs * 1000000);
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        LightController* controller = [[LightController alloc] init];
        TardisController* tardis = [[TardisController alloc] init];


        controller.brightness = 0;

        sleep(1);

        [tardis takeoff];

        adjustBrightness(0, 1, controller, 0.2);
        adjustBrightness(1, 0, controller, 0.5);

        pauseFor(0.6);

        adjustBrightness(0, 1, controller, 0.2);
        adjustBrightness(1, 0, controller, 0.8);

        pauseFor(0.8);

        adjustBrightness(0, 1, controller, 0.3);
        adjustBrightness(1, 0, controller, 0.6);

        pauseFor(0.8);

        adjustBrightness(0, 1, controller, 0.5);
        adjustBrightness(1, 0, controller, 0.6);

        pauseFor(0.8);

        adjustBrightness(0, 1, controller, 0.5);
        adjustBrightness(1, 0, controller, 0.6);

        sleep(2);

        controller.brightness = 1;


    }
    return 0;
}

