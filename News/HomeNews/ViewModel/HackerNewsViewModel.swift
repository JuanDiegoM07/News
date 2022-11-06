//
//  HackerNewsViewModel.swift
//  News
//
//  Created by Juan Diego Marin on 4/11/22.
//

import Foundation


class HackerNewsViewModel {
    
    // MARK: - Internal Properties
    var error: (String) -> Void = { _ in}
    var success: () -> Void = { }
    var news: [Hits] = []
    
    // MARK: - Private Properties
    
    private var repository: NewsRepositoryProtocol!
    
    init(repository: NewsRepositoryProtocol) {
        
        self.repository = repository
    }
    
    func getNews() {
        repository.getNews { result in
            switch result {
            case .success(let news):
                self.news = news
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
}
