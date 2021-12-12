//
//  ViewController.swift
//  Data Persistence
//
//  Created by Doaa Albishri on 12/12/2021.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, TableViewControllerDelegate {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketList")
        do {
            let results = try managedObjectContext.fetch(request)
            items = results as! [BucketList]
        } catch {
            print("\(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchAllItems()
    }
    var items = [BucketList]()
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row].text!
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
        let nav = segue.destination as! UINavigationController
        let CRUDItemController = nav.topViewController as! CRUDTableViewController
        CRUDItemController.delegate = self
        }else if sender is IndexPath{
            let nav = segue.destination as! UINavigationController
            let CRUDItemController = nav.topViewController as! CRUDTableViewController
            CRUDItemController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            CRUDItemController.item = item.text!
            CRUDItemController.indexPath = indexPath
        }
    }
 // use this when i didn't have accessory button
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
     */
    // edit item
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue", sender: indexPath)
    }
    // delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        saveDataChanges()
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func cancelItem(_ controller: CRUDTableViewController){
        dismiss(animated: true, completion: nil)
    }
    func saveItem(by controller: CRUDTableViewController, with text:String , at indexPath:NSIndexPath?){
        if let ip = indexPath {
            items[ip.row].text = text
        }else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketList", into: managedObjectContext) as! BucketList
            item.text = text
        items.append(item)
        }
        saveDataChanges()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func saveDataChanges(){
        // This code is identical to the saveContext method in our AppDelegate
        // Try and reference that method to make your code cleaner!
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        // can be just this code
        /*
         do {
             try managedObjectContext.save()
         } catch {
             print("\(error)")
         }
         */
    }

}


