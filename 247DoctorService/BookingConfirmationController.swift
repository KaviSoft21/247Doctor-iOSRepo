//
//  BookingConfirmationController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 6/12/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit
import SystemConfiguration


class BookingConfirmationController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet var bookconView: UIView!
    @IBOutlet weak var bookconscrollview: UIScrollView!
    
    var suburb : String = ""
    var postcode : String = ""
    var street : String = ""
    var firstName : String = ""
    var lastName :  String = ""
    var email : String = ""
    var contactNumber :  String = ""
    var dob : String  = ""
    var gender : String = ""
    
    var medi : String = ""
    var exp :  String = ""
    var ref : String = ""
    
    //@IBOutlet weak var medicareTextField: UITextField!
    @IBOutlet weak var medicareTextField: UITextField!
    
    //@IBOutlet weak var refTextfield: UITextField!
    @IBOutlet weak var refTextfield: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    
    //@IBOutlet weak var expiryDateTextField: UITextField!
    
   // @IBOutlet weak var symtomsTextfIELD: UITextView!
    
    @IBOutlet weak var symtomsTextfIELD: UITextView!
   // @IBOutlet weak var prefferedTimetxt: UITextField!
    @IBOutlet weak var prefferedTimetxt: UITextField!
    
   // @IBOutlet weak var reason: UITextView!
    
    @IBOutlet weak var reason: UITextView!
    let resource = Utility()
   
    
    @IBOutlet weak var errorbookconlbl: UILabel!
    
   // @IBOutlet weak var errorbookconlbl: UILabel!
    
    var dayofweekOne = ["8am to 10am","10am to 12 pm","12pm to 2 pm","2pm to 4pm","4pm to 6pm","6pm to 8pm","8pm to 10pm","10pm to 12 am"]
    var dayofweekSeven = ["12pm to 2pm","2pm to 4pm","4pm to 6pm","6pm to 8pm","8pm to 10pm","10pm to 12am"]
    var otherdays = ["6pm to 8 pm","8pm to 10pm","10pm to 12 am"]
    
    
   // var data =  []
    var pickerView = UIPickerView()
    
    @IBAction func goHome(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func displayPrefTime(_ sender: UITextField) {
        
       // let timePicker = UIPickerView ()
        if(prefferedTimetxt.text==""){
            
            
            let day : String = getDay()
            
            //print("dayyyyyy \(day.uppercased())")
            
            
            if(day.uppercased() == "SUNDAY"){
              prefferedTimetxt.text=dayofweekOne[0]
                
            }else if(day.uppercased() == "SATURDAY"){
               prefferedTimetxt.text=dayofweekSeven[0]
       
            }else{
                prefferedTimetxt.text=otherdays[0]
                
            }
   
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookconscrollview.contentSize = CGSize(width: 200, height: 620)
        
    }
    
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
     //   print("triggered method")
        if  UIDevice.current.orientation.isLandscape{
            if(textField == prefferedTimetxt){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
            }else if(textField == expiryDateTextField){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
            }else if(textField == refTextfield  ){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 75), animated: true)
            }else if(textField == medicareTextField){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 50), animated: true)
            }
        }else{
            if(textField == prefferedTimetxt){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 75), animated: true)
            }
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bookconscrollview.setContentOffset(CGPoint.zero, animated: true)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView){
     //   print("triggered method text view" )
        if  UIDevice.current.orientation.isLandscape{
            if(textView == reason){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 200), animated: true)
            
            }else if(textView == symtomsTextfIELD){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
            }
            
        }else{
            if(textView == reason){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
                
            }else if(textView == symtomsTextfIELD){
                bookconscrollview.setContentOffset(CGPoint.init(x: 0, y: 50), animated: true)
            }
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        bookconscrollview.setContentOffset(CGPoint.zero, animated: true)    }
    
   

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let day : String = getDay()
        //if(day.uppercaseString == "SUNDAY"){
        if(day.uppercased() == "SUNDAY"){
            
            return dayofweekOne.count
        }else if(day.uppercased() == "SATURDAY"){
            
            return dayofweekSeven.count
            
        }else{
            return otherdays.count
            
        }    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let day : String = getDay()
        
        if(day.uppercased() == "SUNDAY"){
            return prefferedTimetxt.text = dayofweekOne[row]
            
        }else if(day.uppercased() == "SATURDAY"){
            return prefferedTimetxt.text = dayofweekSeven[row]
        }else{
            return prefferedTimetxt.text = otherdays[row]
            
        }

    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let day : String = getDay()
        
      //  print("dayyyyyy \(day.uppercased())")
        let val: Bool = day.uppercased() == "SATURDAY"
      //  print("ansss :\(val)")
        
        if(day.uppercased() == "SUNDAY"){
            
            return dayofweekOne[row]
            
            
        }else if(day.uppercased() == "SATURDAY"){
            
            
           
            
            return dayofweekSeven[row]
        }else{
            return otherdays[row]
            
        }
    }
    
    
    


 
 
 
   
    
    func getDay() -> String  {
        
        let date = NSDate()
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "EEEE"
        
        let day = dateFormmater.string(from: date as Date)
        
       // println("today++++++\(day.uppercaseString)")
        return day

    }
    
    
    func displayErrorAlert(userMessage:String){
        
        let errorAlert=UIAlertController(title:"Alert",message:userMessage,preferredStyle:UIAlertControllerStyle.alert);
        
        let displayAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:nil);
        
        errorAlert.addAction(displayAction);
        self.present(errorAlert,animated:true,completion:nil);
        
    }


    
    @IBAction func tappedBook(_ sender: Any) {
        self.errorbookconlbl.text = " "
        
        let medicaretxt = medicareTextField.text
        let refNumtxt = refTextfield.text
        let expirytxt = expiryDateTextField.text
        let symtoms = symtomsTextfIELD.text
        let prefferedTimetxtval = prefferedTimetxt.text
        let reasontxt = reason.text
        
       
        
        if(medicaretxt?.isEmpty)!{
            self.displayErrorAlert(userMessage: "Add medicare number");
            self.errorbookconlbl.text = "Add medicare number"
         //   medicareTextField.layer.borderColor = CGColorCreateCopy(CGColorGetColorSpace() )
        } else if(refNumtxt?.isEmpty)!{
            self.displayErrorAlert(userMessage: "Add refference number");
            self.errorbookconlbl.text = "Add refference number"
        } else if(expirytxt?.isEmpty)!{
            self.displayErrorAlert(userMessage: "Add expiry date number");
            self.errorbookconlbl.text = "Add expiry date number"
        } else if((medicaretxt?.characters.count) != 10 || !isMedicareValid(input: medicaretxt!)){
            self.displayErrorAlert(userMessage: "Invalid medicare number");
            self.errorbookconlbl.text = "Invalid medicare number"
        } else if((refNumtxt?.characters.count) != 1){
            displayErrorAlert(userMessage: "Invalid refference number");
            self.errorbookconlbl.text = "Invalid refference number"
        }else{
        
            var genval : String
            if (gender.capitalized == "FEMALE"){
                genval = "1"
            }else{
                genval = "0"
            }

        
            //Save data (do booking)
            var postString : String = ""
            
            

            //create the url with NSURL
            let url = URL(string:  resource.url)! //change the url
            
            //create the session object
            let session = URLSession.shared
            
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod="POST"
            
            //GET DATA FROM PHONE - check whether loggedUser
            // let isloggedUser :  Bool = NSUserDefaults.standardUserDefaults().boolForKey("isLoggedUser")
            let isloggedUser  = UserDefaults.standard.bool(forKey: "isLoggedUser")
            if(isloggedUser == true){
                //let userId :  String  = NSUserDefaults.standardUserDefaults().stringForKey("userID")!;
                let userId :  String = UserDefaults.standard.value(forKey: "userID") as! String
                
                postString  = "bookfp=booking&STREET=\(street)&SUBURB=\(suburb)&POSTCODE=\(postcode)&FIRSTNAME=\(firstName)&LASTNAME=\(lastName)&EMAIL=\(email)&CONTACTNUMBER=\(contactNumber)&BDAY=\(dob)&GENDER=\(genval)&MEDINUM=\(medicaretxt!)&REFFERENCENUM=\(refNumtxt!)&EXPIRYDATE=\(expirytxt!)&SYMPTON=\(symtoms!)&PRETIME=\(prefferedTimetxtval!)&PREASON=\(reasontxt!)&USERID=\(userId)";
                
                
            } else {
                postString  = "bookfp=booking&STREET=\(street)&SUBURB=\(suburb)&POSTCODE=\(postcode)&FIRSTNAME=\(firstName)&LASTNAME=\(lastName)&EMAIL=\(email)&CONTACTNUMBER=\(contactNumber)&BDAY=\(dob)&GENDER=\(genval)&MEDINUM=\(medicaretxt!)&REFFERENCENUM=\(refNumtxt!)&EXPIRYDATE=\(expirytxt!)&SYMPTON=\(symtoms!)&PRETIME=\(prefferedTimetxtval!)&PREASON=\(reasontxt!)";
             
                
            }

            
            
            
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            
            
            
            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    //create json object from data
                    if let dictionary  = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                     //   print("dic: \(dictionary)")
                        
                         if var suc:Int=dictionary["success"] as! Int?{
                     //       print("success: \(suc)")
                            
                            
                            
                            
                            if((suc as Int)==1){
                                //Display confirmation message
                                
                              //  print("success")
                                
                                //If success and not logged user save data
                                
                                if(isloggedUser == false){
                                    
                                    
                                    //save data only if not logged user
                                    //UserDefaults.standard.setValue(token, forKey: "user_auth_token")
                                    
                                    UserDefaults.standard.setValue("true", forKey: "hasData")
                                    UserDefaults.standard.setValue(self.street, forKey: "STREET")
                                    UserDefaults.standard.setValue(self.suburb, forKey: "SUBURB")
                                    UserDefaults.standard.setValue(self.postcode, forKey: "POSTCODE")
                                    UserDefaults.standard.setValue(self.firstName, forKey: "FIRSTNAME")
                                    UserDefaults.standard.setValue(self.lastName, forKey: "LASTNAME")
                                    UserDefaults.standard.setValue(self.email, forKey: "EMAIL")
                                    
                                    UserDefaults.standard.setValue(self.contactNumber, forKey: "CONTACTNUMBER")
                                    UserDefaults.standard.setValue(self.dob, forKey: "BDAY")
                                    UserDefaults.standard.setValue(self.gender, forKey: "GENDER")
                                    
                                    UserDefaults.standard.setValue(medicaretxt, forKey: "MEDINUM")
                                    UserDefaults.standard.setValue(refNumtxt, forKey: "REFFERENCENUM")
                                    
                                    UserDefaults.standard.setValue(expirytxt, forKey: "EXPIRYDATE")
                                    UserDefaults.standard.setValue(symtoms, forKey: "SYMPTON")
                                    
                                    
                                    
                                    
                                    //   UserDefaults.standardUserDefaults().synchronize();
                                    
                                }
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                  DispatchQueue.main.async{
                                    
                                    
                                    var storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                                    //  var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("BookingControllerID") as UINavigationController
                                    
                                    
                                    var vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "logoutControllerID") as UIViewController
                                    
                                    
                                    self.present(vc ,animated: true, completion: nil )
                                    
                                }
                                
                                
                                

                            }else{
                                
                                //Chcek internet conectivity
                                if(!self.isConnectedToNetwork()){
                                    DispatchQueue.main.async{
                                    self.displayErrorAlert(userMessage: "No internet connection");
                                      self.errorbookconlbl.text = "No internet connection"
                                    }
                                }else{
                                    DispatchQueue.main.async{
                                    self.displayErrorAlert(userMessage: "Oops! Error");
                                       self.errorbookconlbl.text = "Oops! Error"
                                    }
                                }
                                

                                
                            }
                            
                            
                        }
                        
                        
                    }
                } catch let error {
                   // print(error.localizedDescription)
                }
            })
            task.resume()
        
        
        
            
            
        }
        
  
    }


    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }

    
    
    
    @IBAction func addExpireDate(_ sender: UITextField) {
      //  let expiryDatePicker = MonthYearPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        
        let expiryDatePicker = MonthYearPickerView()
        
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            //let string = String(format: "%02d/%d", month, year)
            let string = String(format: "%02d-%d", month, year)
            //NSLog(string) // should show something like 05/2015
            self.expiryDateTextField.text = string
        }
        
        sender.inputView = expiryDatePicker
        
       expiryDateTextField.addTarget(self, action: "datePickerValueChanged:", for: UIControlEvents.valueChanged)

        
    }

    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        
        
        expiryDateTextField.text = dateFormatter.string(from: sender.date)
        
        
        
    }

    
    
    
   
    
    
    
    
    /*
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 self.view.endEditing(true)
 }
 */



    
    

   override func viewDidLoad() {
        super.viewDidLoad()
     self.hideKeyboard()
   
   
    
    bookconView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
    
    bookconView.layer.borderWidth = 3.0;

   
    
        refTextfield.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        prefferedTimetxt.inputView = pickerView
    
       // Do any additional setup after loading the view.
        
   
        //GET DATA FROM PHONE - check whether loggedUser
        let isloggedUser :  Bool = UserDefaults.standard.bool(forKey: "isLoggedUser")
    
        if(isloggedUser == true){
           //Get saved data from db
           // print("logged user")
           // print("load logged data from db")
            
                 /*  self.medicareTextField.text = "\(medi)"
            self.refTextfield.text = "\(ref)"
            self.expiryDateTextField.text = exp */
            
            
            self.medicareTextField.text = medi
            self.refTextfield.text = ref
            self.expiryDateTextField.text = exp
            
           // print("medi\(medi)")
          //  print("refval\(ref)")
           // print("expval\(exp)")

            
        
        }else {
         //   print("not a logged user")
            //check whether has data
            let hasData:  Bool = UserDefaults.standard.bool(forKey: "hasData")
            if(hasData == true){
                medicareTextField.text = UserDefaults.standard.string(forKey: "MEDINUM")
                refTextfield.text = UserDefaults.standard.string(forKey: "REFFERENCENUM")
                expiryDateTextField.text = UserDefaults.standard.string(forKey: "EXPIRYDATE")
                symtomsTextfIELD.text = UserDefaults.standard.string(forKey: "SYMPTON")
                
            }
            
        }
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // self.view.endEditing(true)
        return true
    }

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func isMedicareValid(input : String) -> Bool {
        
        let multipliers = [1, 3, 7, 9, 1, 3, 7, 9]
        
        let pattern = "^(\\d{8})(\\d)"
        let medicareNumber = input.trimmingCharacters(in: .whitespaces)
        let expression = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        
               let matches = expression.matches(in: medicareNumber, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, 10))
        
       
        var total = 0
        let characters = Array(medicareNumber.characters)
         let checkDigit  = Int(String(characters[8]))
        if (matches.count > 0 && matches[0].numberOfRanges > 2) {
            
            for i in 0..<multipliers.count {
                
            
              total += Int(String(characters[i]))! * multipliers[i]
            }
            
           // print("total\(total)")
           
           
            
         //   print("checkDigit\(checkDigit)")
            
          //  print("ope\(total % 10)")
            
         //  print("val\((total % 10) == Int(checkDigit!))")
            
          //  return (total % 10) == Int(checkDigit!)
        }
        
        
        
        return (total % 10) == Int(checkDigit!)
    }

    
}

