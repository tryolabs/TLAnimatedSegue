//
//  TLAnimatedSegue.m
//  TLAnimatedSegue
//
//  Created by Bruno Berisso on 6/9/14.
//  Copyright (c) 2014 Tryolabs. All rights reserved.
//

#import "TLAnimatedSegue.h"



@implementation TLAnimatedSegue

@dynamic delegate;

- (void)perform {
    if (self.delegate)
        [self.delegate animateSegueFormViewController:self.sourceViewController toViewController:self.destinationViewController onComplete:^{
            [super perform];
        }];
    else
        [super perform];
}

@end
