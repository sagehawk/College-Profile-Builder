//
//  MasterViewController.swift
//  College Profile Builder
//
//  Created by Sage Hawk on 2/9/17.
//  Copyright © 2017 Sage Hawk. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let realm = try! Realm()
    lazy var colleges: Results<College> = {
        self.realm.objects(College.self)
    }()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        for college in colleges {
            objects.append(college)
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let alert = UIAlertController(title: "Add College", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "College"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Location"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Website"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enrollment"
            textField.keyboardType = UIKeyboardType.numberPad
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let insertAction = UIAlertAction(title: "Add", style: .default) { (action) in
                let collegeTextField = alert.textFields![0] as UITextField
                let locationTextField = alert.textFields![1] as UITextField
                let websiteTextField = alert.textFields![2] as UITextField
                let enrollmentTextField = alert.textFields![3] as UITextField
                guard let image = UIImage(named: collegeTextField.text!) else{
                    print("missing \(collegeTextField.text!) image")
                    return }
                if let enrollment = Int(enrollmentTextField.text!) {
                    let college = College(name: collegeTextField.text!,
                                    location: locationTextField.text!,
                                    enrollment: enrollment,
                                    image: UIImagePNGRepresentation(image)!
                        ,website: websiteTextField.text!)
                    
                    self.objects.append(college)
                    try! self.realm.write {
                        self.realm.add(college)
                    }
                    self.tableView.reloadData()
                }
            }
            alert.addAction(insertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! College
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! College
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let college = objects.remove(at: indexPath.row) as! College
            try! self.realm.write {
                self.realm.delete(college)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        }
    
            else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    


}

