//
//  NewsRepository.swift
//  News
//
//  Created by Juan Diego Marin on 5/11/22.
//

import Foundation
import UIKit
import CoreData

protocol NewsRepositoryProtocol {
    func getNews(completionHandler: @escaping (Result<[Hits], Error>) -> Void)
}

class NewsRepositoty: NewsRepositoryProtocol {
    
    func getNews(completionHandler: @escaping (Result<[Hits], Error>) -> Void) {
        let localNews = self.getNews()
        if localNews.hits?.count ?? 0 > 0 {
            completionHandler(.success(localNews.hits ?? []))
            return
        }
        
        let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?query=ios")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let news = try JSONDecoder().decode(HackerNews.self, from: data)
                    DispatchQueue.main.async {
                        self.deleteAllNews()
                        self.saveNew(news)
                        completionHandler(.success(news.hits ?? []))
                    }
                } catch {
                    print(error)
                }
            } else {
                print("Error")
            }
        })
        task.resume()
    }
    
    func saveNew(_ news: HackerNews) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let newsCoreData = HitsCD(context: appDelegate.persistentContainer.viewContext)
        newsCoreData.query = news.query
        appDelegate.saveContext()
        
    }
    
    private func getNews() -> HackerNews {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .init(hits: [], query: "")
        }
        
        var news: HackerNews = .init(hits: [], query: "")
        do {
            let fecthRequest: NSFetchRequest<HitsCD> = HitsCD.fetchRequest()
            let CoreDataNews = try
            appDelegate.persistentContainer.viewContext.fetch(fecthRequest)
            CoreDataNews.forEach {
                news = HackerNews(hits: [], query: $0.query!)
            }
        } catch  {
            print(error.localizedDescription)
        }
        return news
    }
    
    private func deleteAllNews() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        do {
            let fetchRequest: NSFetchRequest<HitsCD> = HitsCD.fetchRequest()
            let coreDataNews = try
            appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            coreDataNews.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
