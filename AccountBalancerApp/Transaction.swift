//
//  Transaction.swift
//  AccountTracker
//
//  Created by Luke Frahm on 11/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//
import Foundation

public class Transaction {
    private (set) var transDateTime : NSDate
    public var transAmount : Double
    public var transStoreName : String
    public var transCategory : String
    public var transDescription : String
    
    init (amount : Double, storeName : String, category : String, description : String) {
        self.transDateTime = NSDate.init()
        self.transAmount = amount
        self.transStoreName = storeName
        self.transCategory = category
        self.transDescription = description
    }
    
    init() {
        self.transDateTime = NSDate.init()
        self.transAmount = 0
        self.transStoreName = ""
        self.transCategory = ""
        self.transDescription = ""
    }
    
    func deleteTransaction () {
        // remove transaction from records and update as such
    }
}
