//
//  CalculationModel.swift
//  POSRocketTask
//
//  Created by Line on 1/18/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//

import Foundation
import RealmSwift

class CalculationModel: Object{
    @objc dynamic var name: String?
    let list = List<BasicModel>()
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
