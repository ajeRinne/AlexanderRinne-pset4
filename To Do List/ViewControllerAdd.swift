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
    private var db: Connection?
    
    let toDos = Table("toDos")
    var toDoID = Expression<Int64>("toDoID")
    let toDo = Expression<String?>("toDo")
//    let toDoDateTime = Expression<String?>("dateTime")
//    let toDoPlace = Expression<String?>("place")
//    let toDoDescription = Expression<String?>("Description")
    var toDoChecked = Expression<Int64?>("checked")
    
    private init() {
        setupDatabase()
    }
    
    private func setupDatabase(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        do {
            db = try Connection("\(path)/db.sqlite3")
            createToDosTable()
        } catch {
            print("Cannot connect to database: \(error)")
        }
    }
    func rowIDFunction(toDoText : String){
        let insert = self.toDos.insert(self.toDo <- toDoText)
        
        do{
            let rowID = try self.db!.run(insert)
            print(rowID)
        } catch {
            print("Cannot insert into database: \(error)")
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
                t.column(toDoChecked)
            })
        } catch {
            print("Failed to create table: \(error)")
        }
    }
    
    func loadToDosTable() -> [ToDoItem] {
        var toDosArray = [ToDoItem]()
        do{
            for toDo in try  db!.prepare(toDos)
            {
                let toDoAdd = toDo[self.toDo]
                let toDoIDAdd = toDo[self.toDoID]

//                let todoDateTimeAdd = String(describing: toDo[self.toDoDateTime])
//                let todoPlaceAdd = String(describing: toDo[self.toDoPlace])
//                let todoDescriptionAdd = String(describing: toDo[self.toDoDescription])
                let toDoCheckedAdd = toDo[self.toDoChecked] ?? 0

                let toDoItem = ToDoItem(text: toDoAdd!, id: toDoIDAdd, checked: toDoCheckedAdd)
                
                toDosArray.append(toDoItem)
//                 "toDoDateTime" : todoDateTimeAdd, "toDoPlace" : todoPlaceAdd, "toDoDescription" : toDoDescrioptionAdd,
//                

            }
        } catch {
            print("Cannot load database: \(error)")
        }
        return toDosArray
    }
    
    func deleteToDo(ID : Int64) {
        print("check: delete")
        print(self.toDos)
        let toDoDelete = toDos.filter(toDoID == ID)
        do {
            if try db!.run(toDoDelete.delete()) > 0 {
                print("deleted to do")
            } else {
                print("to do not found")
            }
        } catch {
            print("delete failed: \(error)")
        }
    }
    func updateToDoChecked( ID : Int64, checked: Int64) {
        do{
           

//            print("check table: \(toDosTable)")
//            let toDoInfo = toDos[indexPath.row]

            print("IDcheck: \(ID)")
            
            try db!.run(toDos.filter(toDoID == ID).update(toDoChecked <- checked))
        } catch {
        print("update failed: \(error)")
        }
    }

    func loadSwitchstate(ID : Int64) -> Int64{
        var checked : Int64 = 0
        do{
            
            for toDo in try db!.prepare(toDos.select(toDoChecked)){
                if toDo[toDoChecked] != nil{
                    checked = toDo[toDoChecked]!
                }
                else {
                    checked = 0
                }
            }
            
        } catch {
            print("could not load switchstate\(error)")
        }
        return checked
    }
    static let shared = Database()

}

class ViewControllerAdd: UIViewController {
    
    @IBOutlet var addToDoTextField: UITextField?
    @IBOutlet var addDateTimeTextField: UITextField?
    @IBOutlet var addPlaceTextField: UITextField?
    @IBOutlet var addDescriptionTextField: UITextView?
    @IBAction func submitToDoButton(_ sender: Any) {
        
        if (addToDoTextField?.text?.isEmpty)!{
            addToDoTextField?.placeholder = "You didn't fill in a to do."
        }else {
            let toDoText : String = addToDoTextField!.text!
            Database.shared.rowIDFunction(toDoText : toDoText)
            _ = navigationController?.popViewController(animated: true)
        }
        
//        if (addDateTimeTextField?.text.!isEmpty){
//            let insert = Database.shared.toDos.insert(Database.shared.toDoDateTime <- addToDoDateTimeTextField!.text!)
//            
//            do{
//                let rowID = try Database.shared.db!.run(insert)
//            } catch {
//                print("Cannot insert into database: \(error)")
//            }
//
//        }
        
    }
    //    let toDoDateTime = Expression<String?>("toDoDateTime")
//    let toDoPlace = Expression<String?>("toDoPlace")
//    let toDoDescription = Expression<String?>("toDoDescription")
//    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Database.shared.setupDatabase()


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
