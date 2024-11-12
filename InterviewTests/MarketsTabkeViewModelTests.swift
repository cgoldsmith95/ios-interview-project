//
//  MarketsTabkeViewModelTests.swift
//  InterviewTests
//
//  Created by chris goldsmith on 01/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation
import XCTest

@testable import Interview

class MarketsTableViewModelTests: XCTestCase {
    func testFormattedName() {
        // Given a market with Epic "FTSE:UKX" and Name "FTSE 100"
        let testMarket = Market(name: "FTSE 100", epic: "FTSE:UKX", price: "£12.34")
        let viewModel = MarketsTableViewModel(marketsDataProvider: MarketDataProviderMock())
        
        // Then the name should be formatted to "FTSE:UKX FTSE 100"
        XCTAssertEqual(viewModel.formattedName(for: testMarket), "FTSE:UKX FTSE 100", "Market name formatted incorrectly")
    }
    
    func testElementCountWithMultipleMarkets() {
        // Given a viewModel with a mock data provider that returns 3 markets
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.fetchedMarkets = [
            Market(name: "FTSE 100", epic: "FTSE:UKX", price: "£12.34"),
            Market(name: "US 500", epic: "US500:USX", price: "$56.78"),
            Market(name: "DAX 30", epic: "DAX30:DEX", price: "€34.56")
        ]
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then element count should be set to 3
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.numberOfElements, 3, "There should be three elements")
    }
    
    func testElementCountWithOneMarket() {
        // Given a viewModel with a mock data provider that returns 1 market
        
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.fetchedMarkets = [
            Market(name: "FTSE 100", epic: "FTSE:UKX", price: "£12.34")
        ]
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then element count should be set to 1
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.numberOfElements, 1, "There should be one element")
    }
    
    func testElementCountWithNoMarkets() {
        // Given a viewModel with a mock data provider that returns no markets
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.fetchedMarkets = []
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then element count should be set to 0
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.numberOfElements, 0, "There should be no elements")
    }

    func testElementCountWithError() {
        // Given a viewModel with a mock data provider that throws an error
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.marketsError = .unknown
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then element count should be set to 0
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.numberOfElements, 0, "There should be no elements")
    }
    
    func testFetchMarketAtIndexPathWithValidIndexPath() {
        
        // Given a viewModel with a mock data provider that returns 3 markets
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.fetchedMarkets = [
            Market(name: "FTSE 100", epic: "FTSE:UKX", price: "£12.34"),
            Market(name: "US 500", epic: "US500:USX", price: "$56.78"),
            Market(name: "DAX 30", epic: "DAX30:DEX", price: "€34.56")
        ]
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then the correct markets are return from indexPaths
        wait(for: [expectation], timeout: 5)
        
        let firstMarket = viewModel.market(at: IndexPath(row: 0, section: 1))
        let secondMarket = viewModel.market(at: IndexPath(row: 1, section: 1))
        let thirdMarket = viewModel.market(at: IndexPath(row: 2, section: 1))
        
        XCTAssertEqual(firstMarket?.epic, "FTSE:UKX", "1st market should be FTSE")
        XCTAssertEqual(secondMarket?.epic, "US500:USX", "2nd market should be US 500")
        XCTAssertEqual(thirdMarket?.epic, "DAX30:DEX", "3rd market should be DAX 30")
    }
    
    func testFetchMarketAtIndexPathWithIndexPathOutOfBounds() {
        // Given a viewModel with a mock data provider that returns 1 markets
        let mockDataProvider = MarketDataProviderMock()
        mockDataProvider.fetchedMarkets = [
            Market(name: "FTSE 100", epic: "FTSE:UKX", price: "£12.34"),
        ]
        
        let viewModel = MarketsTableViewModel(marketsDataProvider: mockDataProvider)
        
        // When fetchMarkets is Called
        let expectation = expectation(description: "fetchMarkets expectation")
        
        viewModel.loadMarkets {
            expectation.fulfill()
        }
        
        // Then the correct markets are return from indexPaths
        wait(for: [expectation], timeout: 5)
        
        let firstMarket = viewModel.market(at: IndexPath(row: 0, section: 1))
        let secondMarket = viewModel.market(at: IndexPath(row: 1, section: 1))
        
        XCTAssertEqual(firstMarket?.epic, "FTSE:UKX", "1st market should be FTSE")
        XCTAssertNil(secondMarket, "2nd market should be nil")
    }
}
