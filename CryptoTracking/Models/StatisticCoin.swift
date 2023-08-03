//
//  StatisticCoin.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/19/23.
//

import Foundation

struct StatisticCoin: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
