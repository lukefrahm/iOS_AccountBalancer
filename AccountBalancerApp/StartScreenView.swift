//
//  StartScreenView.swift
//  AccountBalancerApp
//
//  Created by Luke Frahm on 11/16/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class StartScreenView: UIViewController {

    @IBOutlet var createPurchase : UIButton!
    @IBOutlet var createCredit : UIButton!
    @IBOutlet var createDeposit : UIButton!
    @IBOutlet var createWithdrawal : UIButton!
    @IBOutlet var viewTransactions : UIButton!
    @IBOutlet weak var balance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let amount = getBalance()
        balance.text = "Balance: $" + String(format: "%.2f", amount)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toPurchaseView(sender: UIButton) {}
    
    @IBAction func toCreditView(sender: UIButton) {}
    
    @IBAction func toDepositView(sender: UIButton) {}
    
    @IBAction func toWithdrawalView(sender: UIButton) {}
    
    @IBAction func toTransactionLogView(sender: UIButton) {}
    
    func getBalance() -> Double {
        
        var transactions: [NSManagedObject]! = []
        var balance: Double = 0
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Transaction")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for item in results {
                transactions.append(item)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        for item in transactions {
            balance += Double(String(item.valueForKey("transAmount"))) ?? 0.0
        }
        
        return balance
    }
}
