//
//  UIResponder+UIResponder_NevHaptic.h
//  TouchIntercept
//
//  Created by Nevyn Bengtsson on 3/29/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NevHapticTexture) {
    NevHapticTextureSmooth,
    NevHapticTextureLightGrain,
    NevHapticTextureGrainy,
    NevHapticTextureScrolly,
    NevHapticTextureLowEdges,
    NevHapticTextureHighEdges,
};

@interface UIView (NevHapticResponder)
- (NevHapticTexture)haptic_texture;
- (void)haptic_touchesTraced:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end

@interface UIScrollView (NevHapticTexture)
- (NevHapticTexture)haptic_texture;
@end
@interface UIButton (NevHapticTexture)
- (NevHapticTexture)haptic_texture;
@end
