//
//  College.swift
//  College Profile Builder
//
//  Created by Sage Hawk on 2/9/17.
//  Copyright © 2017 Sage Hawk. All rights reserved.
//

import UIKit

class College: NSObject {
    var name = String()
    var location = String()
    var enrollment = Int()
    var image = Data()
    
    convenience init(name: String, location: String, enrollment: Int, image: Data) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.image = image
    }

}
