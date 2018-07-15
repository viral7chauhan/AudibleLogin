//
//  MainNavigationController.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 19/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            let home = HomeViewController()
            viewControllers = [home]
        } else {
            perform(#selector(openLoginPage), with: nil, afterDelay: 0.01)
        }
    }

    fileprivate func isLoggedIn() -> Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func openLoginPage() {
        let loginViewController = PageViewController()
        present(loginViewController, animated: true, completion: nil)
    }

}
