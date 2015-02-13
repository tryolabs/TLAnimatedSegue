//
//  TLTLPresentSegue.m
//  TLAnimatedSegue
//
//  Created by Bruno Berisso on 9/16/14.
//  Copyright (c) 2014 Tryolabs. All rights reserved.
//

#import "TLPresentSegue.h"

@implementation TLPresentSegue

- (void)notifyCompletion {
    
    UIViewController *sourceController = self.sourceViewController;
    UIViewController *destController = self.destinationViewController;
    
    if ([sourceController conformsToProtocol:@protocol(TLTransitionNotification)])
        [sourceController performSelector:@selector(transitionDidEnd:) withObject:destController];
    
    if ([destController conformsToProtocol:@protocol(TLTransitionNotification)])
        [destController performSelector:@selector(transitionDidEnd:) withObject:sourceController];
}

- (void)perform {
    UIViewController *sourceController = self.sourceViewController;
    UIViewController *destController = self.destinationViewController;
    UINavigationController *navigationController = sourceController.navigationController;
    
    BOOL animated = NO;
    if ([self.delegate respondsToSelector:@selector(shouldUseAnimations)])
        animated = [self.delegate shouldUseAnimations];
    
    if ([self.delegate respondsToSelector:@selector(shouldDismissController:beforePresentViewController:)]) {
        
        UIViewController *visibleController = nil;
        if (navigationController)
            visibleController = navigationController.topViewController;
        else
            visibleController = sourceController;
        
        if ([self.delegate shouldDismissController:visibleController beforePresentViewController:destController]) {
            if (navigationController)
                [navigationController popViewControllerAnimated:animated];
            else
                [sourceController dismissViewControllerAnimated:animated completion:nil];
        }
    }
    
    if (navigationController) {
        [navigationController pushViewController:destController animated:animated];
        [self notifyCompletion];
    } else {
        [sourceController presentViewController:destController animated:animated completion:^{
            [self notifyCompletion];
        }];
    }
}

@end
