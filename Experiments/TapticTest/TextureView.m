//
//  TextureView.m
//  TapticTest
//
//  Created by Nevyn Bengtsson on 3/29/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "TextureView.h"
#import "CGVector+TCMath.h"

@implementation TextureView
{
    UIImpactFeedbackGenerator *_gen;
    UITouch *_trackedTouch;
    CGPoint _lastImpactPoint;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    _gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [_gen prepare];
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!_trackedTouch) {
        _trackedTouch = [touches anyObject];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!_trackedTouch || ![touches containsObject:_trackedTouch]) {
        return;
    }
    
    CGPoint current = [_trackedTouch preciseLocationInView:self];
    CGVector delta = TCVectorMinus(current, _lastImpactPoint);
    if(TCVectorLength(delta) > _smoothness) {
        [self actuate];
        _lastImpactPoint = current;
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([touches containsObject:_trackedTouch]) {
        _trackedTouch = nil;
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([touches containsObject:_trackedTouch]) {
        _trackedTouch = nil;
    }
}

- (void)actuate
{
    [_gen impactOccurred];
    [_gen prepare];
}
@end
