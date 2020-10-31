//
//  LocationInputView.swift
//  Ride_Share_App
//
//  Created by Xinyi Cheng on 30.10.20.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    
    // MARK: Properties
    
    var user: User? {
        didSet{ titleLabel.text = user?.fullname}
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .systemGroupedBackground
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isEnabled = false
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a destination"
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    weak var delegate: LocationInputViewDelegate?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addShadow()
    
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(startingLocationTextField)
        addSubview(destinationLocationTextField)
        addSubview(startLocationIndicatorView)
        addSubview(linkingView)
        addSubview(destinationIndicatorView)
        
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44,
                          paddingLeft: 12, width: 24, height: 25)
        
        
        titleLabel.centerX(inview: self)
        titleLabel.centerY(inview: backButton)
        
        
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                         paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                         paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        startLocationIndicatorView.centerY(inview: startingLocationTextField)
        startLocationIndicatorView.anchor(left: leftAnchor, paddingLeft: 20)
        startLocationIndicatorView.setDimension(height: 6, width: 6)
        startLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        destinationIndicatorView.centerY(inview: destinationLocationTextField)
        destinationIndicatorView.anchor(left: leftAnchor, paddingLeft: 20)
        destinationIndicatorView.setDimension(height: 6, width: 6)
        
        linkingView.centerX(inview: startLocationIndicatorView)
        linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor,
                           paddingTop: 4, paddingBottom: 4, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selector
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
}
