//
//  ViewController.swift
//  PolygonView
//
//  Created by Damon Cricket on 19.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    @IBOutlet weak var polygonView: PolygonView?

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        polygonView?.vertices = [
            CGPoint(x: 0.0, y: 0.0),
            CGPoint(x: 1.0, y: 0.0),
            CGPoint(x: 1.0, y: 1.0),
            CGPoint(x: 0.2, y: 0.8)
        ]
        
        polygonView?.color = UIColor.red
    }
}

