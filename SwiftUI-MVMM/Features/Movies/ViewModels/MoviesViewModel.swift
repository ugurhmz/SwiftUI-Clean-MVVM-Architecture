//
//  MoviesViewModel.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case error
}

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [MovieDTO] = []
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?
    
    private let service: MovieServiceProtocol
    private var currentPage = 1
    private var canLoadMore = true
    private var isFetching = false
    
    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }
    
    func loadMovies() async {
        guard !isFetching && canLoadMore else { return }
        
        isFetching = true
        errorMessage = nil
        
        if movies.isEmpty { state = .loading }
        
        do {
            let rawData = try await service.fetchMovies(page: currentPage)
            
            let cleanData = rawData.map { $0.toDto }
            
            if cleanData.isEmpty {
                canLoadMore = false
            } else {
                self.movies.append(contentsOf: cleanData)
                self.currentPage += 1
            }
            state = .idle
        } catch {
            state = .error
            self.errorMessage = error.localizedDescription
        }
        
        isFetching = false
    }
}
