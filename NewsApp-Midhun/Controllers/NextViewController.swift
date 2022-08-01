//
//  NextViewController.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 30/07/22.
//

import UIKit

class NextViewController: UIViewController {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsInfo: UILabel!
    
    var article : Article? = Article(author: "", title: "", description: "", url: "", urlToImage: "", content: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.newsTitle.text = article?.title
        self.newsInfo.text = article?.description
        
       
        if let url = URL(string: (article?.urlToImage) ?? ""){
            newsImage?.downloadImage(from: url)
            newsImage.contentMode = .scaleAspectFill
            } else {
                return
            }
    }

}

extension UIImageView {
    func downloadImage( from url: URL)
    {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error)
            
            in
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }).resume()
    }
}

