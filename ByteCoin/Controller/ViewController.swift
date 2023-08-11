//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinManagerDelegate {
    
    func didUpdateView(coin: CoinData) {
       
        DispatchQueue.main.async {
            self.priceLabel.text = String(format: "%.1f", coin.rate)
            self.currencyLabel.text = coin.asset_id_quote
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
   
  
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

