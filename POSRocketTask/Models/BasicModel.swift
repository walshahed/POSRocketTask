//
//  BasicModel.swift
//  POSRocketTask
//
//  Created by Line on 1/16/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class BasicModel: Object, Mappable{
    
    @objc dynamic var name: String?
    @objc dynamic var rate: Double = 0.0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        rate    <- (map["rate"], transform)
    }
    
    let transform = TransformOf<Double, String>(fromJSON: { (value: String?) -> Double? in
        // transform value from String? to Int?
        return Double(value ?? "0")
    }, toJSON: { (value: Double?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return String(value)
        }
        return nil
    })
}
