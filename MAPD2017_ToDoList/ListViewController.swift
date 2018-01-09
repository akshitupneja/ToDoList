//
//  ListViewController.swift
//  MAPD2017_ToDoList
//
//  Created by Akshit Upneja on 2017-12-31.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import UIKit
import os.log

class ListViewController: UITableViewController {
    
    var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedLists = loadLists() {
            lists += savedLists
        }
        else {
            // Load the sample data.
            loadSampleLists()
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        
        let list = lists[indexPath.row]
        
        cell.title.text = list.title
        cell.subtitle.text = list.notes
        //cell.backgroundColor = list.color
        //cell.listNameLabel.textColor = UIColor.white
        //on checkbox click
        cell.onClick = { cell in
            
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            let list = self.lists[indexPath.row]
            print("Row \(list.title) " )
            
            //switch status
            list.isCompleted = !list.isCompleted
            self.saveLists()
            tableView.reloadData()
        }
        
        //returning correct icons and colors for each item's status
        if list.isCompleted {
            // Introducing the statusji™
            cell.title.textColor = UIColor.gray
            cell.subtitle.textColor = UIColor.gray
            cell.checkboxImage.image = UIImage(named:"checked")
        } else {
          
            cell.title.textColor = UIColor.black
            cell.subtitle.textColor = UIColor.black
            cell.checkboxImage.image = UIImage(named:"not-checked")
        }
        
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            lists.remove(at: indexPath.row)
            saveLists()
            //self.tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
   

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddList":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let ListDetailViewController = segue.destination as? ListDetailTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedListCell = sender as? ListViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedListCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedList = lists[indexPath.row]
            ListDetailViewController.list = selectedList
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
        
    }
    
    @IBAction func unwindToListTable(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ListDetailTableViewController, let list = sourceViewController.list {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                lists[selectedIndexPath.row] = list
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: lists.count, section: 0)
                
                lists.append(list)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveLists()
        }
        
    }
    
    
    //MARK: Private Methods
    
    private func loadSampleLists() {
        

        
        guard let list1 = List(title: "Complete Homework", notes: "photo1", isCompleted: false) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let list2 = List(title: "Buy Groceries", notes: "", isCompleted: false) else {
            fatalError("Unable to instantiate meal1")
        }
        
        lists += [list1, list2]
    }
    
    private func saveLists() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: List.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadLists() -> [List]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: List.ArchiveURL.path) as? [List]
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
