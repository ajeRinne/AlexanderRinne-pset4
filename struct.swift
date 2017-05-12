//
//  struct.swift
//  To Do List
//
//  Created by Alexander Rinne on 11-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import Foundation

struct ToDoItem{
    var text : String
    var id : Int64
    var checked : Int64
    
    init (text : String, id : Int64, checked : Int64){
        self.text = text
        self.id = id
        self.checked = checked
    }
}
