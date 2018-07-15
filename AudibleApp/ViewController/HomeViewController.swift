//
//  HomeViewController.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 19/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "We're logged in"
        setBarButton()
        
    }
    
    fileprivate func setBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc fileprivate func handleLogout() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        present(PageViewController(), animated: true, completion: nil)
    }

}
