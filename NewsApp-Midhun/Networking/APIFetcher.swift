//
//  APIFetcher.swift
//  NewsApp-Midhun
//
//  Created by Midhun Kasibhatla on 30/07/22.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}
   
class Networker {
    
    func getNews(completion: @escaping (ArticleResponse?, Error?) -> Void) {
        if let headLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=e7855adfcfbb4dd69e3fd27172d1aa4e") {
                    URLSession.shared.dataTask(with: headLinesURL) { data, response, error
                        in
                        if let error = error {
                            print("Error,\(error)")
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            print("Not the right response!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }
                        
                        guard (200...299).contains(httpResponse.statusCode) else {
                            print("Error, status code", httpResponse.statusCode)
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                            }
                            return
                        }
                        
                        guard let data = data else {
                            print("Bad data!")
                            DispatchQueue.main.async {
                                completion(nil, NetworkError.badResponse)
                            }
                            return
                        }

                        do {
                            let resultNews = try JSONDecoder().decode(ArticleResponse.self, from: data)
                            print(resultNews.articles.count)
                            DispatchQueue.main.async {
                               completion(resultNews, nil)
                            }
                        } catch {
                            print("Error", error)
                        }
                    }.resume()
        }
    }
    
    func search(query: String, completion: @escaping(ArticleResponse?, Error?) -> Void) {
         guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
             return
         }
         let searchUrlString = "https://newsapi.org/v2/everything"
         let apiKey = "af636d01048d448180b9daf62d844f43"
         
         guard let url = URL(string: searchUrlString) else {
             return
         }
        let urlAppended = url.appending("sortBy", value: "popularity").appending("apiKey", value: apiKey).appending("q", value: query)
        print(urlAppended)
        
         URLSession.shared.dataTask(with: urlAppended) { data, response, error in
                         
                         if let error = error {
                             print("Error,\(error)")
                             DispatchQueue.main.async {
                                 completion(nil, error)
                             }
                             return
                         }
                         
                         guard let httpResponse = response as? HTTPURLResponse else {
                             print("Not the right response!")
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badResponse)
                             }
                             return
                         }
                         
                         guard (200...299).contains(httpResponse.statusCode) else {
                             print("Error, status code", httpResponse.statusCode)
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                             }
                             return
                         }
                         
                         guard let data = data else {
                             print("Bad data!")
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badResponse)
                             }
                             return
                         }

                         do {
                             let resultNews = try JSONDecoder().decode(ArticleResponse.self, from: data)
                             print(url)
                             DispatchQueue.main.async {
                                completion(resultNews, nil)
                             }
                         } catch {
                             print("Error", error)
                         }
                     }.resume()
        }
    
    /*func getURL() -> URL {
        let searchUrlString = "https://newsapi.org/v2/everything"
        let apiKey = "af636d01048d448180b9daf62d844f43"
        
        guard let url = URL(string: searchUrlString) else {
            fatalError()
        }
       let urlAppended = url.appending("sortBy", value: "popularity").appending("apiKey", value: apiKey)/*.appending("q", value: query)*/
       return urlAppended
    }*/
    
    /* func search(query: String, completion: @escaping(ArticleResponse?, Error?) -> Void) {
         guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
             return
         }
         let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=af636d01048d448180b9daf62d844f43&q="
         let urlString = searchUrlString + query
         guard let url = URL(string: urlString) else {
             return
         }
         URLSession.shared.dataTask(with: url) { data, response, error in
                         
                         if let error = error {
                             print("Error,\(error)")
                             DispatchQueue.main.async {
                                 completion(nil, error)
                             }
                             return
                         }
                         
                         guard let httpResponse = response as? HTTPURLResponse else {
                             print("Not the right response!")
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badResponse)
                             }
                             return
                         }
                         
                         guard (200...299).contains(httpResponse.statusCode) else {
                             print("Error, status code", httpResponse.statusCode)
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                             }
                             return
                         }
                         
                         guard let data = data else {
                             print("Bad data!")
                             DispatchQueue.main.async {
                                 completion(nil, NetworkError.badResponse)
                             }
                             return
                         }

                         do {
                             let resultNews = try JSONDecoder().decode(ArticleResponse.self, from: data)
                             print(url)
                             DispatchQueue.main.async {
                                completion(resultNews, nil)
                             }
                         } catch {
                             print("Error", error)
                         }
                     }.resume()
        } */
    
    }


