//
//  MovieDTO.swift
//  SwiftUI-MVMM
//
//  Created by rico on 19.12.2025.
//

import Foundation

struct MovieDTO: Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let ratingFormatted: String
    let releaseYear: String

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        let cleanPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        return URL(string: "\(APIConstants.imageBaseURL)/\(cleanPath)")
    }
}

