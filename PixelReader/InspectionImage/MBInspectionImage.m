//
//  UIImage+AreaType.m
//  MegaBits
//
//  Created by Andrew Hart on 16/06/2014.
//  Copyright (c) 2014 MegaBits. All rights reserved.
//

#import "MBInspectionImage.h"

@interface MBInspectionImage ()

@property (nonatomic) CGColorSpaceRef colorSpace;
@property (nonatomic) CFDataRef pixelData;

@end

@implementation MBInspectionImage

-(id)initWithImage:(UIImage *)image {
    self = [super initWithCGImage:image.CGImage scale:image.scale orientation:image.imageOrientation];
    if (self) {
        
    }
    return self;
}

- (CGColorSpaceRef)colorSpace {
    if (!_colorSpace) {
        _colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    return _colorSpace;
}

- (CFDataRef)pixelData {
    if (!_pixelData) {
        _pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
    }
    
    return _pixelData;
}

- (void)dealloc {
    // Clean up
    if (_colorSpace) {
        CGColorSpaceRelease(_colorSpace);
        _colorSpace = nil;
    }
    
    if (_pixelData) {
        CFRelease(_pixelData);
        _pixelData = nil;
    }
}

- (NSArray *)colorsForAllPixels {
    return [self colorsForPixelsInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
}

- (NSArray *)colorsForPixelsInRect:(CGRect)rect {
    
    CGPoint point = CGPointMake(rect.origin.x, rect.origin.y);
    
    NSMutableArray *colors = [NSMutableArray new];
    
    while (true) {
        
        UIColor *color = [self colorForPixelAtPoint:point];
        
        if (color) {
            [colors addObject:color];
        }
        
        if (point.x < rect.origin.x + rect.size.width - 1) {
            point.x++;
        } else {
            if (point.y < rect.origin.y + rect.size.height - 1) {
                point.x = rect.origin.x;
                point.y++;
            } else {
                break;
            }
        }
    }
    
    return colors;
}

- (UIColor *)colorForPixelAtPoint:(CGPoint)point {
    
    point = CGPointMake(roundf(point.x), roundf(point.y));
    
    if (point.x < 0 || point.y < 0 || point.x >= self.size.width || point.y >= self.size.height) {
        return nil;
    }

    const UInt8* data = CFDataGetBytePtr(self.pixelData);
    
    int pixelInfo = ((self.size.width  * point.y) + point.x ) * 4; // The image is png
    
    UInt8 red = data[pixelInfo];         // If you need this info, enable it
    UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
//    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
    
    UIColor *pixelColor = [UIColor colorWithRed: (red / 255.0)
                                          green: (green / 255.0)
                                           blue: (blue / 255.0)
                                          alpha: 1];
    
    return pixelColor;
}

@end
