//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Chalmers Phua on 6/14/22.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdate(result: String)
    func didFailWithError(error: Error)
}

struct CurrencyManager {
    let currencyArray = ["AUD","BRL","CAD","CLP","CNY","CZK","EUR","GBP","HKD","ILS","INR","JPY","KRW","MXN","MYR","NOK","NZD","PHP","PLN","RUB","SAR","SEK","SGD","THB","TRY","USD","ZAR"]
    let currencyDictionary : [String : String] = ["AUD":"A$","BRL":"R$","CAD":"C$","CLP":"CLP$","CNY":"元","CZK":"Kč","EUR":"€","GBP":"£","HKD":"HK$","ILS":"₪","INR":"₹","JPY":"¥","KRW":"₩","MXN":"$","MYR":"RM","NOK":"kr","NZD":"NZ$","PHP":"₱","PLN":"zł","RUB":"₽","SAR":"﷼","SEK":"KR","SGD":"S$","THB":"฿","TRY":"₺","USD":"US$","ZAR":"R"]
    
    var componentZero = "AUD"
    var componentOne = "AUD"
    
    var amountToConvert = 0.0
    
    var delegate: CurrencyManagerDelegate?
    
    mutating func amountToBeConverted(_ amount: Double) {
        amountToConvert = amount
    }
    
    mutating func getConversion(_ currency: String, _ component: Int) {
        if component == 0 {
            componentZero = currency
        } else {
            componentOne = currency
        }
        performRequest()
    }
    
    func performRequest() {
        if let url = URL(string:
                            "https://openexchangerates.org/api/latest.json?app_id=<INSERT_KEY>") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let rate = parseJSON(safeData) {
                        delegate?.didUpdate(result: String(format: "%.2f", rate * amountToConvert))
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: data)
            var componentZeroRate = decodedData.rates.AUD
            var componentOneRate = decodedData.rates.AUD
            switch componentZero {
            case "BRL":
                componentZeroRate = decodedData.rates.BRL
            case "CAD":
                componentZeroRate = decodedData.rates.CAD
            case "CLP":
                componentZeroRate = decodedData.rates.CLP
            case "CNY":
                componentZeroRate = decodedData.rates.CNY
            case "CZK":
                componentZeroRate = decodedData.rates.CZK
            case "EUR":
                componentZeroRate = decodedData.rates.EUR
            case "GBP":
                componentZeroRate = decodedData.rates.GBP
            case "HKD":
                componentZeroRate = decodedData.rates.HKD
            case "ILS":
                componentZeroRate = decodedData.rates.ILS
            case "INR":
                componentZeroRate = decodedData.rates.INR
            case "JPY":
                componentZeroRate = decodedData.rates.JPY
            case "KRW":
                componentZeroRate = decodedData.rates.KRW
            case "MXN":
                componentZeroRate = decodedData.rates.MXN
            case "MYR":
                componentZeroRate = decodedData.rates.MYR
            case "NOK":
                componentZeroRate = decodedData.rates.NOK
            case "NZD":
                componentZeroRate = decodedData.rates.NZD
            case "PHP":
                componentZeroRate = decodedData.rates.PHP
            case "PLN":
                componentZeroRate = decodedData.rates.PLN
            case "RUB":
                componentZeroRate = decodedData.rates.RUB
            case "SAR":
                componentZeroRate = decodedData.rates.SAR
            case "SEK":
                componentZeroRate = decodedData.rates.SEK
            case "SGD":
                componentZeroRate = decodedData.rates.SGD
            case "THB":
                componentZeroRate = decodedData.rates.THB
            case "TRY":
                componentZeroRate = decodedData.rates.TRY
            case "USD":
                componentZeroRate = decodedData.rates.USD
            case "ZAR":
                componentZeroRate = decodedData.rates.ZAR
            default:
                componentZeroRate = decodedData.rates.AUD
            }
            switch componentOne {
            case "BRL":
                componentOneRate = decodedData.rates.BRL
            case "CAD":
                componentOneRate = decodedData.rates.CAD
            case "CLP":
                componentOneRate = decodedData.rates.CLP
            case "CNY":
                componentOneRate = decodedData.rates.CNY
            case "CZK":
                componentOneRate = decodedData.rates.CZK
            case "EUR":
                componentOneRate = decodedData.rates.EUR
            case "GBP":
                componentOneRate = decodedData.rates.GBP
            case "HKD":
                componentOneRate = decodedData.rates.HKD
            case "ILS":
                componentOneRate = decodedData.rates.ILS
            case "INR":
                componentOneRate = decodedData.rates.INR
            case "JPY":
                componentOneRate = decodedData.rates.JPY
            case "KRW":
                componentOneRate = decodedData.rates.KRW
            case "MXN":
                componentOneRate = decodedData.rates.MXN
            case "MYR":
                componentOneRate = decodedData.rates.MYR
            case "NOK":
                componentOneRate = decodedData.rates.NOK
            case "NZD":
                componentOneRate = decodedData.rates.NZD
            case "PHP":
                componentOneRate = decodedData.rates.PHP
            case "PLN":
                componentOneRate = decodedData.rates.PLN
            case "RUB":
                componentOneRate = decodedData.rates.RUB
            case "SAR":
                componentOneRate = decodedData.rates.SAR
            case "SEK":
                componentOneRate = decodedData.rates.SEK
            case "SGD":
                componentOneRate = decodedData.rates.SGD
            case "THB":
                componentOneRate = decodedData.rates.THB
            case "TRY":
                componentOneRate = decodedData.rates.TRY
            case "USD":
                componentOneRate = decodedData.rates.USD
            case "ZAR":
                componentOneRate = decodedData.rates.ZAR
            default:
                componentOneRate = decodedData.rates.AUD
            }
            return componentOneRate/componentZeroRate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
