//
//  MarketDataService.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/19/23.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    var marketDataSubcription: AnyCancellable?
    private let apiCoin = "https://api.coingecko.com/api/v3/global"
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: apiCoin) else {return}
        
        marketDataSubcription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubcription?.cancel()
            })
    }
}
