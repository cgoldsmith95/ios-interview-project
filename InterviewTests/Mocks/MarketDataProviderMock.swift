//
//  MarketDataProviderMock.swift
//  InterviewTests
//
//  Created by chris goldsmith on 02/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

@testable import Interview

final class MarketDataProviderMock: MarketsDataProviderProtocol {
    
    var fetchedMarkets: [Market] = []
    var marketsError: MarketsError?
    
    func fetchMarkets(completion: @escaping (Result<[Market], MarketsError>) -> ()) {
        if let marketsError {
            completion(.failure(marketsError))
            return
        }
        
        completion(.success(fetchedMarkets))
    }
}
