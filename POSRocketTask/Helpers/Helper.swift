

import UIKit
import ObjectMapper

class Helper: NSObject {
    
    static var isConnected:Bool{
        get{
            let reachability = Reachability()!
            
            if reachability.isReachable{
                return true
            }else{
                return false
            }
        }
    }
}
