//
//  tokenView.m
//  Connexion
//
//  Created by Christopher Cohen on 5/6/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import "tokenButton.h"
#import "StyleKitName.h"

@implementation tokenButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [StyleKitName drawCanvas2];
}


@end
