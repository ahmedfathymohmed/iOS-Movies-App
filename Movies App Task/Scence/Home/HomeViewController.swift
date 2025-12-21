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
    
    let moviesDataSource: [MovieItem] = [
        MovieItem(movieImage: "", movieName: "Movie1", movieYear: "2025"),
        MovieItem(movieImage: "", movieName: "Movie2", movieYear: "2025"),
        MovieItem(movieImage: "", movieName: "Movie3", movieYear: "2025"),
        MovieItem(movieImage: "", movieName: "Movie4", movieYear: "2025"),
        MovieItem(movieImage: "", movieName: "Movie5", movieYear: "2025")
    ]
    
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

struct MovieItem {
    let movieImage: String
    let movieName: String
    let movieYear: String
}
