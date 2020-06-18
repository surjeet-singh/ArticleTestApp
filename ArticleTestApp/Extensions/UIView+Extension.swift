//
//  UIView+Extension.swift
//  ArticleTestApp
//
//  Created by Surjeet on 18/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return parentView(of: UITableView.self)
    }
}
