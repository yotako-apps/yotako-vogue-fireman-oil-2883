//
//  YTScrollView.m
//  App
//
//  Created by Yotako on 07/03/2018.
//  Copyright © 2018 Yotako. All rights reserved.
//

#import "YTScrollView.h"

@implementation YTScrollView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValue];
    }
    return self;
}

-(void)initValue {
    originalHeight = self.frame.size.height;
    originalWidth = self.frame.size.width;
}

- (void)drawRect:(CGRect)rect {
    self.maxHeight = self.maxHeight * (self.frame.size.width/originalWidth);
    self.contentSize= CGSizeMake(self.frame.size.width, self.maxHeight);
}

@end
