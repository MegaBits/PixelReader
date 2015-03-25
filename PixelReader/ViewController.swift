//
//  ViewController.swift
//  PixelReader
//
//  Created by Andrew Hart on 25/03/2015.
//  Copyright (c) 2015 MegaBits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let inspectionImage = InspectionImage(image: UIImage(named: "unsplash")!)!
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let imageButton = UIButton()
    private let colorView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.colorView)
        
        self.imageView.image = self.inspectionImage
        self.imageView.contentMode = UIViewContentMode.TopLeft
        self.imageView.frame = CGRect(x: 0, y: 0, width: 1024, height: 683)
        self.imageButton.frame = self.imageView.bounds
        self.imageButton.addTarget(self, action: Selector("respondToImageButtonPress:event:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.contentSize = CGSize(width: 1024, height: 683)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.imageButton)
        self.view.addSubview(self.scrollView)
        
        self.view.addSubview(self.colorView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToImageButtonPress(sender: UIButton, event: UIEvent) {
        let touch = event.touchesForView(self.imageButton)!.anyObject() as UITouch
        let touchPoint = touch.locationInView(self.imageButton)
        
        let color = self.inspectionImage.colorForPixel(point: touchPoint)
        
        println("color: \(color)")
        
        if color != nil {
            self.colorView.backgroundColor = color
        } else {
            self.colorView.backgroundColor = UIColor.blackColor()
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
    }
}

