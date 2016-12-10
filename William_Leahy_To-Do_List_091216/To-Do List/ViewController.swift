//
//  ViewController.swift
//  To-Do List
//
//  Created by William Leahy on 9/2/16.
//  Copyright © 2016 William Leahy. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

     @IBOutlet weak var todoListTableView: UITableView?
        @IBOutlet weak var todaysTaskButton: UIBarButtonItem?
     var toDoItemsArray: NSMutableArray = []
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllTasksFromDataBase()
       
    }
    
    // MARK: - Fetch Current Day Tasks
    
    func fetchCurrentDayTasks(){
        
        toDoItemsArray.removeAllObjects()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let selectedDate : String = dateFormatter.stringFromDate(NSDate())

        
        let contactDB = FMDatabase(path: (UIApplication.sharedApplication().delegate as! AppDelegate).databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT * FROM TODOLIST WHERE date = '\(selectedDate)'"
            if let rs = contactDB.executeQuery(querySQL, withArgumentsInArray:nil) {
                while rs.next() {
                    toDoItemsArray.addObject(rs.resultDictionary())
                }
            } else {
                print("select failure: \(contactDB.lastErrorMessage())")
            }
            contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }

        todoListTableView?.reloadData()
    }
    
    // MARK: - Fetch All Tasks
    
    func fetchAllTasksFromDataBase(){
        toDoItemsArray.removeAllObjects()
        let contactDB = FMDatabase(path: (UIApplication.sharedApplication().delegate as! AppDelegate).databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT * FROM TODOLIST"
            
            
            if let rs = contactDB.executeQuery(querySQL, withArgumentsInArray:nil) {
                while rs.next() {
                    toDoItemsArray.addObject(rs.resultDictionary())
                }
            } else {
                print("select failure: \(contactDB.lastErrorMessage())")
            }
            contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        todoListTableView?.reloadData()
    }

    // MARK: - Today Task Button Event
    @IBAction func todaysTaskTapped(){
        
        if todaysTaskButton?.title == "Today's Tasks" {
            todaysTaskButton?.title = "All Tasks"
            fetchCurrentDayTasks()
            
        }
        else{
            todaysTaskButton?.title = "Today's Tasks"
            fetchAllTasksFromDataBase()
        }
        
        
    }
    
    
    
    // MARK: - UITableView Delegates And DataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoListTableViewCell", forIndexPath: indexPath) as! TodoListTableViewCell
       
      //  let todoitem: ToDoItems = (UIApplication.sharedApplication().delegate as! AppDelegate).toDoItemsArray.objectAtIndex(indexPath.row) as! ToDoItems
        
        cell.taskNameLbl?.text = toDoItemsArray[indexPath.row].valueForKey("NAME") as? String
        cell.taskTypeLbl?.text = toDoItemsArray[indexPath.row].valueForKey("TYPE") as? String
        cell.taskDateLbl?.text = toDoItemsArray[indexPath.row].valueForKey("DATE") as? String
        
        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        
//        let selectedDate : String = dateFormatter.stringFromDate(todoitem.date)
//        let todayDate : String = dateFormatter.stringFromDate(NSDate())
//        
//        if selectedDate == todayDate {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "h:mm a"
//          cell.taskDateLbl?.text = dateFormatter.stringFromDate(todoitem.date)
//        }
//        else{
//            cell.taskDateLbl?.text = selectedDate
//        }
        
        return cell
    
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemsArray.count
    }
    
    // MARK: - Memory Managment

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

