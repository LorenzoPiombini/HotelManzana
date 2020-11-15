//
//  AddREgistrationTableViewController.swift
//  HotelManzana
//
//  Created by Lorenzo piombini on 11/7/20.
//

import UIKit

class AddREgistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179), RoomType(id: 1, name: "One King", shortName: "K", price: 209), RoomType(id: 2, name: "Penthouse Swite", shortName: "PHS", price: 309)]
    }
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row:3, section: 1)
    var isCheckInDateShown: Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDateShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    var roomType: RoomType?
    
    var registration: Registration? {
        
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTxtField.text ?? ""
        let lastName = lastNameTxtField.text ?? ""
        let email = emailTxtField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfChildren = Int(numberOfChildrenLbl.text!)
        let numberOfAdults = Int(numberOfAdultsLbl.text!)
        let hasWifi = wifiSwitchOption.isOn
        let roomChoice = roomType.name
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults!, numberOfChildren: numberOfChildren!, roomType: roomChoice, wifi: hasWifi)
        
    }
    
    
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var checkInlbl: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLbl:UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLbl: UILabel!
    @IBOutlet weak var numberOfChildrenLbl: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildreStepper: UIStepper!
    @IBOutlet weak var wifiSwitchOption: UISwitch!
    @IBOutlet weak var roomTypeSelcetedLbl: UILabel!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var numberOfNightsLbl: UILabel!
    @IBOutlet weak var totalPerRoomLbl: UILabel!
    @IBOutlet weak var totalWiFiLbl: UILabel!
    @IBOutlet weak var totalChargesLbl: UILabel!
    
    @IBAction func cancelAnEntry (_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchValueDidChange (_ sender: UISwitch){
        
    }
    
    @IBAction func datePickerCheckInDateChanged(_ sender:UIDatePicker){
        updateView()
        if self.registration != nil  {
        calculateChargesBasedOnNumberOfNightsPurchased(CheckIn: self.registration!, CheckOut: self.registration!)
        }
    }
    @IBAction func datePickerCheckOutDateChanged(_ sender:UIDatePicker){
        updateView()
        if self.registration != nil  {
        calculateChargesBasedOnNumberOfNightsPurchased(CheckIn: self.registration!, CheckOut: self.registration!)
        }
    }
    
    @IBAction func stepperAdultsDidChangeValue(_ sender: UIStepper){
        
        updateNumberOfGuests()
    }
    
    @IBAction func stepperChildrenDidChangeVAlue (_ sender: UIStepper){
        updateNumberOfGuests()
    }
    
    func updateNumberOfGuests(){
        numberOfAdultsLbl.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLbl.text = "\(Int(numberOfChildreStepper.value))"
    }
    
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeSelcetedLbl.text = roomType.name
        } else {
            roomTypeSelcetedLbl.text = "Not Set"
        }
    }
    
    func updateView(){
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        checkInlbl.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLbl.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    
    func didSelectRoomType(RoomType: RoomType) {
        self.roomType = RoomType
        updateRoomType()
        enableDesableDonebutton()
        calculateChargesBasedOnNumberOfNightsPurchased(CheckIn: self.registration!, CheckOut: self.registration!)
    }
    
  
   
    @IBAction func editingChanged(_ sender: Any) {
        enableDesableDonebutton()
        if self.registration != nil  {
            if self.registration != nil  {
            calculateChargesBasedOnNumberOfNightsPurchased(CheckIn: self.registration!, CheckOut: self.registration!)
            }
        }
    }
    
    func enableDesableDonebutton() {
        if self.registration == nil {
            doneBtn.isEnabled = false
        } else if self.registration?.firstName != nil && self.registration?.emailAddress != nil && self.registration?.lastName != nil && self.registration?.roomType != nil && self.registration?.numberOfAdults != nil {
            doneBtn.isEnabled = true
        }else {
            doneBtn.isEnabled = false
        }
        if doneBtn.isEnabled {
            if self.registration != nil  {
            calculateChargesBasedOnNumberOfNightsPurchased(CheckIn: self.registration!, CheckOut: self.registration!)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableDesableDonebutton()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
       
        updateView()
        updateNumberOfGuests()
        wifiSwitchOption.isOn = false
        updateRoomType()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   
        }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDateShown {
                return 216.0
            }else {
                return 0
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            }else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1) :
            if isCheckInDateShown {
                isCheckInDateShown = false
            } else {
                isCheckInDateShown = true
                isCheckOutDatePickerShown = false
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
        if isCheckOutDatePickerShown {
            isCheckOutDatePickerShown = false
        } else {
            isCheckOutDatePickerShown = true
            isCheckInDateShown = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        default:
            break
        }
        let point = roomTypeSelcetedLbl.convert(CGPoint.zero, to: tableView)
        if indexPath  == tableView.indexPathForRow(at: point){
            enableDesableDonebutton()
            performSegue(withIdentifier: "SelectRoomType", sender: tableView)
            
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType"{
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }

    func calculateChargesBasedOnNumberOfNightsPurchased(CheckIn:Registration, CheckOut:Registration){
        var wifiTotal:Int = 0
        var totalRoom:Int
        var totalCharges:Int
        let timebetweenInAndOut = CFDateGetTimeIntervalSinceDate(CheckOut.checkOutDate as CFDate, CheckIn.checkInDate as CFDate)
        let secondsInOneDay = 24 * 60 * 60
        let numberOfNights = Int(timebetweenInAndOut / Double(secondsInOneDay))
        if self.registration?.wifi == true {
            wifiTotal = 10 * numberOfNights
            totalWiFiLbl.text = "$ \(wifiTotal)"
        } else {
            totalWiFiLbl.text = "$ 0"
        }
        let registration = CheckIn
         totalRoom = checkRoomType(forThis: registration) * numberOfNights
        totalPerRoomLbl.text = "$ \(totalRoom)"
        
        totalCharges = totalRoom + wifiTotal
        
        totalChargesLbl.text = "$ \(totalCharges)"
        numberOfNightsLbl.text = "\(numberOfNights)"
    }
    
    func checkRoomType(forThis: Registration)-> Int{
        var index = 0
        var priceRoom = 0
        for i in AddREgistrationTableViewController.all {
            if forThis.roomType == AddREgistrationTableViewController.all[index].name {
                priceRoom = AddREgistrationTableViewController.all[index].price
                index += 1
            }else {
                index += 1
            }
        }
        return priceRoom
    }

}


