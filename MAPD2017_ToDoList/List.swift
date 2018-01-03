//
//  List.swift
//  MAPD2017_ToDoList
//
//  Created by Akshit Upneja on 2017-12-31.
//  Copyright © 2017 Centennial College. All rights reserved.
//
import UIKit

class List {
    var listName: String
    var task: [Task]

    
    init(name providedName: String, task providedTask: [Task]) {
        listName = providedName
        task = providedTask
      
    }
    

    
}


