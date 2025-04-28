//
//  MoviesViewModel.swift
//  NomisoTest
//
//  Created by sai sitaram on 28/04/25.
//

import Foundation

class MoviesViewModel:ObservableObject {
    @Published var moviesList = [MoviesModel]()
    @Published var isLoading = false
    @Published var error: Error?
    
    var apiService:APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    
    func fetchMoviesList() async {
        
        DispatchQueue.main.async {
            self.isLoading = true
            self.error = nil
        }
        
        await apiService.fetchRequest(url: ServiceUrls.movieUrl, [MoviesModel].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.moviesList = data
                case .failure(let error):
                    self.error = error
                }
            }
            
        }
    }
}
