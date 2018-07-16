//
//  ViewModel.swift
//  AppStreet
//
//  Created by iSteer Inc. on 10/06/18.
//  Copyright © 2018 iSteer Inc. All rights reserved.
//

import Foundation

class ViewModel {
    private var model : Model
    
    init(farmID : String, serverID : String, id : String, secret : String) {
        self.model = Model(farmID: farmID, serverID: serverID, id: id, secret: secret)
    }
    
    var farmID : String {
        return model.farmID
    }
    var serverID : String {
        return model.serverID
    }
    var id : String {
        return model.id
    }
    var secret : String {
        return model.secret
    }
}
