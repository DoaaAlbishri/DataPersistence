//
//  CRUDTableViewController.swift
//  Bucket List Refactor
//
//  Created by Doaa Albishri on 12/12/2021.
//

import UIKit

class CRUDTableViewController: UITableViewController {
    weak var delegate : TableViewControllerDelegate?
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.cancelItem(self)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    var item :String?
    var indexPath :NSIndexPath?
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        delegate?.saveItem(by: self, with: textField.text!, at: indexPath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = item
        // Do any additional setup after loading the view.
    }


}
