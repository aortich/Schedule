//
//  UITableView+Reusable.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, with identifier: String, as cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            preconditionFailure("Failed to dequeue cell with identifier \(identifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with identifier: String, as viewType: T.Type = T.self) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            preconditionFailure("Failed to dequeue header with identifier \(identifier)")
        }
        
        return view
    }
}

