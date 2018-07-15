//
//  Page.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 18/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import Foundation

struct Page {
    let title: String
    let message: String
    let imageName: String
    
    static func pages() -> [Page] {
        let firstPage = Page(title: "Share a greate listen", message: "It's free to send your books to the people of your life. Every recipient's first book is on us", imageName: "page1")
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        return [firstPage, secondPage, thirdPage]
    }
}

