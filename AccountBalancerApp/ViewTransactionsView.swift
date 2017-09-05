//
//  ViewTransactionsView.swift
//  AccountBalancerApp
//
//  Created by Lucas Dietrich Frahm on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class ViewTransactionsView: UITableViewController { //UIViewController, UITableViewDataSource, UITableViewDelegate {
    var transactions = [NSManagedObject]()
    var firstCycle = true
    
    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return transactions.count;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Transaction")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            transactions = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("transactionsToMain", sender: sender)
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let transaction = transactions[indexPath.row]
        
        var isNegative: Bool
        var amount = transaction.valueForKey("transAmount") as? Double ?? 0.00
        var category = transaction.valueForKey("transCategory") as? String ?? ""
        var store = transaction.valueForKey("transStoreName") as? String ?? ""
        
        if (amount < 0) {
            amount = -amount
            isNegative = true
        } else {
            isNegative = false
        }
        
        var trunkedAmount = "$" + String(format: "%.2f", amount)
        
        if isNegative {
            trunkedAmount = "(" + trunkedAmount + ")"
        }
        
        let oneTab = "\t"
        let twoTab = "\t\t"
        let threeTab = "\t\t\t"
        let fourTab = "\t\t\t\t"
        
        if (firstCycle) {
            trunkedAmount = "Amount"
            category = "Category"
            store = "Store"
            firstCycle = false
        }
        
        if (trunkedAmount.characters.count < 7) {
            trunkedAmount += twoTab
        } else {
            trunkedAmount += oneTab
        }
        if (category.characters.count < 7) {
            category += fourTab
        } else if (category.characters.count < 14) {
            category += threeTab
        } else if (category.characters.count < 21) {
            category += twoTab
        } else {
            category += oneTab
        }
        
        cell.textLabel?.text = trunkedAmount + category + store
        
        return cell
    }
}
