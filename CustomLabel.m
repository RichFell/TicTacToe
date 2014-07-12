//
//  CustomLabel.m
//  TicTacToe
//
//  Created by Richard Fellure on 7/12/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.canTap = YES;
    }
    return self;
}

@end
