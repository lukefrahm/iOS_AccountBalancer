//
//  CreateDepositView.swift
//  AccountBalancerApp
//
//  Created by Luke Frahm on 11/16/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class CreateDepositView: UIViewController {
    var transactions = [NSManagedObject]()
    
    @IBOutlet var store: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var category: UITextField!
    @IBOutlet var desc: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegueWithIdentifier("toStartScreenFromDeposit", sender: sender)
    }
    
    @IBAction func save(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let transaction = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: managedContext)
        
        if store.text != "" {
            if amount.text != "" {
                if category.text != "" {
                    if desc.text != "" {
                        if let value = Double(amount.text!) {
                            let newTrans = NSManagedObject(entity: transaction!, insertIntoManagedObjectContext: managedContext)
                            
                            newTrans.setValue(store.text, forKey: "transStoreName")
                            newTrans.setValue(value, forKey: "transAmount")
                            newTrans.setValue(category.text, forKey: "transCategory")
                            newTrans.setValue(desc.text, forKey: "transDescription")
                            
                            do {
                                try managedContext.save()
                                
                                transactions.append(newTrans)
                            } catch let error as NSError  {
                                fatalError("Could not save \(error), \(error.userInfo)")
                            }
                            
                            performSegueWithIdentifier("toStartScreenFromDeposit", sender: sender)
                        } else {
                            amount.text = ""
                            amount.backgroundColor = UIColor.redColor()
                            amount.placeholder = "Please enter a number"
                        }
                    } else {
                        desc.text = ""
                        desc.backgroundColor = UIColor.redColor()
                        desc.placeholder = "Please enter a description"
                    }
                } else {
                    category.text = ""
                    category.backgroundColor = UIColor.redColor()
                    category.placeholder = "Please enter a category"
                }
            } else {
                amount.text = ""
                amount.backgroundColor = UIColor.redColor()
                amount.placeholder = "Please enter a number"
            }
        } else {
            store.text = ""
            store.backgroundColor = UIColor.redColor()
            store.placeholder = "Please enter a store name"
            
        }
    }
}