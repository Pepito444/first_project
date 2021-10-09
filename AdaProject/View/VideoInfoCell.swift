//
//  VideoInfoCell.swift
//  AdaProject
//
//  Created by user191120 on 8/18/21.
//

import UIKit

class VideoInfoCell: UITableViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var takeAgain: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        takeAgain.layer.borderWidth = 1
        takeAgain.layer.cornerRadius = 25
        takeAgain.layer.borderColor = UIColor.red.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
