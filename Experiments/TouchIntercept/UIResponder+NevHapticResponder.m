//
//  UIResponder+UIResponder_NevHaptic.m
//  TouchIntercept
//
//  Created by Nevyn Bengtsson on 3/29/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "UIResponder+NevHapticResponder.h"
#import "CGVector+TCMath.h"

static UIImpactFeedbackGenerator *g_light;
static UIImpactFeedbackGenerator *g_medium;
static CGPoint _lastImpactPoint;
static BOOL _alternate;

@implementation UIView (NevHapticResponder)
- (NevHapticTexture)haptic_texture
{
    return NevHapticTextureSmooth;
}

- (CGFloat)distanceForTexture:(NevHapticTexture)texture
{
    return texture == NevHapticTextureLightGrain ? 10 : 5;
}

- (void)haptic_touchesTraced:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!g_light) {
        g_light = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        g_medium = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.window];
    CGVector delta = TCVectorMinus(current, _lastImpactPoint);
    CGFloat distance = TCVectorLength(delta);
    
    NevHapticTexture texture = self.haptic_texture;
    
    NSLog(@"Tracing in %@. Texture %ld, distance %.2f", self, (long)texture, distance);
    
    switch (texture) {
    case NevHapticTextureSmooth:{
    } break;
    case NevHapticTextureLightGrain:
    case NevHapticTextureGrainy: {
        if(distance > [self distanceForTexture:texture]) {
            [self actuate:g_light at:current];
        }
    } break;
    case NevHapticTextureScrolly: {
        if(distance > [self distanceForTexture:texture]) {
            _alternate = !_alternate;
            [self actuate:_alternate ? g_light : g_medium at:current];
        }
    } break;
    case NevHapticTextureLowEdges:
    case NevHapticTextureHighEdges: {
        CGPoint then = [self convertPoint:_lastImpactPoint fromView:self.window];
        CGPoint now = [self convertPoint:current fromView:self.window];
        BOOL wasInBounds = CGRectContainsPoint(self.frame, then);
        BOOL isInBounds =CGRectContainsPoint(self.frame, now);
        // We crossed the edge
        if(isInBounds != wasInBounds) {
            [self actuate:texture==NevHapticTextureLowEdges ? g_light : g_medium at:current];
        }
        _lastImpactPoint = current;
    } break;
        
    }
}

- (void)actuate:(UIImpactFeedbackGenerator*)gen at:(CGPoint)where
{
    [gen impactOccurred];
    _lastImpactPoint = where;
}
@end

@implementation UIScrollView (NevHapticTexture)
- (NevHapticTexture)haptic_texture
{
    return NevHapticTextureScrolly;
}
@end
@implementation UIButton (NevHapticTexture)
- (NevHapticTexture)haptic_texture
{
    return NevHapticTextureHighEdges;
}
@end
