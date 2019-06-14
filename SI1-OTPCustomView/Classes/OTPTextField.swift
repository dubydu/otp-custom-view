//
//  OTPTextField.swift
//  OTPCodeUniversal
//
//  Created by DU on 6/13/19.
//  Copyright © 2019 dubydu. All rights reserved.
//

import UIKit

class OTPTextField: UITextField {
    
    // MARK: - Properties
    var borderColor: UIColor = UIColor.black
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat!
    var shapeLayer: CAShapeLayer!
    
    // MARK: - Initialization Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initalizeUI(forFieldType type: OTPView.OTPType) {
        switch type {
        case .circular:
            layer.cornerRadius = bounds.size.width / 2
        case .square:
            layer.cornerRadius = 0
        case .firstBaseLine:
            addBottomView()
        case .corner:
            layer.cornerRadius = cornerRadius
        }
        
        if type != .firstBaseLine {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
        }
        autocorrectionType = .no
        textAlignment = .center
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
    
    private func addBottomView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.close()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = borderWidth
        shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}
