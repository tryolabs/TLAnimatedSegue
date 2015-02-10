//
//  TWAnimatedSegue.m
//  ttwick
//
//  Created by Bruno Berisso on 6/9/14.
//  Copyright (c) 2014 Bruno Berisso. All rights reserved.
//

#import "AnimatedSegue.h"



@implementation AnimatedSegue

- (void)perform {
    if (self.delegate)
        [self.delegate animateSegueFormViewController:self.sourceViewController toViewController:self.destinationViewController onComplete:^{
            [super perform];
        }];
    else
        [super perform];
}

@end
