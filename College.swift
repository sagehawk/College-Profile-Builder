//
//  College.swift
//  College Profile Builder
//
//  Created by Sage Hawk on 2/9/17.
//  Copyright © 2017 Sage Hawk. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class College: Object {
    dynamic var name = String()
    dynamic var location = String()
    dynamic var enrollment = Int()
    dynamic var image = Data()
    dynamic var website = String()
    
    convenience init(name: String, location: String, enrollment: Int, image: Data, website: String) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.image = image
        self.website = website
    }

}
