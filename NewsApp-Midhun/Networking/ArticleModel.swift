//
//  ArticleModel.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 30/07/22.
//

import Foundation

struct ArticleResponse: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var content: String?

}

extension URL {

   func appending(_ queryItem: String, value: String) -> URL {

       guard var urlComponents = URLComponents(string: absoluteString) else {return absoluteURL}

       var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []

       let queryItem = URLQueryItem(name: queryItem, value: value)

       queryItems.append(queryItem)

       urlComponents.queryItems = queryItems

       return urlComponents.url!
   }
}


