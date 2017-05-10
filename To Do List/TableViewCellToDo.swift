//
//  TableViewCellToDo.swift
//  To Do List
//
//  Created by Alexander Rinne on 07-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import UIKit

class TableViewCellToDo: UITableViewCell {

    @IBOutlet var toDoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
