//
//  CoinImageViewModel.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/19/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubcribes()
        self.isLoading = true
    }
    
    private func addSubcribes() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnImages in
                self?.image = returnImages
            }
            .store(in: &cancellables)
    }
}
