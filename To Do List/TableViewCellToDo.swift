//
//  TableViewCellToDo.swift
//  To Do List
//
//  Created by Alexander Rinne on 07-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import UIKit

class TableViewCellToDo: UITableViewCell {
    
    var toDoID: Int64?
    @IBOutlet var toDoTextField: UITextField!
    @IBOutlet var toDoSwitch: UISwitch!
    @IBAction func toDoSwitchAction(_ sender: Any) {
    
        var checkBox : Int64
        if toDoSwitch.isOn == true {
            checkBox = 1
            toDoSwitch.setOn(true, animated: true)
            Database.shared.updateToDoChecked(ID: toDoID!, checked: 1)
        } else {
            checkBox = 0
            toDoSwitch.setOn(false, animated: false)
            Database.shared.updateToDoChecked(ID: toDoID!, checked: 0)
        }
    }
    
    
    var toDoIDSave = ""

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
