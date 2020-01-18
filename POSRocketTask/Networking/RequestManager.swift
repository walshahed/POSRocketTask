//
//  RequestManager.swift
//  POSRocketTask
//
//  Created by Line on 1/16/20.
//  Copyright © 2020 POSRocket. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

public typealias Parameters = [String: Any]

class RequestManager {
    
    static func get(url : String , parameters: Parameters, complete:@escaping (Any?,String?)->Void){
        let header = ["Content-Type":"application/x-www-form-urlencoded",
                      "Accept":"application/json"]
        Alamofire.request(url ,method: .get , parameters: parameters, headers : header).responseJSON{ response in
            RequestManager.handelTheResponse(response: response){ data, error in
                complete(data, error)
            }
        }
    }
    
    static func handelTheResponse(response:DataResponse<Any>,complete:@escaping (Any?,String?)->()){
     //   print(response)
        guard Helper.isConnected == true else{
            complete(nil, "No Internet Coniction")
            return
        }
        guard let value = response.result.value as? [String:AnyObject] else{
            complete(nil,"Something went wrong please try again")
            return
        }
        complete(value, nil)
    }
}
