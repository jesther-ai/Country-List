//
//  TableViewCell.swift
//  CountryList
//
//  Created by Jesther Silvestre on 6/16/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
