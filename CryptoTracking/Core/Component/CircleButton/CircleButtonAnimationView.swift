//
//  CircleButtonAnimationView.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/15/23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke()
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
