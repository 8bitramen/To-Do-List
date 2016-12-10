//
//  TodoListTableViewCell.swift
//  To-Do List
//
//  Created by William Leahy on 9/2/16.
//  Copyright © 2016 William Leahy. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskNameLbl: UILabel?
    @IBOutlet weak var taskTypeLbl: UILabel?
    @IBOutlet weak var taskDateLbl: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
