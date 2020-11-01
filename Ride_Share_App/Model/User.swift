//
//  User.swift
//  Ride_Share_App
//
//  Created by Xinyi Cheng on 30.10.20.
//
import CoreLocation

struct User {
    let fullname: String
    let email: String
    let accountType: Int
    var location: CLLocation?
    
    init(dictionary: [String : Any]) {
        self.fullname = dictionary["fullname"] as? String ?? " "
        self.email = dictionary["email"] as? String ?? " "
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
