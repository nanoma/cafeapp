//
//  ListTableViewCell.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/21.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var shopImageView: UIImageView!
    @IBOutlet var shopLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
