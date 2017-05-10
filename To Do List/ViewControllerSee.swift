//
//  ViewControllerSee.swift
//  To Do List
//
//  Created by Alexander Rinne on 07-05-17.
//  Copyright © 2017 Alexander Rinne. All rights reserved.
//

import UIKit
import SQLite

class ViewControllerSee: UIViewController {

    @IBOutlet var seeToDoTextField: UITextField!
    
    @IBOutlet var seeDateTimeTextField: UITextField!
    
    @IBOutlet var seeLocationTextField: UITextField!
    
    @IBOutlet var seeDescriptionTextField: UITextView!
    
    @IBOutlet var deleteToDoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
