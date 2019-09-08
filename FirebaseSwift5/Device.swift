//
//  File.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 06/09/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable{
    init?(dictionary:[String:Any])
}

struct Device {
    var id:String
    var name:String
    var timeStamp: Timestamp
    var used:Bool
    
    var dictionary:[String:Any]{
        return [
            "id":id,
            "name":name,
            "timeStamp":timeStamp,
            "used":used
        ]
    }
}

extension Device : DocumentSerializable{
    init?(dictionary:[String:Any]){
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"]as? String,
            let timeStamp = dictionary["timeStamp"] as? Timestamp ,
            let used = dictionary["used"] as? Bool else {
                return nil
        }
        self.init(id: id, name: name, timeStamp: timeStamp, used: used)
    }
}

