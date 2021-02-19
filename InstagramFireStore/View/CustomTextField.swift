//
//  CustomTextField.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 23/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
