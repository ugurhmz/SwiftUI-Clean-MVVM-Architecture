//
//  MovieMapper.swift
//  SwiftUI-MVMM
//
//  Created by rico on 19.12.2025.
//

import Foundation

extension MovieResponseModel {
    var toDto: MovieDTO {
        
        let val = self.voteAverage ?? 0.0
        let formattedRating = String(format: "%.1f", val)
        
        return MovieDTO(id: self.id ?? 0,
                        title: self.title ?? "No Name Movie",
                        overview: self.overview ?? "No desc.",
                        posterPath: self.posterPath,
                        ratingFormatted: formattedRating,
                        releaseYear: self.releaseDate ?? "00.00.1994")
    }
}
