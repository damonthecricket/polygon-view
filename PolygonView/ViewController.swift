//
//  ViewController.swift
//  PolygonView
//
//  Created by Damon Cricket on 19.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PolygonVertexTableViewCellDelegate {
    
    @IBOutlet weak var changeBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var polygonView: PolygonView?
    
    var vertices: [CGPoint] = []

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.tableFooterView = UIView()
        
        polygonView?.vertices = [
            CGPoint(x: 0.0, y: 0.0),
            CGPoint(x: 1.0, y: 0.0),
            CGPoint(x: 1.0, y: 1.0),
            CGPoint(x: 0.2, y: 0.8)
        ]
        
        polygonView?.color = UIColor.red
        
        vertices = polygonView!.vertices
    }
    
    // MARK: - UIActions
    
    @IBAction func changeBarButtonItemTap(sender: UIBarButtonItem) {
        var cellPoints: [CGPoint] = []
        
        for idx in 0 ..< vertices.count {
            let indexPath = IndexPath(row: idx, section: 0)
            let cell = tableView!.cellForRow(at: indexPath) as! PolygonVertexTableViewCell
            
            let x = cell.xTextField!.cgFloat
            let y = cell.yTextField!.cgFloat
            
            let point = CGPoint(x: x, y: y)
            
            cellPoints.append(point)
        }
        
        
        let animation = CABasicAnimation(keyPath: "vertices")
        animation.fromValue = polygonView!.vertices
        animation.toValue = cellPoints
        animation.duration = 0.5
        polygonView?.layer.add(animation, forKey: "vertices")
        polygonView?.vertices = cellPoints
    }
    
    // MARK: - UITableViewDataSource / UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vertices.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < vertices.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "vertex.cell.identifier", for: indexPath) as! PolygonVertexTableViewCell
            let vertex = vertices[indexPath.row]
            cell.adjust(withPoint: vertex)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "add.cell.identifier", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vertex = CGPoint(x: 0.0, y: 0.0)
        
        vertices.append(vertex)
        
        tableView.beginUpdates()
        
        let newRowIndexPath = IndexPath(row: vertices.count - 1, section: 0)
            
        tableView.insertRows(at: [newRowIndexPath], with: .automatic)
        
        tableView.scrollToRow(at: newRowIndexPath, at: .bottom, animated: true)
        
        tableView.endUpdates()
    }
    
    // MARK: - PolygonVertextTableViewCellDelegate
    
    func polygonVertexTableViewCell(_ cell: PolygonVertexTableViewCell, didChangeText textField: UITextField) {
        changeBarButtonItem?.isEnabled = cell.xTextField!.isText && cell.yTextField!.isText
    }
}

// MARK: - Extensions

extension UITextField {
    
    var isText: Bool {
        return text != nil && !text!.isEmpty
    }
    
    var cgFloat: CGFloat {
        return CGFloat(double)
    }
    
    var double: Double {
        return isText ? ((text! as NSString).replacingOccurrences(of: ",", with: ".") as NSString).doubleValue : 0.0
    }
}
