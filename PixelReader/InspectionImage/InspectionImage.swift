//
//  InspectionImage.swift
//  PixelReader
//
//  Created by Andrew Hart on 25/03/2015.
//  Copyright (c) 2015 MegaBits. All rights reserved.
//

import UIKit

class InspectionImage: UIImage {
    private let colorSpace: CGColorSpaceRef
    private let pixelData: CFDataRef
    
    init?(image: UIImage) {
        self.colorSpace = CGColorSpaceCreateDeviceRGB()
        self.pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage))
        
        super.init(CGImage: image.CGImage!, scale: image.scale, orientation: image.imageOrientation)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorForPixel(point originalPoint: CGPoint) -> UIColor? {
        let point = CGPointMake(round(originalPoint.x), round(originalPoint.y))
        
        if point.x < 0 ||
        point.y < 0 ||
        point.x >= self.size.width ||
            point.y >= self.size.height {
                return nil
        }
        
        let data = CFDataGetBytePtr(self.pixelData)
        
        let pixelPoint = Int(((self.size.width * point.y) + point.x) * 4)
        
        let red = data[pixelPoint]
        let green = data[pixelPoint + 1]
        let blue = data[pixelPoint + 2]
        
        let color = UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0)
        
        return color
    }
}