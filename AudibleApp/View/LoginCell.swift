//
//  LoginCell.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 19/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    //MARK: Instance variables
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "logo"))
        iv.backgroundColor = .gray
        return iv
    }()
    
    let emailTxt: LeftPaddinTextField = {
        let tx = LeftPaddinTextField()
        tx.placeholder = "Enter email"
        tx.layer.borderColor = UIColor.lightGray.cgColor
        tx.layer.borderWidth = 1
        return tx
    }()
    
    let passwordTxt: LeftPaddinTextField = {
        let tx = LeftPaddinTextField()
        tx.placeholder = "Enter password"
        tx.layer.borderColor = UIColor.lightGray.cgColor
        tx.layer.borderWidth = 1
        tx.isSecureTextEntry = true
        return tx
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "LightOrange")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginViewDelegate?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private functions
    fileprivate func setupViews() {
        [logoImageView, emailTxt, passwordTxt, loginButton].forEach({addSubview($0)})
        
        //Setup contrains
        setupContrains()
    }
    
    fileprivate func setupContrains() {
        _ = logoImageView.anchor(safeAreaLayoutGuide.centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTxt.anchor(logoImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTxt.anchor(emailTxt.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTxt.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
    @objc fileprivate func handleLogin() {
        delegate?.finishLoggedIn()
    }
    
}
