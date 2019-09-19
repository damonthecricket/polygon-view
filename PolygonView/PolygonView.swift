//
//  PolygonView.swift
//  PolygonView
//
//  Created by Damon Cricket on 19.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PolygonView

class PolygonView: UIView {

    var vertices: [CGPoint] {
        set {
            polygonLayer.vertices = newValue
        } get {
            return polygonLayer.vertices
        }
    }
    
    var color: UIColor {
        set {
            polygonLayer.color = newValue.cgColor
        } get {
            return UIColor(cgColor: polygonLayer.color)
        }
    }
    
    var polygonLayer: PolygonLayer {
        return layer as! PolygonLayer
    }
    
    override open class var layerClass: AnyClass {
        return PolygonLayer.self
    }
}
