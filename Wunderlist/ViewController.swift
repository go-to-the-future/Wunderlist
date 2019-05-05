//
//  ViewController.swift
//  Wunderlist
//
//  Created by Kiyoto Ryuman on 2019/05/04.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var titleArray = [String]()
    var label: UILabel = UILabel()
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        backView.layer.cornerRadius = 2.0
        tableView.separatorStyle = .none
        label.tag = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "Array") != nil {
            titleArray = UserDefaults.standard.object(forKey: "Array") as! [String]
        }
        
        if UserDefaults.standard.string(forKey: "Image") != nil {
            let numberString = UserDefaults.standard.string(forKey: "Image")
            backImageView.image = UIImage(named: numberString! + ".jpg")
        }
        
        tableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleArray.append(textField.text!)
        UserDefaults.standard.set(titleArray, forKey: "Array")
        
        if UserDefaults.standard.object(forKey: "Array") != nil{
            titleArray = UserDefaults.standard.object(forKey: "Array") as! [String]
            textField.text! = ""
            tableView.reloadData()
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count = Int(indexPath.row)
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            
            let nextVC:NextViewController = segue.destination as! NextViewController
            
            nextVC.selectedNumber = count
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            titleArray.remove(at: indexPath.row)
            UserDefaults.standard.set(titleArray, forKey: "Array")
            
            tableView.reloadData()
        }else if editingStyle == .insert{
            
        }
    }
}

