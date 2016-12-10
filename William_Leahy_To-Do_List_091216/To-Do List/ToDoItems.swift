//
//  ToDoItems.swift
//  To-Do List
//
//  Created by William Leahy on 9/2/16.
//  Copyright © 2016 William Leahy. All rights reserved.
//

import UIKit

class ToDoItems: NSObject {

    
    var itemName : NSString = ""
    var type : NSString = ""
    var date : NSDate = NSDate()
    
    init(name: String, type: NSString, date: NSDate){
        self.itemName = name
        self.type = type
        self.date = date
    }
}
