//
//  NewsFake.swift
//  NewsTests
//
//  Created by Juan Diego Marin on 6/11/22.
//

import Foundation

@testable import News

enum NewsFake {
    
    static var values: [HackerNews] {
        [.init(hits: hits,
               query: "")]
    }
    
    static var hits: [Hits] {
        [.init(author: "",
               story_title: "",
               story_url: "")]
    }
}
