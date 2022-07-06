//
//  BookingController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 30/11/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit

class BookingController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet var bookview: UIView!
    
    @IBOutlet weak var errorlblBooking: UILabel!
    
    @IBOutlet weak var bookscrollview: UIScrollView!
    
    @IBOutlet weak var suburb: UITextField!
   
   // @IBOutlet weak var suburb: UITextField!
    @IBOutlet weak var postcode: UITextField!
    
  //  @IBOutlet weak var postcode: UITextField!
   
   // @IBOutlet weak var street: UITextField!
    @IBOutlet weak var street: UITextField!
    
    //@IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    
   // @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    
   // @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var email: UITextField!
   
    
    @IBOutlet weak var contactNumber: UITextField!
  
    
    @IBOutlet weak var dateOfBirth: UITextField!
    //@IBOutlet weak var gender: UITextField!
    @IBOutlet weak var gender: UITextField!
    
    
    
   // @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var data = ["Female","Male"]
    var pickerView = UIPickerView()
    
    
    var medicareNum =  String()
    var refNum =  String()
    var expDate = String()
    var isSendData : Bool = false;
    
    let resource = Utility()
    
    
   // @IBOutlet weak var bookinScroll: UIScrollView!
    
    
    @IBAction func goHome(_ sender: Any) {
        // self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async{
            
            
            
            let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
            
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeControllerID") as UIViewController
            
            
            self.present(vc ,animated: true, completion: nil )
            
        }

    }
 
    
    @IBAction func selectGender(_ sender: UITextField) {
       
       // let uiPicker = UIPickerView();
        if(gender.text==""){
            gender.text=data[0]
        }
   
    }
    @IBAction func enteredSuburb(_ sender: Any) {
        
        
      //  print("****** sentered suburb ******")
        
        let suburbtxt = suburb.text
        
        //Check Subub
        
        
        //create the url with NSURL
        let url = URL(string: resource.url)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod="POST"
        
     //   print("suburb ")
     //   print(suburbtxt!.uppercased())
        
        let postString  = "CHECKPC=POSTCODE&POSTCODE=\(suburbtxt!.uppercased())"
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
                if let dictionary  = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                 //   print("test 2")
                    
                 //   print("dic: \(dictionary)")
                
                   
                    if var suc:Int=dictionary["SUCCESS"]as! Int?{
                      //  print("success: \(suc)")
                        
                        if((suc as Int)==1){
                            
                            
                            //enable all text fields except postcode
                            
                            if  let postcodeVal  = dictionary["postcode"]{
                                
                             //   print("postcode  \(postcodeVal)")
                            
                            
                                
                                DispatchQueue.main.async{
                                    self.errorlblBooking.text = " "
                                    self.postcode.text = postcodeVal as! String
                                    self.street.isUserInteractionEnabled = true
                                    self.firstname.isUserInteractionEnabled = true
                                    self.lastname.isUserInteractionEnabled = true
                                    self.email.isUserInteractionEnabled = true
                                    self.contactNumber.isUserInteractionEnabled = true
                                    self.dateOfBirth.isUserInteractionEnabled =  true
                                    self.gender.isUserInteractionEnabled = true
                                    self.nextBtn.isUserInteractionEnabled = true
                                    
                                    
                                }
                                
                              //  print("postcode printed")
                                
                            
                            }
                            
                            
                            
                            
                            
                        }else{
                            //errorlblLogin.text = "Invalid User name or Password" ;
                            DispatchQueue.main.async{
                                self.errorlblBooking.text = "We are not servicing this suburb"
                                self.postcode.text = " "
                            }
                            self.displayErrorAlert(userMessage: "Sorry !! We are not servicing this suburb")

                        }
                        
                    }
                
                
                
                }
            } catch let error {
             //   print(error.localizedDescription)
            }
        })
        task.resume()
        
        
    }
    
    
    func displayErrorAlert(userMessage:String){
        
        let errorAlert=UIAlertController(title:"Alert",message:userMessage,preferredStyle:UIAlertControllerStyle.alert);
        
        let displayAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:nil);
        
        errorAlert.addAction(displayAction);
        self.present(errorAlert,animated:true,completion:nil);
        
    }
    
    
    
    @IBAction func goNext(_ sender: Any) {
      
        self.errorlblBooking.text = ""
        
        let suburbtxt = suburb.text
        let postcodetxt = postcode.text
        let streettxt = street.text
        let firstnametxt = firstname.text
        let lastnametxt = lastname.text
        let emailtxt=email.text
        let contactNumbertxt=contactNumber.text
        let dateOfBirthtxt=dateOfBirth.text
        let gendertxt = gender.text
        
        
        
     //   print("values\(suburbtxt)")
        
        
        //Check empty fields
        
        /*


        if(suburbtxt.isEmpty || postcodetxt.isEmpty || streettxt.isEmpty || firstnametxt.isEmpty || lastnametxt.isEmpty ||
        emailtxt.isEmpty || contactNumbertxt.isEmpty || dateOfBirthtxt.isEmpty){
        
        //Display error alert
        self.errorlblBooking.text = "All fields are required"
        displayErrorAlert("All fields are required");
        return;


*/
        
        
        
        if(suburbtxt?.isEmpty)!{
                
                //Display error alert
                self.errorlblBooking.text = "Add suburb"
                displayErrorAlert(userMessage: "Add suburb");
                return;
        }else if(streettxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add street"
            displayErrorAlert(userMessage: "Add street");
            return;
        }
        else if(firstnametxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add first name"
            displayErrorAlert(userMessage: "Add first name");
            return;
        }
        else if(lastnametxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add last name"
            displayErrorAlert(userMessage: "Add last name");
            return;
        }
        else if(emailtxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add email address"
            displayErrorAlert(userMessage: "Add email address");
            return;
        }
        else if(contactNumbertxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add contact number"
            displayErrorAlert(userMessage: "Add contact number");
            return;
        }
        else if(dateOfBirthtxt?.isEmpty)!{
            
            //Display error alert
            self.errorlblBooking.text = "Add date of birth"
            displayErrorAlert(userMessage: "Add date of birth");
            return;
        }
        else
        
        //Validate email
        if(!isValidEmail(testStr: emailtxt!)){
            //Display error alert
           
             self.errorlblBooking.text = "Invalid Email"
            displayErrorAlert(userMessage: "Invalid Email");
            return;
            
            
        }else
            //validate phone number
            
            if (!validatePhone(value: contactNumbertxt!) || contactNumbertxt?.characters.count != 10){
                
                self.errorlblBooking.text = "Invalid contact number"
                displayErrorAlert(userMessage: "Invalid contact number");
                return;

            }else {
            
                
                
               DispatchQueue.main.async{
       
                var storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                //  var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("BookingControllerID") as UINavigationController
            
            
                
                var vc: BookingConfirmationController = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationControllerID") as! BookingConfirmationController
                
                
                vc.suburb = self.suburb.text!
                vc.postcode = self.postcode.text!
                vc.street = self.street.text!
                vc.firstName = self.firstname.text!
                vc.lastName = self.lastname.text!
                vc.email = self.email.text!
                vc.contactNumber  = self.contactNumber.text!
                vc.dob = self.dateOfBirth.text!
                vc.gender = self.gender.text!
                
                if(self.isSendData){
                    vc.medi = self.medicareNum
                    vc.ref = self.refNum
                    vc.exp = self.expDate
                }

                
                self.present(vc ,animated: true, completion: nil )
                }

                
        }
      
    }
    
    
    

    
    
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        // let result =  phoneTest.evaluateWithObject(value)
        // return result
        return true
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate emilId: \(testStr)")
       // let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        
        let  emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    
    @IBAction func selectDate(_ sender: UITextField) {
        
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.maximumDate = NSDate() as Date
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)

        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
          dateOfBirth.text = dateFormatter.string(from: sender.date)
       
        
        
    }
    
 /*   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch happened")
        self.view.endEditing(true)
    }
  */  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
   
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return gender.text = data[row]
    }
    
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return data[row]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        self.suburb.delegate=self
        self.postcode.delegate=self
        self.street.delegate=self
        self.firstname.delegate=self
        self.lastname.delegate=self
        self.email.delegate=self
        self.contactNumber.delegate=self
        self.dateOfBirth.delegate=self
        self.gender.delegate=self
        
       
        // gender.text = data[0]

        bookview.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        bookview.layer.borderWidth = 3.0;

        
        pickerView.delegate = self
        pickerView.dataSource = self
        gender.inputView = pickerView
      
        // Do any additional setup after loading the view.
  
        //GET DATA FROM PHONE - check whether loggedUser
        let isloggedUser :  Bool = UserDefaults.standard.bool(forKey: "isLoggedUser")
        
        if(isloggedUser == true){
            //Get saved data from db
            
           // print("logged user +++++ ")
            let userId :  String = UserDefaults.standard.string(forKey: "userID")!
            
           // print("logged user +++++\(userId)")
            
                       
        
            
            //create the url with NSURL
            let url = URL(string: resource.url)! //change the url
            
            //create the session object
            let session = URLSession.shared
            
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            let postString  = "UGDATA=USERDATA&USERID=\(userId)"
            
            //  let postString  = "LGN=LOGIN&UNAME=\(userName!)&PASSWORD=\(password!)"
            
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
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary{
                   //     print("dic: \(dictionary)")
                        
                        if var suc:Int=dictionary["success"] as! Int?{

                    //        print("success: \(suc)")
                            
                            self.firstname.text = "Test 1"
                            
                            
                            
                            if((suc as AnyObject! as! Int)==1){
                                //Display confirmation message
                                
                                
                                
                                DispatchQueue.main.async{
                                    
                                    
                                    var info : NSDictionary = dictionary.value(forKey: "data") as! NSDictionary
                                    
                                    var firstNameval: String? = info["firstName"] as? String
                               //     print("name ++\(firstNameval!)")
                                    self.firstname.text = firstNameval!
                                    
                                    var lastNameval : String? = info["lastName"] as? String
                                    self.lastname.text = lastNameval!
                                    
                                    var contactNumberval : String? = info["contactNumber"] as? String
                                    self.contactNumber.text = contactNumberval!
                                    
                                    var contactEmailval : String? = info["contactEmail"] as? String
                                    self.email.text = contactEmailval!
                                    
                                    var genderval : String? = info["gender"] as? String
                                    self.lastname.text = contactEmailval!
                                    
                                    
                                    let gen = genderval!  as String
                                    if(gen  == "0"){
                                        self.gender.text = "Male"
                                    }else{
                                        self.gender.text = "Female"
                                    }
                                    
                                    var suburbval : String? = info["name"] as? String
                                    self.suburb.text = suburbval!
                                    
                                    var codeval : String? = info["code"] as? String
                                    self.postcode.text = codeval!
                                    
                                    
                                    
                                    var streetval  : String? = info["address1"] as? String
                                    self.street.text = streetval!
                                    
                                    var dateOfBirthval : String? = info["DOB"] as? String
                                    self.dateOfBirth.text = dateOfBirthval!
                                    
                                    
                                    
                                    
                                    self.street.isUserInteractionEnabled = true
                                    self.firstname.isUserInteractionEnabled = true
                                    self.lastname.isUserInteractionEnabled = true
                                    self.email.isUserInteractionEnabled = true
                                    self.contactNumber.isUserInteractionEnabled = true
                                    self.dateOfBirth.isUserInteractionEnabled =  true
                                    self.gender.isUserInteractionEnabled = true
                                    self.nextBtn.isUserInteractionEnabled = true
                                    
                                    
                                    // var bookCon = BookingConfirmationController()
                                    
                                    
                                    
                                 //   let storyboard = UIStoryboard()
                                 //   let bookCon: BookingConfirmationController = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationControllerID") as! BookingConfirmationController
                                    
                                   
                                    
                                  //  let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                                    
                                  //  let bookCon: BookingConfirmationController = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationControllerID") as! BookingConfirmationController
                                    
                                    
                                    self.isSendData = true
                                    
                                     let medicareval : String? = info["medicareNumber"] as? String
                                    // bookCon.medi = medicareval!
                                    self.medicareNum = medicareval!
                                    
                                     
                                     let refval  : String? = info["refferenceNumber"] as? String
                                   //  bookCon.ref = refval!
                                     self.refNum = refval!
                                     
                                     let expval  : String? = info["expiryDate"] as? String
                                   //  bookCon.exp = expval!
                                    self.expDate = expval!
                                    
                                    
                                //    print("medi\(medicareval!)")
                                 //   print("refval\(refval!)")
                                 //   print("expval\(expval!)")
                                    
                                    
                                }

                            }
                            
                            
                            
                        }
                        
                        
                    }
                } catch let error {
                  //  print(error.localizedDescription)
                }
            })
            task.resume()
            
            
            
            
        }else {
            //check whether has data
            let hasData:  Bool = UserDefaults.standard.bool(forKey: "hasData")
            if(hasData == true){
                
                street.text = UserDefaults.standard.string(forKey: "STREET")
                postcode.text = UserDefaults.standard.string(forKey: "POSTCODE")
                suburb.text = UserDefaults.standard.string(forKey: "SUBURB")
                firstname.text = UserDefaults.standard.string(forKey: "FIRSTNAME")
                lastname.text = UserDefaults.standard.string(forKey: "LASTNAME")
                email.text = UserDefaults.standard.string(forKey: "EMAIL")
                contactNumber.text = UserDefaults.standard.string(forKey: "CONTACTNUMBER")
                
                dateOfBirth.text = UserDefaults.standard.string(forKey: "BDAY")
                gender.text = UserDefaults.standard.string(forKey: "GENDER")
                
                
                self.street.isUserInteractionEnabled = true
                self.firstname.isUserInteractionEnabled = true
                self.lastname.isUserInteractionEnabled = true
                self.email.isUserInteractionEnabled = true
                self.contactNumber.isUserInteractionEnabled = true
                self.dateOfBirth.isUserInteractionEnabled =  true
                self.gender.isUserInteractionEnabled = true
                self.nextBtn.isUserInteractionEnabled = true
                //Check suburb here
                
                
            }
            
        }
        
        
        

        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if  UIDevice.current.orientation.isLandscape{
            if(textField == gender){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 350), animated: true)
            }else if(textField == dateOfBirth){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 300), animated: true)
            }else if(textField == contactNumber){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 275), animated: true)
            }else if(textField == email){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 250), animated: true)
            }else if(textField == lastname){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 200), animated: true)
            }else if(textField == firstname){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
            }else if(textField == street){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
            }else if(textField == suburb){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 75), animated: true)
            }
        }else{
            if(textField == gender){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
            }else if(textField == dateOfBirth){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
            }else if(textField == contactNumber){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
            }else if(textField == email){
                bookscrollview.setContentOffset(CGPoint.init(x: 0, y: 75), animated: true)
            }
        }
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        bookscrollview.setContentOffset(CGPoint.zero, animated: true)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookscrollview.contentSize = CGSize(width: 200, height: 620)

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
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
