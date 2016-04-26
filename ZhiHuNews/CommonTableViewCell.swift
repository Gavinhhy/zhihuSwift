//
//  CommonTableViewCell.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/4/26.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {

    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
