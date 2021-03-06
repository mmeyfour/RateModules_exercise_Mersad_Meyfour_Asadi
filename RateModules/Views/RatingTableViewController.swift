//
//  RatingTableViewController.swift
//  RateModules
//
//  Created by Mersad Meyfour on 01/03/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    
    
    var studentsList: [StudentsList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentsList = StudentsList.loadFromFile()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let studentsList = studentsList else {return 0}
        return studentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        
        let studentList = studentsList![indexPath.row]
        
        cell.textLabel?.text = "\(studentList.firstName) \(studentList.lastName) - \(studentList.module.dropFirst(7)) \(studentList.totalRatio) \(studentList.emoji)"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = "Ratio: \(studentList.totalRatio) \(studentList.emoji)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let alertController = UIAlertController(title: "Choose option", message: nil, preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {_ in self.updateListStudent(student: indexPath.row)
                self.studentsList?.remove(at: indexPath.row); tableView.deleteRows(at: [indexPath], with: .fade)})
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func updateListStudent(student: Int) {
        var studentsList: [StudentsList] = StudentsList.loadFromFile()
        studentsList.remove(at: student)
        StudentsList.saveToFile(rates: studentsList)
    }
}
