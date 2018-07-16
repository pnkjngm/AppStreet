//
//  NetworkManager.swift
//  AppStreet
//
//  Created by iSteer Inc. on 10/06/18.
//  Copyright © 2018 iSteer Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    class func getHTTPs(url : String, success:@escaping (JSON) -> (), failure:@escaping (String) -> ()) {
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                if !resJson.isEmpty {
                    success(resJson)
                } else {
                    failure("Unable to find Server")
                }
            }
            if response.result.isFailure {
                failure("Unable to find Server")
            }
        }
        
    }
}

