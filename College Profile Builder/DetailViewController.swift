//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Sage Hawk on 2/9/17.
//  Copyright © 2017 Sage Hawk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var detailItem: College? {
        didSet {
            
        }
    }
        @IBAction func onTappedSaveButton(_ sender: Any) {
        if let college = self.detailItem {
        college.name = collegeTextField.text!
        college.location = locationTextField.text!
        college.enrollment = Int(enrollmentTextField.text!)!
        college.image = UIImagePNGRepresentation(imageView.image!)!
        }
        }


    func configureView() {
        // Update the user interface for the detail item
        if let college = self.detailItem {
            if collegeTextField != nil {
                collegeTextField.text = college.name
                locationTextField.text = college.location
                enrollmentTextField.text = String(college.enrollment)
                imageView.image = UIImage(data: college.image)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    }




