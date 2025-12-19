//
//  APIConstants.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation

enum SecretKeys: String {
    case TMDB_TOKEN = "TMDB_TOKEN"
}

struct APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static var bearerToken: String {
        guard let token = Bundle.main.object(forInfoDictionaryKey: SecretKeys.TMDB_TOKEN.rawValue) as? String else {
            fatalError("HATA: Secrets.xcconfig dosyası bulunamadı veya Info.plist ayarı eksik!")
        }
        
        return token
    }
}
