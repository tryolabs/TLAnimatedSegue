//
//  TLPresentSegue.h
//  TLAnimatedSegue
//
//  Created by Bruno Berisso on 9/16/14.
//  Copyright (c) 2014 Tryolabs. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 @abstract Notification send to the controllers involved in a segue when the presentation end.
 @discussion If some of the controllers involved in the segue conform to this protocol this method will be called on that controller.
 */

@protocol TLTransitionNotification

/**
 @abstract Call when the transition end.
 @discussion If the transition is animated and the controllers are NOT in a UINavigationController this method is called at the end of the animation. In other case the call is made just after the presentation method.
 @param controller The controller that is NOT the current one.
 */

- (void)transitionDidEnd:(nonnull id)controller;

@end


/**
 @abstract Control the presentation.
 @discussion This delegate allow to control how the presentation is perform and what happened with the controllers stack. All the methods are optional.
 */

@protocol TLPresentSegueDelegate <NSObject>

/**
 @abstract Tell the segue to use (default) animations or not.
 @discussion  This is the value of the 'animated' parameter passed to the underling presentation method.
 */

@optional
- (BOOL)shouldUseAnimations;

/**
 @abstract Control the presentation stack.
 @discussion Return YES if the current top of the presentation stack should be dismissed before present the new controller.
 @param visibleController The current top of the stack
 @param viewController The controller that is being presented
 @return YES if the visible controller should be replaced by the one being presented. NO otherwise.
 */

@optional
- (BOOL)shouldDismissController:(nonnull UIViewController *)visibleController beforePresentViewController:(nonnull UIViewController *)viewController;

@end


/**
 @abstract Present a view controller eigher on a UINavigationController stack or as a modal.
 @discussion This UIStorybiardSegue subclass present a view controller independently of how the presentation stack is handled. The main idea is to have a generic way to present a controller that don't depend on how the controllers stack is handled. This means that when performed, this segue check if the source controller is in a UINavigationController context. If it is then push the new controller on that navigation controller, otherwise it present the new controller using the 'presentViewController:animated:onComplete' method on the source view controller.
 */

@interface TLPresentSegue : UIStoryboardSegue

/**
 @abstract An object conforming to the TLPresentSegueDelegate method.
 @discussion Must be set before this segue receive the 'perform' method call
 */
@property (nonatomic, weak, nullable) id <TLPresentSegueDelegate> delegate;

@end
