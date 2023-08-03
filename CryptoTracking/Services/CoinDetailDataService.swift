//
//  CoinDetailDataService.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/29/23.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail: CoinDetail? = nil
    var coinDetailSubcription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetail()
    }
    
    func getCoinDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        coinDetailSubcription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnCoinDetail) in
                self?.coinDetail = returnCoinDetail
                self?.coinDetailSubcription?.cancel()
            })
    }
}

