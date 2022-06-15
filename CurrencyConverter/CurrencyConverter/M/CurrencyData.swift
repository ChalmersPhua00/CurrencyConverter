//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Chalmers Phua on 6/14/22.
//

import Foundation

struct CurrencyData: Codable {
    let rates: Rates
}

struct Rates: Codable {
    let AUD: Double
    let BRL: Double
    let CAD: Double
    let CLP: Double
    let CNY: Double
    let CZK: Double
    let EUR: Double
    let GBP: Double
    let HKD: Double
    let ILS: Double
    let INR: Double
    let JPY: Double
    let KRW: Double
    let MXN: Double
    let MYR: Double
    let NOK: Double
    let NZD: Double
    let PHP: Double
    let PLN: Double
    let RUB: Double
    let SAR: Double
    let SEK: Double
    let SGD: Double
    let THB: Double
    let TRY: Double
    let USD: Double
    let ZAR: Double
}
