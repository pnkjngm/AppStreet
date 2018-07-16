//
//  Model.swift
//  AppStreet
//
//  Created by iSteer Inc. on 10/06/18.
//  Copyright © 2018 iSteer Inc. All rights reserved.
//

import Foundation
class Model: NSObject {
    
    let farmID : String!
    let serverID : String!
    let id : String!
    let secret : String!
    
    init(farmID : String, serverID : String, id : String, secret : String) {
        
        self.farmID = farmID
        self.serverID = serverID
        self.id = id
        self.secret = secret
    }
}
