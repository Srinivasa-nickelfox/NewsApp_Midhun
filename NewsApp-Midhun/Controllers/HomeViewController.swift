//
//  HomeViewController.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 12/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    
   @IBOutlet weak var tableViewHome: UITableView!
    
    var articles = [Article]()
    var viewModels = [NewsTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableViewHome.register(nib, forCellReuseIdentifier: "cell")

        view.backgroundColor = .green
        fetchTopStories()
    }
    
    func fetchTopStories() {
        Networker().getNews { [self] (resultNews, error) -> Void
            in
            if let error = error {
                print(error)
                return
            }
            if let resultNews = resultNews {
                articles = resultNews.articles
                viewModels = articles.compactMap({
                    NewsTableViewCellModel(title: $0.title ?? "No Title",
                                           subtitle: $0.description ?? "No Content",
                                           imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                })
                DispatchQueue.main.async {
                    self.tableViewHome.reloadData()
                }
            }
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell {
        cell.configure(with: viewModels[indexPath.row])
        return cell
        } else {
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextVC") as? NextViewController {
            nextViewController.article = articles[indexPath.row]
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
}

