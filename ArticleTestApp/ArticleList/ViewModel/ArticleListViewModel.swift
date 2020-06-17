//
//  ArticleListViewModel.swift
//  AtticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

class ArticleListViewModel: NSObject {

    var reloadHandler: (()->Void)?
    var insertTableRowHandler: ((_ oldCount: Int, _ newCount: Int)->Void)?

    var articlesArray = [Article]()
    
    var numberOfArticles: Int {
        return articlesArray.count
    }
    
    func articleForRow(_ row: Int) -> Article {
        return articlesArray[row]
    }
    
    func fetchArticles() {
        let urlStr = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"
        
        APIManager.shared.requestWebService(urlStr, params: [:], type: .get) { (completion: Result<[Article], Error>) in
            switch completion {
                
            case .success(let articles):
                print("Success")
                 print("New Array: \(articles.count)")
                if !articles.isEmpty {
                    self.articlesArray.append(contentsOf: articles)
                }
                self.insertTableRowHandler?((self.articlesArray.count - articles.count), self.articlesArray.count)
                print("Total Count: \(self.articlesArray.count)")
            case .failure(let error):
                print("Failure with error \(error.localizedDescription)")
            }
        }
    }
}
