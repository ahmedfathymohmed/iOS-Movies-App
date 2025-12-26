//
//  HomeViewModel.swift
//  Movies App Task
//
//  Created by Ayman Fathy on 26/12/2025.
//

import Foundation
class HomeViewModel {
    
    // Data Source
    private let categoriesDataSource = ["Ayman", "Ahmed", "Islam", "Fathy", "Moahmed"]
    private var moviesDataSource: [Movie] = []
    
    let networkManager = NetworkManager()
    
    var fetchCallBack: (() -> Void)?
    
    func getCategoriesCount() -> Int {
        return categoriesDataSource.count
    }
    
    func getMovieCount() -> Int {
        return moviesDataSource.count
    }
    
    func getCategory(at index: Int) -> String {
        return categoriesDataSource[index]
    }
    
    func getMovie(at index: Int) -> Movie {
        return moviesDataSource[index]
    }
    
    // Methods
    
    func fetchMovies() {
        
        let netWorkCallBack: (MoviesResponse) -> Void = { [weak self] model in
            self?.moviesDataSource = model.results
            self?.fetchCallBack?()
        }
        
        networkManager.getMoviesList(completion: netWorkCallBack)
    }
}
