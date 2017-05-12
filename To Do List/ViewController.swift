//
//  ViewController.swift
//  To Do List
//
//  Created by Alexander Rinne on 07-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    let all = Array(try toDos.prepare())

    @IBOutlet var TableViewToDo: UITableView!
    @IBAction func addToDo(_ sender: Any) {
//        performSegue(withIdentifier: segueAdd, sender: <#T##Any?#>)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count : Int = Database.shared.loadToDosTable().count
        return count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            var toDos = Database.shared.self.loadToDosTable()
            let toDoInfo = toDos[indexPath.row]
//            let toDoID = toDoInfo.text
            Database.shared.deleteToDo(ID: toDoInfo.id)
            self.TableViewToDo.reloadData()
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var toDos = Database.shared.self.loadToDosTable()
        let toDoInfo = toDos[indexPath.row]
        print(toDoInfo)
//        let toDo =

//        let toDoID = toDoInfo["toDoID"] as! Int64
//        if toDoInfo["toDoDateIme"] != nil{
//            let toDoDatetime = toDoInfo["toDoDateTime"]
//        }
//        if toDoInfo["toDoPlace"] != nil{
//            let toDoPlace = toDoInfo["toDoPlace"]
//        }
//        if toDoInfo["toDoDescription"] != nil{
//            let toDoDescription = toDoInfo["toDoDescription"]
//        }
//        if toDoInfo["toDoDateIme"] != nil{
//            let toDoDatetime = toDoInfo["toDoDateTime"]
//        }
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellToDo", for: indexPath) as! TableViewCellToDo
        cell.toDoID = toDoInfo.id
        cell.toDoTextField.text = toDoInfo.text
        print(toDoInfo.checked)
//        let checked = Database.shared.loadSwitchstate(ID : toDoInfo.id)
        if toDoInfo.checked == 1 {
            cell.toDoSwitch.setOn(true, animated: true)

        } else {
            cell.toDoSwitch.setOn(false, animated: false)
        }
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        Database.shared.setupDatabase()
        self.TableViewToDo.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        Database.shared.setupDatabase()
        self.TableViewToDo.reloadData()
        
    }

    

}

