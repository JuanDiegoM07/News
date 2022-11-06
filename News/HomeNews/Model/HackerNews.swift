//
//  HackerNews.swift
//  News
//
//  Created by Juan Diego Marin on 4/11/22.
//

import Foundation
struct HackerNews: Decodable {
    let hits: [Hits]?
    let query: String?
    init(hits: [Hits], query: String?)  {
        self.hits = hits
        self.query = query
    }
}

struct Hits: Decodable {

    let author: String?
    let story_title: String?
    let story_url: String?
    
    init(author: String?, story_title: String?, story_url: String?) {
        self.author = author
        self.story_title = story_title
        self.story_url = story_url
        
    }
}
