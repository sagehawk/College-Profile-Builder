//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Sage Hawk on 2/9/17.
//  Copyright © 2017 Sage Hawk. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    let realm = try! Realm()
    var detailItem: College? {
        didSet {
    
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true) {
            let selectedImage = info[UIImagePickerControllerOriginalImage] as!
            UIImage
            self.imageView.image = selectedImage
        }
    }
    
    @IBAction func onTappedChangeWebsiteButton(_ sender: UIButton) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func onTappedWebsiteButton(_ sender: UIButton) {
        
        let urlString = websiteTextField.text!
        let url = URL(string: urlString)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    @IBAction func onTappedSaveButton(_ sender: Any) {
        if let college = self.detailItem {
            try! realm.write({
                college.name = collegeTextField.text!
                college.location = locationTextField.text!
                college.enrollment = Int(enrollmentTextField.text!)!
                college.image = UIImagePNGRepresentation(imageView.image!)!
                college.website = websiteTextField.text!
            })
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
                websiteTextField.text = college.website
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




