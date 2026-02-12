//
//  DetailsViewModel.swift
//  Movies App Task
//
//  Created by Ahmed Fathy on 24/01/2026.
//

import Foundation
import Combine

class DetailsViewModel {
    
    private let movieId: Int
    
    private var cancellables = Set<AnyCancellable>()
    @Published var errorMessage: String?
    @Published var detailResponse : DetailResponse?
    
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchMoviesDetails() {
        let endpoint = MovieEndpoint.details(id: movieId)
        guard let request = APIBuilder.buildRequest(endpoint: endpoint) else { return }
        print("🔗 Fetching URL: \(request.url?.absoluteString ?? "No URL")")
        
        NetworkManager.shared.request(url: request)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] (response: DetailResponse) in
                print("✅ Movie received: \(response.title ?? "No title")")

                self?.detailResponse = response
            }
            .store(in: &cancellables)
    }
}
