//
//  UserDefault+helper.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 28/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultKey: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn (value: Bool) {
        set(value, forKey: UserDefaultKey.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn () -> Bool {
        return bool(forKey: UserDefaultKey.isLoggedIn.rawValue)
    }
}
