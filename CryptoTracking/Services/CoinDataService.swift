//
//  CoinDataService.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/16/23.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    var coinSubcription: AnyCancellable?
    private let apiCoin = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en"
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: apiCoin) else {return}
        coinSubcription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinSubcription?.cancel()
            })
    }
}
