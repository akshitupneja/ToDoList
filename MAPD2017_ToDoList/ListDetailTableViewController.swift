//
//  ListDetailTableViewController.swift
//  MAPD2017_ToDoList
//
//  Created by Akshit Upneja on 2017-12-25.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import UIKit

class ListDetailTableViewController: UITableViewController {

    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBOutlet weak var listTextField: UITextField!
    
    var list: List?
    var lists: [List]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if saveButton === sender as? UIBarButtonItem {
            
            guard let name = listTextField.text else { return true }
            
            if (name.isEmpty) {
                let alert = UIAlertController(title: "Blank Field", message:
                    "List Name cannot be left blank", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alert, animated: true, completion: nil)

                return false
                
            } else {
                return true
                
            }
            
        }
        
        return true
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as? UIBarButtonItem {
            
            guard let name = listTextField.text else { return }

            list = List(name: name, task: [])
            
        }
        
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
