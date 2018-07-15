//
//  LeftPaddinTextField.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 19/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class LeftPaddinTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width+10, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width+10, height: bounds.size.height)
    }
    
}
