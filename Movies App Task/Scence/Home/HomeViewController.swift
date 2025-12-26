//
//  HomeViewController.swift
//  Movies App Task
//
//  Created by Ayman Fathy on 19/12/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - OutLets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesListCollectionView: UICollectionView!
    @IBOutlet weak var moviesListTableView: UITableView!
    
    
    //MARK: - Properties
    let categoriesDataSource = ["Ayman", "Ahmed", "Islam", "Fathy", "Moahmed"]
    
    var moviesDataSource: [Movie] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        registerTableViewCell()
        setupCollectionViewDelegate()
        setupTableViewDelegate()
        setupCollectionViewLayout()
        categoriesListCollectionView.reloadData()
        moviesListTableView.reloadData()
        getMoviesList(callBack: { [weak self] model in
            self?.moviesDataSource = model?.results ?? []
            self?.moviesListTableView.reloadData()
        } )
    }
    
    func registerCollectionViewCell() {
        categoriesListCollectionView.register(UINib(nibName: "CategoryItemCollectionViewCell", bundle: .main),
                                              forCellWithReuseIdentifier: "CategoryItemCollectionViewCell")
    }
    
    func registerTableViewCell() {
        moviesListTableView.register(UINib(nibName: "MovieItemTableViewCell", bundle: .main),
                                     forCellReuseIdentifier: "MovieItemTableViewCell")
    }
    
    func setupCollectionViewDelegate() {
        categoriesListCollectionView.delegate = self
        categoriesListCollectionView.dataSource = self
    }
    
    func setupTableViewDelegate() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }
    
    func setupCollectionViewLayout() {
        if let layout = categoriesListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}






extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemCollectionViewCell", for: indexPath)
        
        guard let categoryCell = cell as? CategoryItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        categoryCell.setupCell(with: categoriesDataSource[indexPath.row])
        return categoryCell
    }
}








extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemTableViewCell", for: indexPath)
        
        guard let moviesCell = cell as? MovieItemTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = moviesDataSource[indexPath.row]
        
        moviesCell.setUpCell(with: movie)
        
        return moviesCell
    }
}






extension HomeViewController {
    
    func getMoviesList( callBack: @escaping (MoviesResponse?) -> Void) {
        
        
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
                    DispatchQueue.main.async {
                        callBack(model)
                    }
                } catch let decodeError {
                    print(decodeError)
                }
            }
        
        }
        dataTask.resume()
    }
}
