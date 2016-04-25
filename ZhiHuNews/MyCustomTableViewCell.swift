//
//  MyCustomTableViewCell.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/4/22.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
