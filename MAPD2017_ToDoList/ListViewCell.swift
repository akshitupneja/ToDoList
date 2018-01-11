//
//  ListViewCell.swift
//  MAPD2017_ToDoList
//
// Team Members:
//  Akshit Upneja (300976590)
//  santhosh damodharan (300964037)
//  Amanpreet Kaur (300966930)
//
//  Created by Akshit Upneja on 2017-12-31.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var checkboxImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
      var onClick: ( (ListViewCell) -> () )?
    
    @IBAction func tapped(_ sender: UIButton) {
        onClick?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
