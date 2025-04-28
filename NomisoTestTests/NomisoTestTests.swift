//
//  NomisoTestTests.swift
//  NomisoTestTests
//
//  Created by sai sitaram on 28/04/25.
//

import XCTest
@testable import NomisoTest


class MockAPIService: APIService {
    var mockResult: Result<[MoviesModel], Error>?
    
    func fetchRequest<T:Codable>(url: String, _ type: T.Type, compeltionHandler completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let mockResult = mockResult {
            completion(mockResult as! Result<T, Error>)
        }
    }
}

final class NomisoTestTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = MoviesViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testMoviesViewModelLoadingState() async {
        
        mockAPIService.mockResult = .success([])
        
        await viewModel.fetchMoviesList()
        
        XCTAssertTrue(viewModel.isLoading)
        
        mockAPIService.mockResult = .success([MoviesModel(title: "Indhra", runtime: "235 Min", year: "2002", poster: "")])
        
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testMoviesViewModelFetchSuccess() async {
        let mockMovies = [MoviesModel(title: "Indhra", runtime: "235 Min", year: "2002", poster: ""),
                          MoviesModel(title: "Tagore", runtime: "233 Min", year: "2003", poster: "")]
        
        mockAPIService.mockResult = .success(mockMovies)
        
        await viewModel.fetchMoviesList()
        
        XCTAssertEqual(viewModel.moviesList.count, 2)
        XCTAssertEqual(viewModel.moviesList[0].title, "Indhra")
        XCTAssertEqual(viewModel.moviesList[1].title, "Tagore")
    }
    
    func testMoviesViewModelFetchFailure() async {
        let mockError = NSError(domain: "com.test.error", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch movies"])
        mockAPIService.mockResult = .failure(mockError)
        
        await viewModel.fetchMoviesList()
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.localizedDescription, "Failed to fetch movies")
    }
    
}
