//
//  TLAnimatedSegue.h
//  TLAnimatedSegue
//
//  Created by Bruno Berisso on 6/9/14.
//  Copyright (c) 2014 Tryolabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPresentSegue.h"


/**
 @abstract This protocol describe the interface with an object responsable of perform the animation.
 @discussion This protocol is an extension of TLPresentSegueDelegate protocol that describe the interaction between a delegate and a TLPresentSegue object that add support for custom animated presentation.
 */
@protocol TLAnimatedSegueDelegate <TLPresentSegueDelegate>

/**
 @abstract Perform the animation.
 @discussion A tipical implementation for this method add the destination controller view as a subview of the source controller view and perfrom an animation that let the destination view in his final state.
 @param sourceController The controller fireing the segue.
 @param destinationController The controller presented with this segue.
 @param onComplete A callback that need to be called when the animation is complet.
 */

@required
- (void)animateSegueFormViewController:(id)sourceController toViewController:(id)destinationController onComplete:(void(^)(void))onComplente;

@end


/**
 @abstract Segue with support for custom animations.
 @discussion This segue with the TLAnimatedSegueDelegate protocol give support to perform custom animations to present a view controller. It support UInavigationController or modal presentation by extending the TLPresentSegue segue.
 */

@interface TLAnimatedSegue : TLPresentSegue

/**
 @abstract An object conforming to the TLAnimatedSegueDelegate
 @discussion This object is the responsable of perform the actual animation between the controllers.
 */

@property (nonatomic, weak) id <TLAnimatedSegueDelegate> delegate;

@end
