//
//  TWAnimableSegue.m
//  ttwick
//
//  Created by Bruno Berisso on 6/9/14.
//  Copyright (c) 2014 Bruno Berisso. All rights reserved.
//

#import "AnimableSegue.h"



@implementation AnimableSegue

- (void)perform {
    if (self.delegate)
        [self.delegate animateSegueFormViewController:self.sourceViewController toViewController:self.destinationViewController onComplete:^{
            [super perform];
        }];
    else
        [super perform];
}

@end
