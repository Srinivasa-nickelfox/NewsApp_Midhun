//
//  SearchViewController.swift
//  NewsApp_Midhun
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var SearchViewController: UIView!
    @IBOutlet weak var table2: UITableView!
    
    var articles = [Article]()
    var viewModels = [NewsTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        createSearchBar()
    }

    
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        APIFetcher.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellModel(title: $0.title ?? "No Title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                })

                DispatchQueue.main.async {
                    self?.table2.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table2.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
}
