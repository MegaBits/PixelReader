//
//  UIImage+AreaType.h
//  MegaBits
//
//  Created by Andrew Hart on 16/06/2014.
//  Copyright (c) 2014 MegaBits. All rights reserved.
//

#import <UIKit/UIKit.h>

//Pixel caching isn't included as a feature, as it takes a lot longer to cache the pixels as it goes through, rather than just reading them new.

@interface MBInspectionImage: UIImage

- (id)initWithImage:(UIImage *)image;

- (UIColor *)colorForPixelAtPoint:(CGPoint)point;
- (NSArray *)colorsForPixelsInRect:(CGRect)rect;
- (NSArray *)colorsForAllPixels;

@end