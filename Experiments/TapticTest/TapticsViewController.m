//
//  ViewController.m
//  TapticTest
//
//  Created by Nevyn Bengtsson on 3/28/18.
//  Copyright © 2018 Nevyn Bengtsson. All rights reserved.
//

#import "TapticsViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface TapticsViewController ()
@end

@implementation TapticsViewController
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

@end
