//
//  YTImageView.h
//  App
//
//  Created by Yotako on 27/02/2018.
//  Copyright © 2018 Yotako. All rights reserved.
//

#ifndef YTImageView_h
#define YTImageView_h
#import <UIKit/UIKit.h>

@interface YTImageView : UIImageView {
    CGFloat originalHeight;
    CGFloat originalWidth;
}
@property (nonatomic, assign) IBInspectable CGFloat addBorderTop;
@property (nonatomic, assign) IBInspectable CGFloat addBorderBottom;
@property (nonatomic, assign) IBInspectable CGFloat addBorderLeft;
@property (nonatomic, assign) IBInspectable CGFloat addBorderRight;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIColor *startColor;
@property (nonatomic) IBInspectable UIColor *endColor;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable NSString *stringUrl;

@end

#endif /* YTImageView_h */
