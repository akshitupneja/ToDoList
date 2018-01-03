//
//  Task.swift
//  MAPD2017_ToDoList
//
//  Created by Akshit Upneja on 2018-01-03.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class Task {
    var taskName: String
    var description: String?
    var isCompleted: Bool = false

    
    init(title providedTitle: String, description providedDescription: String?) {
        taskName = providedTitle
        description = providedDescription
       
    }
    

}
