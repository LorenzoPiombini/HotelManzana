//
//  ShowingDetailsReservation.swift
//  HotelManzana
//
//  Created by Lorenzo piombini on 11/13/20.
//

import UIKit

class ShowingDetailsReservation: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var reservationToDisplay:[Registration] = []
    
    
    
    @IBOutlet weak var displayingReservationDetails: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayingReservationDetails.dataSource = self
        displayingReservationDetails.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  reservationToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayingInfo", for: indexPath) as? reservationTableViewCell {
        let reservation = reservationToDisplay[indexPath.row]
            cell.upDatereservationTableViewCell(forThis: reservation)
           
            return cell
        } else {
            return reservationTableViewCell()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
 

}
