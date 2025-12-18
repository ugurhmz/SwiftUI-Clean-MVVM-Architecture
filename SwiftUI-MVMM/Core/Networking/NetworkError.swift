//
//  NetworkError.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case unauthorized
    case forbidden
    case notFound
    case serverError(code: Int)
    case decodingError
    case serverMessage(String)
    case noInternet
    case timeout
    case serverUnreachable
    case sslError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL isteği."
        case .unauthorized:
            return "Oturum süreniz doldu, lütfen tekrar giriş yapın."
        case .forbidden:
            return "Bu işlemi yapmaya yetkiniz yok."
        case .notFound:
            return "Aradığınız içerik bulunamadı."
        case .serverError(let code):
            return "Sunucu hatası oluştu. (Kod: \(code))"
        case .decodingError:
            return "Veri işlenirken bir hata oluştu."
        case .serverMessage(let message):
            return message
        case .noInternet:
            return "İnternet bağlantınız yok. Lütfen kontrol edin."
        case .timeout:
            return "İstek zaman aşımına uğradı. Bağlantınız yavaş olabilir."
        case .serverUnreachable:
            return "Sunucuya erişilemiyor. Lütfen daha sonra tekrar deneyin."
        case .sslError:
            return "Güvenli bağlantı kurulamadı. (SSL Hatası)"
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}


struct BackendErrorResponse: Decodable {
    let message: String
}
