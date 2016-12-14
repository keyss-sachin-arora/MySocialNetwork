//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by Mac Mini on 12/12/16.
//  Copyright © 2016 Mac Mini. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = UIColor(red: shadowGray, green: shadowGray, blue: shadowGray, alpha: 0.6).cgColor
        imageView?.contentMode = .scaleAspectFit
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
    }
}
