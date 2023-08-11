//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateView(coin: CoinData)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=89DCBF7E-F102-457C-A6B8-4EE1E0ABFBA6"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        delegate?.didUpdateView(coin: coin)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON (_ data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
             let decodedData = try decoder.decode(CoinData.self, from: data)
                
            return decodedData
            
        }
        catch {
            //didfailwitherror
            print(error)
            return nil
        }
    }
    
    
}
