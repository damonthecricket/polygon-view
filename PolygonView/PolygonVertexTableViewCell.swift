//
//  PolygonVertexTableViewCell.swift
//  PolygonView
//
//  Created by Damon Cricket on 19.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PolygonVertexTableViewCell

protocol PolygonVertexTableViewCellDelegate: class {
    
    func polygonVertexTableViewCell(_ cell: PolygonVertexTableViewCell, didChangeText textField: UITextField)
}

// MARK: - PolygonVertexTableViewCell

class PolygonVertexTableViewCell: UITableViewCell {
    
    weak var delegate: PolygonVertexTableViewCellDelegate?
    
    @IBOutlet weak var xTextField: UITextField?
    
    @IBOutlet weak var yTextField: UITextField?
    
    // MARK: - Object LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        xTextField?.addTarget(self, action: #selector(textDidChanged(sender:)), for: .editingChanged)
        yTextField?.addTarget(self, action: #selector(textDidChanged(sender:)), for: .editingChanged)
    }
    
    // MARK: - Adjust
    
    func adjust(withPoint point: CGPoint) {
        xTextField?.text = "\(point.x)"
        yTextField?.text = "\(point.y)"
    }
    
    // MARK: - UIActions
    
    @objc func textDidChanged(sender: UITextField) {
        delegate?.polygonVertexTableViewCell(self, didChangeText: sender)
    }
}
