//
//  UIApplication.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/19/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
