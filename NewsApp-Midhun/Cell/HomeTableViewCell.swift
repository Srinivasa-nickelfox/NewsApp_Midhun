//
//  HomeTableViewCell.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 30/07/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            label.text = nil
            newsImage.image = nil
        }
    
    // Function that configures/passes the fetched API data into respective views' cells
    
    func configure(with viewModel: NewsTableViewCellModel){
        label.text = viewModel.title
        newsImage.downloadImage(from: viewModel.imageURL!)
        
//       if let data = viewModel.imageData {
//            newsImage.image = UIImage(data: data)
//        }
//        else if let url = viewModel.imageURL {
//            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                viewModel.imageData = data
//                DispatchQueue.main.async {
//                    self?.newsImage.image = UIImage(data: data)
//                }
//            }
//            .resume()
//        }
    }
}

