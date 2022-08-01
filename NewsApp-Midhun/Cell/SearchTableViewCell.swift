//
//  TableViewCell.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Function for making the default value of title, subtitle and image to be empty/nil
    // To avoid the repetition of previous data
    
    override func prepareForReuse() {
            super.prepareForReuse()
            titleLabel.text = nil
            subtitleLabel.text = nil
            newsImage.image = nil
        }
    
    // Function that configures/passes the fetched API data into respective views' cells
    
    func configure(with viewModel: NewsTableViewCellModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        newsImage.downloadImage(from: viewModel.imageURL!)
        
    }
    
}
