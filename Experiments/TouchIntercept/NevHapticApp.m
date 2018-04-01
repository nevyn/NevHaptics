//
//  NevHapticApp.m
//  TouchIntercept
//
//  Created by Nevyn Bengtsson on 3/29/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "NevHapticApp.h"
#import "UIResponder+NevHapticResponder.h"

static const float kDeepThreshold = 2.0;

@interface NevHapticApp ()
{
    UITouch *_trackedTouch;
    BOOL _isDeepPressing;
}
@end

@implementation NevHapticApp
- (void)sendEvent:(UIEvent *)event
{
    if(
        [event type] == UIEventTypeTouches &&
        [self keyWindow].traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable
    ) {
        // If we weren't already tracking a touch, we start now. Then discard event.
        if(!_trackedTouch) {
            for(UITouch *touch in event.allTouches) {
                if(touch.phase == UITouchPhaseBegan) {
                    _trackedTouch = touch;
                    NSLog(@"Ok, now tracking %@", _trackedTouch);
                }
            }
            return;
        }
        
        // we are tracking. If we're not already deep, and now pressure is hard enough, go deep.
        if(!_isDeepPressing && _trackedTouch.force > kDeepThreshold) {
            _isDeepPressing = YES;
            NSLog(@"Started deep pressing");
            // TODO: send first a TouchesBegan, and THEN the current event.
        }
        
        // Before we start handing off touch events to app, check for ended or cancelled.
        if(_trackedTouch.phase == UITouchPhaseEnded || _trackedTouch.phase == UITouchPhaseCancelled) {
            NSLog(@"Stopped %@ pressing", _isDeepPressing ? @"deep" : @"trace");
            if(_isDeepPressing) {
                [super sendEvent:event];
            }
            _trackedTouch = nil;
            _isDeepPressing = NO;
            return;
        }
        
        // ok, we have an event, and it's not ended, and we're tracking.
        // if it's deep, just end it off as a regular event.
        if(_isDeepPressing) {
            NSLog(@"Super deep");
            [super sendEvent:event];
            return;
        }
        // if it's not deep, discard anything that's not a move. if it's a move, track it as a trace.
        if(_trackedTouch.phase == UITouchPhaseMoved) {
            NSLog(@"Tracing");
            UIView *preciseView = _trackedTouch.view; // todo: hit test with precise location
            [preciseView haptic_touchesTraced:[NSSet setWithObject:_trackedTouch] withEvent:event];
            return;
        }
    } else {
        NSLog(@"Super other");
        [super sendEvent:event];
    }
}
@end
