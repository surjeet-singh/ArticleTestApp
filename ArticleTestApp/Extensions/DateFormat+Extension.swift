//
//  DateFormatter+Extension.swift
//  ArticleTestApp
//
//  Created by Surjeet on 17/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

extension String {
    
    func formatedDate(_ oldformat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", _ newFormat: String = "yyyy-MM-dd HH:mm") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldformat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = newFormat
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
