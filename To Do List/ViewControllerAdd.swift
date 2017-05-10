//
//  ViewControllerAdd.swift
//  To Do List
//
//  Created by Alexander Rinne on 07-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import UIKit
import SQLite

class Database {
    var db: Connection?
    
    let toDos = Table("toDos")
    let toDoID = Expression<Int64>("toDoID")
    let toDo = Expression<String?>("toDo")
    func setupDatabase(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        do {
            db = try Connection("\(path)/db.sqlite3")
            print("check Database: \(db!)")
            createToDosTable()
        } catch {
            print("Cannot connect to database: \(error)")
        }
    }
    
    func createToDosTable() {
        do {
            try db!.run(toDos.create(ifNotExists: true) { t in
                t.column(toDoID, primaryKey: .autoincrement)
                t.column(toDo)
                //                t.column(toDoDateTime)
                //                t.column(toDoPlace)
                //                t.column(toDoDescription)
            })
        } catch {
            print("Failed to create table: \(error)")
        }
    }
    
    func loadToDosTable() -> [String] {
        var toDosArray = [[ : ]]
        do{
            for toDo in try  db!.prepare(toDos)
            {
                toDosArray.append (toDo[self.toDo]!)
                toDosArray.append (toDo)
                print("check1: \(toDos)")
            }
        } catch {
            print("Cannot load database: \(error)")
        }
        return toDosArray
    }
    
    func deleteToDo(ID : Int) {
        print("check: delete")
        print(self.toDos)
//        let toDo: QueryType = toDoID.match(ID)
//        do {
//            if try db?.run(toDo.delete()) > 0 {
//                print("deleted alice")
//            } else {
//                print("alice not found")
//            }
//        } catch {
//            print("delete failed: \(error)")
//        }
    }
    
    
    static let shared = Database()

}

class ViewControllerAdd: UIViewController {
    
    @IBOutlet var addToDoTextField: UITextField?
    @IBOutlet var addDateTimeTextField: UITextField?
    @IBOutlet var addPlaceTextField: UITextField?
    @IBOutlet var addDescriptionTextField: UITextView?
    @IBAction func submitToDoButton(_ sender: Any) {
        
        if (addToDoTextField?.text!.isEmpty)!{
            addToDoTextField?.placeholder = "You didn't fill in a to do."
        }else {
            let insert = Database.shared.toDos.insert(Database.shared.toDo <- addToDoTextField!.text!)
            
            do{
                let rowID = try Database.shared.db!.run(insert)
                print(rowID)
            } catch {
                print("Cannot insert into database: \(error)")
            }
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    //    let toDoDateTime = Expression<String?>("toDoDateTime")
//    let toDoPlace = Expression<String?>("toDoPlace")
//    let toDoDescription = Expression<String?>("toDoDescription")
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.shared.setupDatabase()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    let insert = toDos.insert(toDo <- addToDoTextField.text!, toDoDateTime <- addDateTimeTextField!.text, toDoPlace <- addPlaceTextField.text, toDoDescription <- addDescriptionTextField.text)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
