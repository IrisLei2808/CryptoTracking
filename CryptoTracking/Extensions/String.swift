//
//  String.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/30/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
