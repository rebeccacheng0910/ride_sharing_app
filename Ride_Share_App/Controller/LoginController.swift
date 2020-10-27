//
//  LoginController.swift
//  Uber_Clone
//
//  Created by Xinyi Cheng on 25.10.20.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "RIDE"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()

    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: UIButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let doNotHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes:
                                                            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                             NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign up", attributes:
                                                    [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                                  NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Selector
    
    @objc func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to log user in with error \(error.localizedDescription).")
                return
            }
            
            guard let controller = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as?
                    HomeController else { return }
            controller.configureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: Helper
    
    func configureUI() {
        configureNavigationBar()
        
        view.backgroundColor = .backgroundColor
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       loginButton])
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(doNotHaveAccountButton)

        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inview: view)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                            paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        doNotHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        doNotHaveAccountButton.centerX(inview: view)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}
