//
//  SearchViewController.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 12/07/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableViewSearch: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableViewSearch.register(nib, forCellReuseIdentifier: "cell")

        fetchTopStories()
        view.backgroundColor = .orange
    }
    
     var articles = [Article]()
     var viewModels = [NewsTableViewCellModel]()
    
      func fetchTopStories() {
          Networker().search(query: "apple") { [self] (resultNews, error) -> Void
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
                      self.tableViewSearch.reloadData()
                  }
              }
          }
          
      }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        Networker().search(query: text) { [self] (resultNews, error) -> Void
            in
            if let error = error {
                print(error)
                return
            }
            if let resultNews = resultNews {
                articles = resultNews.articles
                viewModels = articles.compactMap({
                    NewsTableViewCellModel(title: $0.title ?? "No Title",
                                           subtitle: $0.description ?? "No Description",
                                           imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                })
                DispatchQueue.main.async {
                    self.tableViewSearch.reloadData()
                }
            }
        }
    }
    

 }


 extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModels.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print(indexPath.row)
         if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell {
             cell.configure(with: viewModels[indexPath.row])
             return cell
         } else {
             fatalError()
         }
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 150
     }
     
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextVC") as? NextViewController {
             nextViewController.article = articles[indexPath.row]
             self.present(nextViewController, animated: true, completion: nil)
         }
     }
     
}
