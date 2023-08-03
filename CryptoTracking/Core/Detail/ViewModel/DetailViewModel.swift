//
//  DetailViewModel.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/29/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistic: [StatisticCoin] = []
    @Published var additionalStatistic: [StatisticCoin] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubcribers()
    }
    
    private func addSubcribers() {
        coinDetailDataService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArray in
                self?.overviewStatistic = returnedArray.overview
                self?.additionalStatistic = returnedArray.additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetail
            .sink { [weak self] returnedCoinDetail in
                self?.coinDescription = returnedCoinDetail?.readableDescription
                self?.websiteURL = returnedCoinDetail?.links?.homepage?.first
                self?.redditURL = returnedCoinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetail?, coinModel: Coin) -> (overview: [StatisticCoin], additional: [StatisticCoin]) {
            let overviewArray = createOverviewArray(coinModel: coinModel)
            let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
            return (overviewArray, additionalArray)
        }
    
    private func createOverviewArray(coinModel: Coin) -> [StatisticCoin] {
            let price = coinModel.currentPrice.asCurrencyWith6Decimals()
            let pricePercentChange = coinModel.priceChangePercentage24H
            let priceStat = StatisticCoin(title: "Current Price", value: price, percentageChange: pricePercentChange)
            
            let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
            let marketCapPercentChange = coinModel.marketCapChangePercentage24H
            let marketCapStat = StatisticCoin(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
            
            let rank = "\(coinModel.rank)"
            let rankStat = StatisticCoin(title: "Rank", value: rank)
            
            let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
            let volumeStat = StatisticCoin(title: "Volume", value: volume)
            
            let overviewArray: [StatisticCoin] = [
                priceStat, marketCapStat, rankStat, volumeStat
            ]
            return overviewArray
        }
        
        private func createAdditionalArray(coinDetailModel: CoinDetail?, coinModel: Coin) -> [StatisticCoin] {
            
            let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
            let highStat = StatisticCoin(title: "24h High", value: high)
            
            let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
            let lowStat = StatisticCoin(title: "24h Low", value: low)
            
            let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
            let pricePercentChange = coinModel.priceChangePercentage24H
            let priceChangeStat = StatisticCoin(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
            
            let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
            let marketCapPercentChange = coinModel.marketCapChangePercentage24H
            let marketCapChangeStat = StatisticCoin(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
            
            let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
            let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
            let blockStat = StatisticCoin(title: "Block Time", value: blockTimeString)
            
            let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
            let hashingStat = StatisticCoin(title: "Hashing Algorithm", value: hashing)
            
            let additionalArray: [StatisticCoin] = [
                highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
            ]
            return additionalArray
        }
}
