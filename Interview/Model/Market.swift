//
//  Market.swift
//  Interview
//
//  Created by chris goldsmith on 01/11/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation

struct MarketsReposnseModel: Decodable {
    let data: [Market]
}

struct Market: Decodable {
    let name: String
    let epic: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case name = "CompanyName"
        case epic = "Epic"
        case price = "CurrentPrice"
    }
}
