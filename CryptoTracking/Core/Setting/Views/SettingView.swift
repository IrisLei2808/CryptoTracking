//
//  SettingView.swift
//  CryptoTracking
//
//  Created by Duc Le on 7/30/23.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let defaultURL = URL(string: "https://www.google.com")!
        let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
        let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
        let coingeckoURL = URL(string: "https://www.coingecko.com")!
        let personalURL = URL(string: "https://www.nicksarno.com")!
    
    var body: some View {
            NavigationView {
                ZStack {
                    // background
                    Color.theme.background
                        .ignoresSafeArea()
                    
                    // content
                    List {
                        swiftfulThinkingSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        coinGeckoSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        developerSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        applicationSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                    }
                }
                .font(.headline)
                .accentColor(.blue)
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("Closed")
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        })
                    }
                }
            }
        }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

extension SettingView {
    
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Binance Support")) {
            VStack(alignment: .leading) {
                Image("unnamed")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("These Binance Terms of Use is entered into between you (hereinafter referred to as “you” or “your”) and Binance operators (as defined below). By accessing, downloading, using or clicking on “I agree” to accept any Binance Services (as defined below) provided by Binance (as defined below)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Apple Developer 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Enables developers to use the OAuth 2.0 protocol, allowing Binance users to grant a third-party application full or partial access to their account. Allows users to share specific data with third-party applications while keeping their API keys, login credentials, and other information private.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🤙", destination: personalURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
    
    
}
