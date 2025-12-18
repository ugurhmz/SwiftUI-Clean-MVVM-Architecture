//
//  NetworkManager.swift
//  SwiftUI-MVMM
//
//  Created by rico on 18.12.2025.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: EndpointProtocol, type: T.Type) async throws -> T
}

actor NetworkManager: NetworkManagerProtocol {
    init() {}
    
    func request<T: Decodable>(endpoint: EndpointProtocol, type: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        let request = AF.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        ).validate()
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dataTask = request.serializingDecodable(T.self, decoder: decoder)
        let response = await dataTask.response
        
        // MARK: - 1) URL ERROR CHECK
        if let afError = response.error {
            if let urlError = afError.underlyingError as? URLError {
                
                switch urlError.code {
                case .notConnectedToInternet:
                    throw NetworkError.noInternet
                    
                case .timedOut:
                    throw NetworkError.timeout
                    
                case .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
                    throw NetworkError.serverUnreachable
                    
                case .serverCertificateHasBadDate, .serverCertificateUntrusted, .secureConnectionFailed:
                    throw NetworkError.sslError
                    
                case .cancelled:
                    throw CancellationError()
                    
                default:
                    throw NetworkError.unknown
                }
            }
            throw NetworkError.unknown
        }
        
        // MARK: - 2) STATUS CODE CHECK
        if let httpResponse = response.response {
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
            case 200...299:
                break
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500...599:
                throw NetworkError.serverError(code: statusCode)
                
            default:
                if let data = response.data,
                   let backendError = try? JSONDecoder().decode(BackendErrorResponse.self, from: data) {
                    throw NetworkError.serverMessage(backendError.message)
                }
                throw NetworkError.unknown
            }
        }
        
        // MARK: - 3) SUCCESS  RETURN THE RESPONSE
        switch response.result {
        case .success(let data):
            return data
        case .failure(_):
            throw NetworkError.decodingError
        }
    }
}
