//
//  NetworkError.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noInternet
    case timeout
    case serverUnreachable
    case sslError
    case unauthorized      // 401
    case forbidden         // 403
    case notFound          // 404
    case serverError(code: Int) // 500...599
    case serverMessage(String)
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Geçersiz URL."
        case .noInternet: return "İnternet bağlantısı yok."
        case .timeout: return "İstek zaman aşımına uğradı."
        case .serverUnreachable: return "Sunucuya ulaşılamıyor."
        case .sslError: return "Güvenlik sertifikası hatası."
        case .unauthorized: return "Oturum süresi dolmuş veya yetkisiz erişim."
        case .forbidden: return "Bu işlem için izniniz yok."
        case .notFound: return "Aradığınız kaynak bulunamadı."
        case .serverError(let code): return "Sunucu hatası: \(code)"
        case .serverMessage(let msg): return msg
        case .decodingError: return "Veri işlenirken hata oluştu."
        case .unknown: return "Bilinmeyen bir hata oluştu."
        }
    }
}

struct BackendErrorResponse: Decodable {
    let statusMessage: String?
    let statusCode: Int?
    
    var message: String {
        return statusMessage ?? "Bilinmeyen sunucu hatasi"
    }
    
}
