//
//  ViewController.m
//  AnimatedSegue
//
//  Created by Bruno Berisso on 2/9/15.
//  Copyright (c) 2015 Bruno Berisso. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedSegue.h"


/*
 
 This is an example implementation the AnimatedSegueDelegate. This example has two instance of this view controller whit a ciclic navigation declared on the storyboard (the first controller present the second that present the first again). So the animation is the same on both segues. This same effect can be achieved moving the animation logic to an "animator" object that perform the animation outside the controller. This idea can be extended so you can swap the animator at run time and perform different animations for the same navigation.
 
 For more details of how the AnimatedSegue work see the README.md
 
 */



@interface ViewController () <AnimatedSegueDelegate>

@property (nonatomic, copy) void (^animationDidEnd) (void);
@property (nonatomic, weak) UIView *destinationView;

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Here we set the delegate of the segue how is the responsable to perform the animation. This can be any object that conforms to the AnimatedSegueDelegate protocol.
    
    if ([segue isKindOfClass:[AnimatedSegue class]]) {
        ((AnimatedSegue *) segue).delegate = self;
    }
}

#pragma mark - AnimatedSegueDelegate

//This is the core method of the AnimatedSegueDelegate. Here you receive the source and destination objects that perform the segue and a callback that you need to perform when your animation end.

- (void)animateSegueFormViewController:(UIViewController *)sourceController toViewController:(UIViewController *)destinationController onComplete:(void (^)(void))onComplente {
    
    UIView *sourceView = sourceController.view;
    self.destinationView = destinationController.view;
    
    //First we add the destination view to the visible view hierarchy so we can perform the transition to the visible view to the new one.
    self.destinationView.frame = sourceView.frame;
    [sourceView addSubview:self.destinationView];
    
    //This animation mask the destination view with a layer with a circle of radius 1 and animate (his radius) it to the point that it's is full visible. Because the destination view is on top of the visible view when the radius grow the destination view became visible.
    
    //Create a layer mask with the frame of the destination view
    CAShapeLayer *circleMask = [CAShapeLayer layer];
    circleMask.frame = self.destinationView.frame;
    
    //Create a path to draw the layer as a full circle of radius 1 and centred on the destination view.
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.destinationView.center radius:1.0 startAngle:0.0 endAngle:(M_PI * 2) clockwise:YES];
    circleMask.path = [circlePath CGPath];
    
    self.destinationView.layer.mask = circleMask;
    
    //Calculate the final radius of the circle
    CGSize viewSize = self.destinationView.frame.size;
    CGFloat finalRadius = (viewSize.width / 2.0) + viewSize.height / 2.0;

    //Create a basic property animation to animate the path of the layer used to mask our view
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.toValue = (__bridge id) ([[UIBezierPath bezierPathWithArcCenter:self.destinationView.center
                                                                           radius:finalRadius
                                                                       startAngle:0.0
                                                                         endAngle:(M_PI * 2)
                                                                        clockwise:YES] CGPath]);
    
    //Set the duration of the animation and set this controller as the delegate for this animation. This is needed to call the 'onComplete' callback when the animation end.
    maskAnimation.duration = 0.5;
    maskAnimation.delegate = self;
    
    //Add the animation to the mask
    [self.destinationView.layer.mask addAnimation:maskAnimation forKey:nil];
    
    self.animationDidEnd = onComplente;
}

//This method is part of the PresentSegueDelegate protocol that is a super protocol of AnimatedSegueDelgate. It allow to control how a controller will be presented. Here we are telling the segue that dismiss the visible controller _before_ present the new one. This avoid having a constantly growing list of controllers, this can produce a warning on the console about "Attempt to present <ViewController: 0xXXXXXXX> on <ViewController: 0xYYYYYY> whose view is not in the window hierarchy!".
- (BOOL)shouldDismissController:(UIViewController *)visibleController beforePresentViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark - CABasicAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //Once the animation end remove the mas from the destination view and set our reference to nil.
    self.destinationView.layer.mask = NULL;
    self.destinationView = nil;
    
    //Perform the callback to let know the AnimatedSegue that we are done with the animation and procede with the presentation of the controller.
    self.animationDidEnd();
    self.animationDidEnd = nil;
}

@end
