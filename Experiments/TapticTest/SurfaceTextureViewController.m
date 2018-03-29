//
//  SurfaceTextureViewController.m
//  TapticTest
//
//  Created by Nevyn Bengtsson on 3/29/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "SurfaceTextureViewController.h"
#import "TextureView.h"

@interface SurfaceTextureViewController ()
@property (weak, nonatomic) IBOutlet UISlider *smoothnessSlider;
@property (weak, nonatomic) IBOutlet UILabel *smoothnessLabel;
@property (weak, nonatomic) IBOutlet TextureView *textureView;
@end

@implementation SurfaceTextureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self smoothnessChanged:_smoothnessSlider];
}

- (IBAction)smoothnessChanged:(UISlider*)sender {
    _textureView.smoothness = [sender value];
    _smoothnessLabel.text = [NSString stringWithFormat:@"%.1f", _textureView.smoothness];
}

@end
