//
//  YTView.m
//  App
//
//  Created by Yotako on 27/02/2018.
//  Copyright © 2018 Yotako. All rights reserved.
//

#import "YTView.h"

@implementation YTView

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
    _addBorderTop = 0.0;
    _addBorderBottom = 0.0;
    _addBorderLeft = 0.0;
    _addBorderRight = 0.0;
    _cornerRadius = 0.0;
    _startColor = UIColor.clearColor;
    _endColor = UIColor.clearColor;
    _backgroundImgUrl = @"";
    _borderColor = UIColor.clearColor;
}

-(void)willMoveToWindow:(UIWindow *)newWindow {
    [self updateGradient];
    [self updateBorder];
    [self updateCorner];
}

-(void)updateBorder {
    if (self.addBorderTop > 0 && self.addBorderTop == self.addBorderBottom && self.addBorderTop == self.addBorderRight && self.addBorderTop == self.addBorderLeft) {
        return [self addShapeLayer:_addBorderTop];
    }
    if (self.addBorderTop > 0)  {
        [self addBorderUtility:0.0 y:0.0 width:self.bounds.size.width height:_addBorderTop];
    }
    if (self.addBorderBottom > 0) {
        [self addBorderUtility:0.0 y:self.bounds.size.height  width:self.bounds.size.width height:_addBorderBottom];
    }
    if (self.addBorderRight > 0) {
        [self addBorderUtility:0.0 y: 0.0 width:_addBorderRight height: self.bounds.size.height];
    }
    if (self.addBorderLeft > 0) {
        [self addBorderUtility:self.bounds.size.width - _addBorderLeft y:0 width: _addBorderLeft height: self.bounds.size.height];
    }
}
  
-(void) addBorderUtility:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CALayer *border = [[CALayer alloc] init];
    border.backgroundColor = self.borderColor.CGColor;
    border.frame =  CGRectMake(x, y, width, height);
    [self.layer addSublayer:border];
}

-(void)addShapeLayer:(CGFloat)size {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius].CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.path = maskLayer.path;
    borderLayer.fillColor = UIColor.clearColor.CGColor;
    borderLayer.strokeColor = self.borderColor.CGColor;
    borderLayer.lineWidth = size;
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
}
    
-(void)updateCorner {
    if (_cornerRadius > 0) {
        CGFloat smallerRatio = (self.frame.size.height / self->originalHeight ) > (self.frame.size.width / self->originalWidth ) ? (self.frame.size.width / self->originalWidth ) : (self.frame.size.height / self->originalHeight);
        self.layer.cornerRadius =  _cornerRadius * smallerRatio;
        self.layer.masksToBounds = (_cornerRadius * smallerRatio) > 0;
    }
}

-(void)updateGradient {
    CAGradientLayer *gradient  = [[CAGradientLayer alloc] init];
    gradient.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradient.colors = @[(id)[self.startColor CGColor], (id)[self.endColor CGColor]];
    gradient.zPosition = -1;
    [self.layer addSublayer:gradient];
}

#if !TARGET_INTERFACE_BUILDER
- (void) setBackgroundImgUrl:(NSString *)newValue {
    _backgroundImgUrl = newValue;
    NSURL *url = [NSURL URLWithString:newValue];
    if (url != nil) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    UIGraphicsBeginImageContext(self.frame.size);
                    [[UIImage imageWithData:data] drawInRect:self.bounds];
                    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                    if (image != nil) {
                        UIGraphicsEndImageContext();
                        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
                    }else{
                        UIGraphicsEndImageContext();
                    }
                });
            }
        });
    }
}
#endif
    
@end


