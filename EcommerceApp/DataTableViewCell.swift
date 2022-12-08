//
//  DataTableViewCell.swift
//  EcommerceApp
//
//  Created by Mac on 22/11/22.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    //@IBOutlet weak var prizeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
