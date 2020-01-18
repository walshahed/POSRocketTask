//
//  Constants.swift
//  POSRocketTask
//
//  Created by Line on 1/16/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//
import Foundation

class Constants {
    private static let baseurl =    "https://www.posrocket.com/"
    private static let apiUrl = "\(Constants.baseurl)/task/"
    
    struct APIsUrl {
        static   let extraChargesUrl = "\(Constants.apiUrl)extra_charges.json"
        static   let discountsUrl = "\(Constants.apiUrl)discounts.json"
    }
}

enum CalculationType: String {
    case discount = "discounts"
    case extraCharges = "extra_charges"
}
