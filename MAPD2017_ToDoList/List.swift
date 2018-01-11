//
//  List.swift //to encode/decode with NSCoding
//  MAPD2017_ToDoList
//
//  Team Members:
//  Akshit Upneja (300976590)
//  santhosh damodharan (300964037)
//  Amanpreet Kaur (300966930)
//
//  Created by Akshit Upneja on 2017-12-31.
//  Copyright © 2017 Centennial College. All rights reserved.
//
import UIKit
import os.log

class List: NSObject, NSCoding {
    var title: String
    var notes: String
    var isCompleted: Bool = false
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ToDo")
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let title = "title"
        static let notes = "notes"
        static let isCompleted = false
    }
    
    //MARK: Initialization
    
    init?(title: String, notes: String, isCompleted: Bool) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(notes, forKey: PropertyKey.notes)
        aCoder.encode(isCompleted, forKey:"isCompleted")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for a To DO object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
        
        let isCompleted = aDecoder.decodeBool(forKey: "isCompleted")
        
        // Must call designated initializer.
        self.init(title: title, notes: notes!, isCompleted: isCompleted)
        
    }
    
}


