//
//  DbManager.swift
//  POSRocketTask
//
//  Created by Line on 1/18/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    
    private init() {
        Realm.Configuration.defaultConfiguration = configuration
        database = try! Realm()
    }
    var configuration = Realm.Configuration(
        schemaVersion: 7,
        migrationBlock: { migration, oldSchemaVersion in
    }
    )
    func getDataFromDB(key: CalculationType) -> CalculationModel? {
        let object = try! Realm().object(ofType: CalculationModel.self as Object.Type, forPrimaryKey: key.rawValue)
        return object as? CalculationModel
    }
    
    func addData(object: CalculationModel)   {
        try! database.write {
            database.add(object, update: .all)
            print("Added new object")
            
        }
        
    }
}

