#import <LocalAuthentication/LocalAuthentication.h>

%hook CSQuickActionsViewController
-(void)_launchCamera
{
    LAContext *context = [[LAContext alloc] init];
    NSError *authError = nil;

    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:@"Open Camera"
                            reply:^(BOOL success, NSError *error)
         {
             if (success) {
                 dispatch_async(dispatch_get_main_queue(),^
                 {
                     %orig;
                 });
             } else {
             }
         }];
    } else {
        
    }
}
%end
