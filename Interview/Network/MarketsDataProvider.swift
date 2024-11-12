//
//  MarketsDataProvider.swift
//  Interview
//
//  Created by chris goldsmith on 01/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation

enum MarketsError: Error {
    case unknown
}

protocol MarketsDataProviderProtocol {
    func fetchMarkets(completion: @escaping (Result<[Market], MarketsError>)->())
}

class MarketsDataProvider: MarketsDataProviderProtocol {
    func fetchMarkets(completion: @escaping (Result<[Market], MarketsError>)->()) {
        guard let url = URL(string:"http://localhost:8080/api/general/money-am-quote-delayed?ticker=UKX,MCX,NMX,ASX,SMX,AIM1,IXIC,INDU,DEX.") else {
            completion(.failure(.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Mock", forHTTPHeaderField: "Client")
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [NetworkInterceptor.self]
        let defaultSession = URLSession(configuration: configuration)
        
        defaultSession.dataTask(with: request) { (data, response, error) in
            guard let data else {
                completion(.failure(.unknown))
                return
            }
            do {
                let marketReponse = try JSONDecoder().decode(MarketsReposnseModel.self, from: data)
                completion(.success(marketReponse.data))
            } catch {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
