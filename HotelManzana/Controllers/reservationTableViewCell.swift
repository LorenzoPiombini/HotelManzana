//
//  reservationTableViewCell.swift
//  HotelManzana
//
//  Created by Lorenzo piombini on 11/13/20.
//

import UIKit

class reservationTableViewCell: UITableViewCell, UITableViewDelegate{

    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkInDate: UILabel!
    @IBOutlet weak var checkOutDate: UILabel!
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var roomType: UILabel!
    
    var wifiAmount: Int?
    var totalToCharge: Int = 0
    var roomTypeTotal:Int = 0
    
    func upDatereservationTableViewCell(forThis: Registration ){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        firstNameLbl.text = "\(forThis.firstName)"
        lastNameLbl.text = "\(forThis.lastName)"
        emailLbl.text = "Email: \(forThis.emailAddress)"
        checkInDate.text = "Check in \(dateFormatter.string(from: forThis.checkInDate) )"
        checkOutDate.text = "Check out\(dateFormatter.string(from: forThis.checkOutDate) )"
        if forThis.wifi == true {
            wifi.text = "Yes"
        } else {
            wifi.text = "No"
        }
        roomType.text = "\(forThis.roomType)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
