//
//  YTScrollView.h
//  App
//
//  Created by Yotako on 07/03/2018.
//  Copyright © 2018 Yotako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTScrollView : UIScrollView {
    CGFloat originalHeight;
    CGFloat originalWidth;
}
@property (nonatomic, assign) IBInspectable int maxHeight;

@end
