//
//  CustomField.swift
//  SocialNetwork
//
//  Created by Mac Mini on 12/12/16.
//  Copyright © 2016 Mac Mini. All rights reserved.
//

import UIKit

class CustomField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
}
