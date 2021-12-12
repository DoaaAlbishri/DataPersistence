//
//  TableViewControllerDelegate.swift
//  Bucket List Refactor
//
//  Created by Doaa Albishri on 12/12/2021.
//

import Foundation
import UIKit
protocol TableViewControllerDelegate:class {
    func saveItem(by controller: CRUDTableViewController, with text:String , at indexPath:NSIndexPath?)
    func cancelItem(_ controller: CRUDTableViewController)
}

