//
//  APIManager.swift
//  ArticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import Foundation

class APIManager: NSObject, URLSessionDelegate {
    
    enum HttpType: String {
        case get
        case post
        case put
        case delete
    }
    
    static let shared = APIManager()
    
    private override init() {}

// MARK:- Public functions

    func requestWebService<T: Decodable>(_ urlPath: String, params: [String: Any]? = nil, type: HttpType, completion: @escaping(Result<T, Error>) -> Void) {

        guard let url = URL(string: urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return
        }
        
        let request = prepareURLRequest(url, type: type, params: params)
        fetchData(url: request, completion: completion)
    }
    
}

extension APIManager {
    
    fileprivate func fetchData<T: Decodable>(url: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        urlSession.dataTask(withrequest: url){ (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                    // Handle custom error here
                    let error = NSError(domain:"", code: code, userInfo:nil) as Error
                    completion(.failure(error))
                    return
                }
                do {
                    let values = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    let error = NSError(domain:"JSON parsing error", code:0, userInfo:nil) as Error
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    fileprivate func prepareURLRequest(_ url: URL, type: HttpType, params: [String: Any]?) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = type.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if type == .get {
             // Add params here as query param
        } else if let dict = params {
            let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            request.httpBody = data
            request.addValue("\(data?.count ?? 0)", forHTTPHeaderField: "Content-Length")
        }
        return request
    }
}


extension URLSession {
    
    func dataTask(withrequest: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: withrequest) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
       }
    }

    
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
