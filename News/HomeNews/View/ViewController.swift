//
//  ViewController.swift
//  News
//
//  Created by Juan Diego Marin on 4/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var viewModel = HackerNewsViewModel(repository: NewsRepositoty())
    
    // MARK: - Life Cycle View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getNews()
        viewModel.success = {
            self.tableView.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.news = viewModel.news[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}
