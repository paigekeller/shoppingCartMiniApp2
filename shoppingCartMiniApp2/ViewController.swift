//
//  ViewController.swift
//  shoppingCartMiniApp2
//
//  Created by Tiger Coder on 11/21/20.
//  Copyright © 2020 clc.Paige. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    var shoppingArray: [String] = ["Bread", "Milk"]
    var selectedItem = ""
    var selectedCell: UITableViewCell!
    let alert = UIAlertController(title: "ERROR", message: "You Already Have This Item On Your List", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    let defaults = UserDefaults.standard
    var globalCell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       alert.addAction(okAction)
              tableView.delegate = self
                 tableView.dataSource = self
              
              if let shop = defaults.object(forKey: "myItems") {
                        shoppingArray = shop as! [String]
                    }
    }

    //add to cart
    @IBAction func addToCart(_ sender: UIButton) {
        
        if selectedCell.backgroundColor == UIColor.green{
            selectedCell.backgroundColor = UIColor.clear
        } else {
        selectedCell.backgroundColor = UIColor.green
        }
    }
    
    
    //edit
    @IBAction func editBtn(_ sender: UIButton) {
        var text: String!
           text = selectedCell.textLabel?.text
            for each in shoppingArray {
                if text == each{
                    shoppingArray[shoppingArray.firstIndex(of: each)!] = textfield.text!
                }
            
            
        }
        tableView.reloadData()
        print(shoppingArray)
        print(selectedCell.textLabel?.text)
        textfield.text = ""
    }
    
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedCell =  tableView.cellForRow(at: indexPath)
          if let name = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                    selectedItem = name
                }
         }
         
      
    //save
      @IBAction func saveBtn(_ sender: UIBarButtonItem) {
           defaults.set(shoppingArray, forKey: "myItems")
      }
      
      
    //add
      @IBAction func addBtn(_ sender: UIBarButtonItem) {
          var lower: String! = textfield.text!.lowercased()

          for each in shoppingArray {
              if lower == each {
                  present(alert, animated: true, completion: nil)
                  textfield.text = ""
              }
          }
          if textfield.text == "" {
              
          } else  {
              shoppingArray.append(textfield.text!)
                  tableView.reloadData()
              textfield.text = ""
              }
      }
      
    //delete
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          
          if editingStyle == .delete {
              shoppingArray.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
          }
      }
      

      
      
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return shoppingArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        globalCell = cell
                cell.textLabel?.text = shoppingArray[indexPath.row]
                cell.detailTextLabel?.text = ""
                cell.imageView?.image = UIImage(named: "shopingCart")
                return cell
      }
      


}

