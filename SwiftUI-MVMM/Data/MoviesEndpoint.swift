//
//  MoviesEndpoint.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation
import Alamofire

enum MoviesEndPoint: EndpointProtocol {
    case discover(page: Int)
    
    var path: String {
        switch self {
        case .discover:
            return "/discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .discover:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .discover(let page):
            return [
                "include_adult": false,
                "include_video": false,
                "language": "en-US",
                "sort_by": "popularity.desc",
                "page": page
            ]
        }
    }
    
}
