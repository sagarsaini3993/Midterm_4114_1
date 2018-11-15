//
//  DepositViewController.swift
//  MidtermStarterF18
//
//  Created by parrot on 2018-11-14.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import CoreData

class DepositViewController: UIViewController {
    
    
    

    // MARK: Outlets
    // ---------------------
    @IBOutlet weak var customerIdTextBox: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!

    @IBOutlet weak var depositAmountTextBox: UITextField!
    @IBOutlet weak var messagesLabel: UILabel!
    
    var context:NSManagedObjectContext!
    var id = ""
    
    
    
    // MARK: Default Functions
    // ---------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        print("You are on the Check Balance screen!")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 2. Mandatory - initialize the context variable
        // This variable gives you access to the CoreData functions
        self.context = appDelegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    // MARK: Actions
    // ---------------------
    
    
    @IBAction func checkBalancePressed(_ sender: Any) {
        print("check balance button pressed!")
        
        
        
        
        id = customerIdTextBox.text!
        
        let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
        
        fetchRequest.predicate =  NSPredicate(format: "id == %@", id)
        
        
        do {
            
            let results = try self.context.fetch(fetchRequest) as [Customer]
            
            print("Number of items in database: \(results.count)")
            
            for x in results {
                print(" name: \(x.name)")
                print(" balance:  \(x.balance)")
                balanceLabel.text = x.balance
                
                
            }
        }
        catch {
            print("Error when fetching from database")
        }
        
        

        
        
    }
    
    
    @IBAction func depositButtonPressed(_ sender: Any) {
        print("you pressed the deposit button!")
        
        print("you pressed the deposit button! and your id is = \(id)")
        
        let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
        
        fetchRequest.predicate =  NSPredicate(format: "id == %@", id)
        
        
        do {
            
            let results = try self.context.fetch(fetchRequest) as [Customer]
            print("Number of items in database: \(results.count)")
            
            for x in results {
                print("Name: \(x.name)")
                print("Balance:: \(x.balance)")
                
                let new =  (Int(x.balance!)! + Int(depositAmountTextBox.text!)!)
                x.balance = String(new)
                print("Current Balance: \(x.balance)")
                do {
                    try self.context.save()
                    print("Saved deposit  to database!")
                    messagesLabel.text = "Saved deposit  to your account"
                }
                catch {
                    print("Error while saving to database")
                }
            }
        }
        catch {
            print("Error when fetching from database")
        }
        
        
        
        
    }
    
    
    @IBAction func showCustomersPressed(_ sender: Any) {
        print("Show customers button pressed!")
        
        
                
        let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()

        //WHERE email="jenelle@gmail.com"
        //fetchRequest.predicate =  NSPredicate(format: "email == %@", "jenelle@gmail.com")

        // SQL: SELECT * FROM User WHERE email="jeenlle@gmil.com"

        do {
            // Send the "SELECT *" to the database
            //  results = variable that stores any "rows" that come back from the db
            // Note: The database will send back an array of User objects
            // (this is why I explicilty cast results as [User]
            
            
            let results = try self.context.fetch(fetchRequest) as [Customer]
            
            if results.count == 0 {
                print("no results found")
            } else {
                print("Results")
            }
            

            // Loop through the database results and output each "row" to the screen
            print("Number of items in database: \(results.count)")

            for x in results {
                print("Name: \(String(describing: x.name!))")
                print("Customer ID: \(String(describing: x.id!))")
                print("Balance: $\(String(describing: x.balance!))")
                print("------------------------------")
            }
        }
        catch {
            print("Error when fetching from database")
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
