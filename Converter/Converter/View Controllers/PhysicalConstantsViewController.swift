//
//  PhysicalConstantsViewController.swift
//  Converter
//
//  Created by shakil on 15/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

class PhysicalConstantsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }
}
