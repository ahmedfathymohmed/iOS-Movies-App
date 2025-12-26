//
//  NetworkManager.swift
//  Movies App Task
//
//  Created by Ayman Fathy on 26/12/2025.
//

import Foundation
class NetworkManager {
    
    func getMoviesList(completion: @escaping (MoviesResponse) -> Void) {
        
        var model: MoviesResponse?
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzQxZjZkYzcxNjhkNWFiMjE2NGVkOWQxNmNmZTI4NiIsIm5iZiI6MTQ1MzkyNzM5MC40NjUsInN1YiI6IjU2YTkyYmRlYzNhMzY4NzJkMzAwMTc2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ecy-T7m8SWpthLlxrtJ8UZswr-hWcfnnF9ykD5WjKCY"
        
        // 1- Prepare URL
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie")
        
        // 2- get URL Request
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // 3- prepare the session
        let session = URLSession.shared
        
        // create Data Task
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            print(response)
            
            if let error = error {
                print("\(error)")
            } else {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(MoviesResponse.self, from: data!)
                    DispatchQueue.main.async { [weak self] in
                        completion(model)
                    }
                } catch let decodeError {
                    print(decodeError)
                }
            }
        }
        dataTask.resume()
    }
}
