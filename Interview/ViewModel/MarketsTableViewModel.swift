//
//  MarketsTableViewModel.swift
//  Interview
//
//  Created by chris goldsmith on 01/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation

protocol MarketsTableViewModelProtocol {
    var numberOfElements: Int { get }
    var numberOfSections: Int { get }
    
    func market(at indexPath: IndexPath) -> Market?
    func formattedName(for market: Market) -> String
    
    func loadMarkets(completion: @escaping ()->() )
}

final class MarketsTableViewModel: MarketsTableViewModelProtocol {
    let marketsDataProvider: MarketsDataProviderProtocol
    let numberOfSections = 1
    
    var numberOfElements: Int {
        markets.count
    }
    
    private var markets: [Market] = []
    
    init(marketsDataProvider: MarketsDataProviderProtocol = MarketsDataProvider()) {
        self.marketsDataProvider = marketsDataProvider
    }
    
    func market(at indexPath: IndexPath) -> Market? {
        guard indexPath.row < markets.count else { return nil }
        
        return markets[indexPath.row]
    }
    
    func formattedName(for market: Market) -> String {
        market.epic + " " + market.name
    }
    
    func loadMarkets(completion: @escaping ()->() ) {
    
        self.marketsDataProvider.fetchMarkets() { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let markets):
                    self.markets = markets
                    completion()
                case .failure:
                    completion()
                }
            }
        }
    }
}
