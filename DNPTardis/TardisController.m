//
//  TardisController.m
//  DNPTardis
//
//  Created by Joseph Fiorini on 3/4/14.
//  Copyright (c) 2014 densitypop. All rights reserved.
//

#import "TardisController.h"
#import <AVFoundation/AVFoundation.h>

@interface TardisController ()

@property(retain,nonatomic) AVAudioPlayer *player;

@end
@implementation TardisController

- (void) takeoff {

    NSString *file =[[NSBundle mainBundle] pathForResource:@"Takeoff1" ofType:@"wav"];
    NSError* error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:file] error:&error];
    if(error) {
        NSLog(@"Error playing sound: %@", error);
        exit(1);
    }
    [self.player play];
}
@end
