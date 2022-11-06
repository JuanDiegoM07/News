//
//  NewsRepositoryMock.swift
//  NewsTests
//
//  Created by Juan Diego Marin on 6/11/22.
//

import Foundation
@testable import News

class NewsRepositoryMock: NewsRepositoryProtocol {
    var news: [Hits]?

    func getNews(completionHandler: @escaping (Result<[Hits], Error>) -> Void) {
        if let news = news {
            completionHandler(.success(news))
        }
    }
    
}
