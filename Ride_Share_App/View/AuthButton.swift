//
//  AuthButton.swift
//  Uber_Clone
//
//  Created by Xinyi Cheng on 26.10.20.
//

import UIKit

class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        backgroundColor = .mainBlueTint
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
