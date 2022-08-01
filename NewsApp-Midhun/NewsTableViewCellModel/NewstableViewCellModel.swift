//
//  NewstableViewCellModel.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 30/07/22.
//

import Foundation

class NewsTableViewCellModel {
    var title: String
    var subtitle: String
    var imageURL: URL?
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) {
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
        }
}

