//
//  ViewController.m
//  TapticTest
//
//  Created by Nevyn Bengtsson on 3/28/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "TextureView.h"

@interface ViewController ()
{
}
@property (weak, nonatomic) IBOutlet UISlider *smoothnessSlider;
@property (weak, nonatomic) IBOutlet UILabel *smoothnessLabel;
@property (weak, nonatomic) IBOutlet TextureView *textureView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self smoothnessChanged:_smoothnessSlider];
}
- (IBAction)light:(id)sender {
    UIImpactFeedbackGenerator *gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [gen impactOccurred];
    
}
- (IBAction)medium:(id)sender {
    UIImpactFeedbackGenerator *gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [gen impactOccurred];
}
- (IBAction)heavy:(id)sender {
    UIImpactFeedbackGenerator *gen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [gen impactOccurred];
}

- (IBAction)error:(id)sender {
    UINotificationFeedbackGenerator *gen = [[UINotificationFeedbackGenerator alloc] init];
    [gen notificationOccurred:UINotificationFeedbackTypeError];
}
- (IBAction)success:(id)sender {
    UINotificationFeedbackGenerator *gen = [[UINotificationFeedbackGenerator alloc] init];
    [gen notificationOccurred:UINotificationFeedbackTypeSuccess];
}
- (IBAction)warning:(id)sender {
    UINotificationFeedbackGenerator *gen = [[UINotificationFeedbackGenerator alloc] init];
    [gen notificationOccurred:UINotificationFeedbackTypeWarning];
}

- (IBAction)selection:(id)sender {
    UISelectionFeedbackGenerator *gen = [[UISelectionFeedbackGenerator alloc] init];
    [gen selectionChanged];
}

- (IBAction)peek:(id)sender {
    AudioServicesPlaySystemSound(1519);

}
- (IBAction)pop:(id)sender {
    AudioServicesPlaySystemSound(1520);

}
- (IBAction)cancelled:(id)sender {
    AudioServicesPlaySystemSound(1521);

}
- (IBAction)tryAgain:(id)sender {
    AudioServicesPlaySystemSound(1102);

}
- (IBAction)failed:(id)sender {
    AudioServicesPlaySystemSound(1107);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)smoothnessChanged:(UISlider*)sender {
    _textureView.smoothness = [sender value];
    _smoothnessLabel.text = [NSString stringWithFormat:@"%.1f", _textureView.smoothness];
}


@end
