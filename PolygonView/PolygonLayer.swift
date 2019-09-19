//
//  PolygonLayer.swift
//  PolygonView
//
//  Created by Damon Cricket on 19.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PolygonLayer

class PolygonLayer: CALayer {
    
    @NSManaged
    var vertices: [CGPoint]
    
    @NSManaged
    var color: CGColor
    
    // MARK: - Object LifeCycle
    
    override init() {
        super.init()
        
        postInitSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        postInitSetup()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let polygonLayer = layer as? PolygonLayer {
            vertices = polygonLayer.vertices
            color = polygonLayer.color
        }
        
        postInitSetup()
    }

    func postInitSetup() {
        contentsScale = UIScreen.main.scale
        allowsEdgeAntialiasing = true
        needsDisplayOnBoundsChange = true
    }
    
    // MARK: - Display
    
    override open class func needsDisplay(forKey key: String) -> Bool {
        if key == "vertices" {
            return true
        } else if key == "color" {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }
    
    // MARK: - Draw
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        guard vertices.count > 1 else {
            return
        }
        
        UIGraphicsPushContext(ctx)
        
        let points = vertices.map {
            CGPoint(x: $0.x * bounds.width, y: $0.y * bounds.height)
        }
        
        let firstPoint = points.first!
        
        let path = CGMutablePath()
        
        path.move(to: firstPoint)
        
        for idx in 1 ..< points.count {
            let point = points[idx]
            path.addLine(to: point)
        }
        
        path.closeSubpath()
        
        ctx.addPath(path)

        ctx.setFillColor(color)
        
        ctx.setStrokeColor(color)
        
        ctx.fillPath()
        
        UIGraphicsPopContext()
    }
}
