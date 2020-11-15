//
//  StructGuestInfo.swift
//  HotelManzana
//
//  Created by Lorenzo piombini on 11/7/20.
//

import Foundation

struct Registration {
        var firstName: String
        var lastName: String
        var emailAddress: String
    
        var checkInDate: Date
        var checkOutDate: Date
        var numberOfAdults: Int
        var numberOfChildren: Int
        var roomType: String
        var wifi: Bool
    
}


struct RoomType: Equatable {
     var id: Int
     var name: String
     var shortName: String
     var price: Int

    func equal (lhs: RoomType, rhs: RoomType)->  Bool{
        return lhs.id == rhs.id
    
    
}


}
