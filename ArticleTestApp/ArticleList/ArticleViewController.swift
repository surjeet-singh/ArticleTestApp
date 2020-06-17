//
//  ArticleViewController.swift.swift
//  AtticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var articleTableView: UITableView!
    
    let viewModel = ArticleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Article"
        
        articleTableView.tableFooterView = UIView()
        articleTableView.estimatedRowHeight = 200
        articleTableView.rowHeight = UITableView.automaticDimension
        
        initilizeViewModelHandlers()
        
        viewModel.fetchArticles()
    }

    private func initilizeViewModelHandlers() {
        viewModel.insertTableRowHandler = { [weak self] (_ oldCount: Int, _ newCount: Int) in
            
            let indexPaths = (oldCount ..< newCount).map { IndexPath(row: $0, section: 0) }
           
            self?.articleTableView.beginUpdates()
            self?.articleTableView.insertRows(at: indexPaths, with: .automatic)
            self?.articleTableView.endUpdates()
        }
    }
    
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleListCell else {
            return UITableViewCell()
        }
        cell.setArticleData(viewModel.articleForRow(indexPath.row))
        return cell
    }
}

