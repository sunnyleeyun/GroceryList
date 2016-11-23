//
//  GroceryListTableViewController.swift
//  Grocery List
//
//  Created by Sunny on 2016/10/12.
//  Copyright © 2016年 Sunny. All rights reserved.


import UIKit
import CoreData

class GroceryListTableViewController: UITableViewController {

    var groceries = [Grocery]()
    var managedObjectContext: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
    
        loadData()
    }
    
    func loadData(){
        //let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Grocery")
        
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        do{
            let results = try managedObjectContext?.fetch(request)
            groceries = results!
            tableView.reloadData()
        }
        catch{
            fatalError("Error in retrieving Grocery item")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Grocery Item", message: "What's to buy now", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField: UITextField) in
            
        }
        let addAction = UIAlertAction(title: "ADD", style: UIAlertActionStyle.default) { [weak self](action: UIAlertAction) in
            /*let textField = alertController.textFields?.first
            //self?.groceries.append(textField!.text!)
            
            let entity = NSEntityDescription.entity(forEntityName: "Grocery", in: (self?.managedObjectContext)!)
            let grocery = NSManagedObject(entity: entity!, insertInto: self?.managedObjectContext)
            grocery.setValue(textField?.text!, forKey: "item")*/
            
            let itemString: String?
            
            if(alertController.textFields?.first?.text != ""){
                itemString = alertController.textFields?.first?.text
            }else{
                return
            }
            
            let grocery = Grocery(context: (self?.managedObjectContext)!)
            grocery.item = itemString
            
            do{
                try self?.managedObjectContext?.save()
            }
            catch{
                fatalError("Error in storing data")
            }
            
            
            
            self?.loadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groceries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        let grocery = self.groceries[indexPath.row]
        //cell.textLabel?.text = grocery.value(forKey: "item") as? String
        cell.textLabel?.text = grocery.item

        return cell
    }
    

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
