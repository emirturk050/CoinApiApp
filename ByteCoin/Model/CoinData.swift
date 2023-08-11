//
//  CoinData.swift
//  ByteCoin
//
//  Created by Emir Türk on 14.07.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    var asset_id_quote: String
    var rate: Double
}
