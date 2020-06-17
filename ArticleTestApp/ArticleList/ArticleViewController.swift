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
        
        articleTableView.estimatedRowHeight = 200
        articleTableView.rowHeight = UITableView.automaticDimension
        
        initilizeViewModelHandlers()
        
        viewModel.fetchArticles(showLoader: true)
    }

    private func initilizeViewModelHandlers() {
        viewModel.insertTableRowHandler = { [weak self] (_ oldCount: Int, _ newCount: Int, _ nextPage: Bool) in
            
            let indexPaths = (oldCount ..< newCount).map { IndexPath(row: $0, section: 0) }
           
            self?.articleTableView.beginUpdates()
            self?.articleTableView.insertRows(at: indexPaths, with: .automatic)
            self?.articleTableView.endUpdates()
            self?.manageTableFooter(nextPage)
        }
    }
    
    func manageTableFooter(_ nextPageAvailable: Bool) {
        if nextPageAvailable {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: articleTableView.bounds.width, height: CGFloat(44))
            self.articleTableView.tableFooterView = spinner
        } else {
            self.articleTableView.tableFooterView = UIView()
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
        cell.setArticleData(viewModel.articleForRow(indexPath.row), indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
           // print("this is the last cell")
            viewModel.fetchArticles()
        }
    }
}

