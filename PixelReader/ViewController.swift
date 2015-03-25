//
//  ViewController.swift
//  PixelReader
//
//  Created by Andrew Hart on 25/03/2015.
//  Copyright (c) 2015 MegaBits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let inspectionImage = MBInspectionImage(image: UIImage(named: "unsplash")!)!
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let imageButton = UIButton()
    private let colorView = UIView()
    private let timeTakenLabel = UILabel()
    private let inspectImageButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.colorView)
        
        self.imageView.image = self.inspectionImage
        self.imageView.contentMode = UIViewContentMode.TopLeft
        self.imageView.frame = CGRect(x: 0, y: 0, width: 1024, height: 683)
        
        self.imageButton.frame = self.imageView.bounds
        self.imageButton.addTarget(self, action: Selector("respondToImageButtonPress:event:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.inspectImageButton.setTitle("Inspect Image", forState: UIControlState.Normal)
        self.inspectImageButton.frame = CGRect(x: 10, y: 20, width: 150, height: 60)
        self.inspectImageButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.inspectImageButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.inspectImageButton.addTarget(self, action: Selector("inspectImage"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.scrollView.contentSize = CGSize(width: 1024, height: 683)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.imageButton)
        self.scrollView.addSubview(self.inspectImageButton)
        self.view.addSubview(self.scrollView)
        
        self.timeTakenLabel.font = UIFont.systemFontOfSize(14)
        self.timeTakenLabel.textAlignment = NSTextAlignment.Center
        self.colorView.addSubview(self.timeTakenLabel)
        self.view.addSubview(self.colorView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToImageButtonPress(sender: UIButton, event: UIEvent) {
        let touch = event.touchesForView(self.imageButton)!.anyObject() as UITouch
        let touchPoint = touch.locationInView(self.imageButton)
        
        let startDate = NSDate()
        
        let color = self.inspectionImage.colorForPixelAtPoint(touchPoint)
        
        let endTimeInterval = NSDate().timeIntervalSinceDate(startDate)
        
        if color != nil {
            self.colorView.backgroundColor = color
        } else {
            self.colorView.backgroundColor = UIColor.blackColor()
        }
        
        self.updateTimeTakenLabel(endTimeInterval)
    }
    
    func inspectImage() {
        let startDate = NSDate()
        
        let colors = self.inspectionImage.colorsForPixelsInRect(self.imageView.bounds)
        
        let endTimeInterval = NSDate().timeIntervalSinceDate(startDate)
        
        self.updateTimeTakenLabel(endTimeInterval)
    }
    
    private func updateTimeTakenLabel(timeInterval: NSTimeInterval) {
        
        let timeTakenString = String(format: "%.4f", timeInterval * 1000)
        
        self.timeTakenLabel.text = "Time taken (milliseconds): \(timeTakenString)"
        
        if self.colorView.backgroundColor == nil {
            return
        }
        
        var white: CGFloat = 0
        
        self.colorView.backgroundColor!.getWhite(&white, alpha: nil)
        
        if white < 0.5 {
            self.timeTakenLabel.textColor = UIColor.whiteColor()
        } else {
            self.timeTakenLabel.textColor = UIColor.blackColor()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height - 100)
        
        self.colorView.frame = CGRect(
            x: 0,
            y: self.view.frame.size.height - 100,
            width: self.view.frame.size.width,
            height: 100)
        
        self.timeTakenLabel.frame = self.colorView.bounds
    }
}

