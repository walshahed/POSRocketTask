//
//  ViewController.swift
//  POSRocketTask
//
//  Created by Line on 1/16/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//


import UIKit
import ObjectMapper

class ViewController: UIViewController {
    
    typealias Operator = (Double, Double) -> Double
    let saleAmount = 10.0
    
    @objc dynamic var extraChargesList: [BasicModel]?{
        didSet{
            if let extraChargesList = extraChargesList{
                print("Applying extra charges on sale amount from the server")
                applayDiscount(list: extraChargesList, op: +)
                let obj = CalculationModel.init(value: [CalculationType.extraCharges.rawValue, extraChargesList])
                DBManager.sharedInstance.addData(object: obj)
            }
        }
    }
    
    @objc dynamic var discountsList: [BasicModel]? {
        didSet{
            if let discountsList = discountsList{
                print("Applying discount on sale amount from the server")
                applayDiscount(list: discountsList, op: -)
                let obj = CalculationModel.init(value: [CalculationType.discount.rawValue, discountsList])
                DBManager.sharedInstance.addData(object: obj)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //MARK: fetch the data from the server if the db is empty
        if let extraChargesList  = DBManager.sharedInstance.getDataFromDB(key: .extraCharges)?.list{
             print("Applying extra charges on sale amount from the DB")
            applayDiscount(list: Array(extraChargesList), op: +)
        }else{
            getCalculationsList(url: Constants.APIsUrl.extraChargesUrl , type: .extraCharges)
        }
        
        if let discountsList  = DBManager.sharedInstance.getDataFromDB(key: .discount)?.list{
            print("Applying discount on sale amount from the DB")
            applayDiscount(list: Array(discountsList), op: -)
        }else{
            getCalculationsList(url: Constants.APIsUrl.discountsUrl , type: .discount)
        }
    }

    func applayDiscount(list: [BasicModel], op: Operator){
        for item in list{
            if let name = item.name {
                let priceAfterDisscount = op(saleAmount,(saleAmount * item.rate))
                print("\(name) on \(saleAmount) is: \(priceAfterDisscount)")
            }
        }
    }
    
    func getCalculationsList(url: String, type: CalculationType){
        RequestManager.get(url: url , parameters: [:]){ [weak self] (value, error) in
            guard error == nil else{
                print("Something went wrong please try again")
                return
            }
            if let response = value as? [String : Any] {
                let results = Mapper<BasicModel>().mapArray(JSONArray: response[type.rawValue] as? [[String : Any]] ?? [[:] ])
                switch type {
                case .discount:
                    self?.discountsList = results
                case .extraCharges:
                    self?.extraChargesList = results
                }
            }
        }
    }
}
