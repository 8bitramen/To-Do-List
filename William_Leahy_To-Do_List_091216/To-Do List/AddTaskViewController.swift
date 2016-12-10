//
//  AddTaskViewController.swift
//  To-Do List
//
//  Created by William Leahy on 9/2/16.
//  Copyright © 2016 William Leahy. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var taskNameTF:  UITextField?
    @IBOutlet weak var taskTypeTF: UITextField?
    @IBOutlet weak var taskDateTF: UITextField?
    @IBOutlet weak var taskTypePickerView: UIPickerView?
    @IBOutlet weak var taskTypeDatePickerView: UIDatePicker?
    @IBOutlet weak var taskTypeAndDateBackgroundView: UIView?
    @IBOutlet weak var titleBarButton: UIBarButtonItem?
    let taskTypes: [String] = ["Personal", "Work", "Others"]
    var selectedType : String?
    var selectedDate : NSDate?
    var selectedTextField : UITextField?
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTypeDatePickerView?.minimumDate = NSDate()

        // Do any additional setup after loading the view.
    }
   // MARK: - Memory Managment
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIpickerView Delegates And DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskTypes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskTypes[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       selectedType = taskTypes[row]
    }
    
    // MARK: - UItextField Life Cycle
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == taskDateTF || textField == taskTypeTF {
            taskNameTF?.resignFirstResponder()
            taskTypeAndDateBackgroundView?.hidden = false
            
            if textField == taskTypeTF {
                taskTypePickerView?.hidden = false
                taskTypeDatePickerView?.hidden = true
                titleBarButton?.title = "Select Task Type"
                selectedTextField = taskTypeTF
            }
            else{
                taskTypePickerView?.hidden = true
                taskTypeDatePickerView?.hidden = false
                titleBarButton?.title = "Select Date"
                selectedTextField = taskDateTF
            }
            return false
        }
         taskTypeAndDateBackgroundView?.hidden = true
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 25
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    // MARK: - UIButtons Action
    @IBAction func doneButtonTapped()
    {
        if selectedTextField == taskTypeTF {
            taskTypeTF?.text = selectedType
        }
        else{
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            taskDateTF?.text = dateFormatter.stringFromDate(taskTypeDatePickerView!.date)
        }
        taskTypeAndDateBackgroundView?.hidden = true
    }
    
    @IBAction func cancelButtonTapped()
    {
        taskTypeAndDateBackgroundView?.hidden = true
    }
    
 

    @IBAction func addButtonTapped()
    {
        if ((taskTypeTF?.text?.isEmpty) != false || (taskNameTF?.text?.isEmpty) != false || (taskDateTF?.text?.isEmpty) != false) {
            UIAlertView.init(title: "All fields are required!", message: nil, delegate: nil, cancelButtonTitle: "Dismiss").show()
        }
        else{
            
            saveData()
        self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    // MARK: - Save Task Data In Database
    
    func saveData(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let selectedDate : String = dateFormatter.stringFromDate(taskTypeDatePickerView!.date)
        
        let contactDB = FMDatabase(path:  (UIApplication.sharedApplication().delegate as! AppDelegate).databasePath as String)
        
        if contactDB.open() {
            
            let insertSQL = "INSERT INTO TODOLIST (name, type, date, timestamp) VALUES ('\(taskNameTF!.text!)', '\(taskTypeTF!.text!)', '\(selectedDate)', '\(0)')"
            
            let result = contactDB.executeUpdate(insertSQL,
                                                 withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(contactDB.lastErrorMessage())")
            } else {
               
            }
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
    }
    @IBAction func mainCancelButtonTapped()
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
