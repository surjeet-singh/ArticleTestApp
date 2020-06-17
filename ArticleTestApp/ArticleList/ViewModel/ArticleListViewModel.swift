//
//  ArticleListViewModel.swift
//  AtticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit
import ProgressHUD

class ArticleListViewModel: NSObject {

    private final let _pageLimit = 10
    private var _nextPageAvailable: Bool = true
    private var _apiInProgress = false
    
    var reloadHandler: (()->Void)?
    var insertTableRowHandler: ((_ oldCount: Int, _ newCount: Int, _ nextPage: Bool)->Void)?

    private var articlesArray = [Article]()
    
    var numberOfArticles: Int {
        return articlesArray.count
    }
    
    func articleForRow(_ row: Int) -> Article {
        return articlesArray[row]
    }
    
    func fetchArticles(showLoader: Bool = false) {
        if !_nextPageAvailable || _apiInProgress{
            return
        }
        let page =  articlesArray.count / _pageLimit + 1
        let urlStr = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(page)&limit=\(_pageLimit)"
        if showLoader {
            ProgressHUD.show()
        }
        _apiInProgress = true
        APIManager.shared.requestWebService(urlStr, params: [:], type: .get) { (completion: Result<[Article], Error>) in
            self._apiInProgress = false
            DispatchQueue.main.async {
                if showLoader {
                    ProgressHUD.dismiss()
                }
                switch completion {
                case .success(let articles):
                    
                    if !articles.isEmpty {
                        self.articlesArray.append(contentsOf: articles)
                    }
                    self._nextPageAvailable = articles.count == self._pageLimit
                    self.insertTableRowHandler?((self.articlesArray.count - articles.count), self.articlesArray.count, self._nextPageAvailable)
                    
                case .failure(let error):
                    print("Failure with error \(error.localizedDescription)")
                }
            }
        }
    }
}
