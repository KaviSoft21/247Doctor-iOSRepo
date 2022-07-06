//
//  RegisterController.swift
//  247Doctor
//
//  Created by NEIL UDUKALA on 24/11/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit
import SystemConfiguration

class RegisterController: UIViewController , UITextFieldDelegate{
    
  //  @IBOutlet var regView: RE!
   @IBOutlet var regView: UIView!
   
    @IBOutlet weak var regscrollview: UIScrollView!
    
   // @IBOutlet weak var txtregfirstname: UITextField!
    
    @IBOutlet weak var txtregfirstname: UITextField!
    
    @IBOutlet weak var errorlblReg: UILabel!
   
    
   // @IBOutlet weak var txtreglastname: UITextField!
   
    @IBOutlet weak var txtreglastname: UITextField!
  //  @IBOutlet weak var txtregusername: UILabel!
    
    @IBOutlet weak var txtregusername: UITextField!
    
    @IBOutlet weak var txtregpassword: UITextField!
    
  //  @IBOutlet weak var txtregpassword: UITextField!
    
    @IBOutlet weak var txtregpasswordcon: UITextField!
    
  //  @IBOutlet weak var txtregpasswordcon: UITextField!
    
    let resource = Utility()
    
   
    
    //Save data
    //+++ SAVE DATA IN PHONE
    //NSUserDefaults.standardUserDefaults().setObject(firstname,forKey:"firstname");
    // NSUserDefaults.standardUserDefaults().synchronize();
    
    //GET DATA FROM PHONE
    //let ofirstname= NSUserDefaults.standardUserDefaults().stringForKey("firstname");
    //+++++++
    
    @IBAction func goHome(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doRegister(_ sender: Any) {
        
        let firstname=txtregfirstname.text;
        let lastname=txtreglastname.text;
        let username=txtregusername.text;
        let password=txtregpassword.text;
        let passwordrepeat=txtregpasswordcon.text;
        
      
        
    //    print("firstname:\(firstname)")
    //    print("lastname:\(lastname)")
    //    print("username:\(username)")
        
        
        //check empty field
        if((firstname?.isEmpty)!){
                //Display error alert
                displayErrorAlert(userMessage: "Add first name");
                errorlblReg.text = "Please add first name"
                return;
                
        
        }else if((lastname?.isEmpty)!){
            displayErrorAlert(userMessage: "Add last name");
            errorlblReg.text = "Please add last name"
            return;

            
        }else if((username?.isEmpty)!){
            
            displayErrorAlert(userMessage: "Add user name");
            errorlblReg.text = "Please add user name"
            return;

        
        
    }else if((password?.isEmpty)!){
            displayErrorAlert(userMessage: "Add password");
            errorlblReg.text = "Please add password"
            return;

        
    }else if((passwordrepeat?.isEmpty)!){
            displayErrorAlert(userMessage: "Add confirm password");
            errorlblReg.text = "Please add confirm password"
            return;
    
        } else
        
        //Check if password match
        if(password != passwordrepeat){
            //Display error alert
            displayErrorAlert(userMessage: "Passwords do not match");
            errorlblReg.text = "Passwords do not match"
            return;
        }else
        
        //Check password length
        if((password?.characters.count)! < 5){
            //Display error alert
            displayErrorAlert(userMessage: "Passwords should have at least 5 digits");
            errorlblReg.text = "Passwords should have at least 5 digits"
            return;
            
        }else
        
        
        //Validate email
        if(!isValidEmail(testStr: username!)){
            //Display error alert
            // print("error display");
            displayErrorAlert(userMessage: "Invalid Email");
            errorlblReg.text = "Invalid Email"
            return;
            
            
        }else{
            //check email availability

            //create the url with NSURL
            let url = URL(string: resource.url)! //change the url
            
            //create the session object
            let session = URLSession.shared
            
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            let checkString  = "CUNAME=checkUserName&USERNAME=\(username!)"
            request.httpBody = checkString.data(using: String.Encoding.utf8)
            
            
            
            
            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    
                
                //+++++++
                    
                    
                    //create json object from data
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                     //   print("CHECK dic: \(dictionary)")
                        if var suc:Int=dictionary["SUCCESS"] as! Int{
                        
                                                       
                            
                             //   print("CHECK success: \(suc)")
                                
                                
                                
                                if((suc as Int)==1){
                             //       print("******  email already has")
                                    self.displayErrorAlert(userMessage: "Email already exists");
                                    self.errorlblReg.text = "Email already exists"
                                    
                                }else {
                                    
                                    //++++++++++++++
                                    
                                //    print("****  no email ")
                                    
                                    
                                    
                                    //+++++++++
                                    
                                    //Save data
                                    
                                   
                                    
                                    //create the url with NSURL
                                    let url = URL(string: self.resource.url)! //change the url
                                    
                                    //create the session object
                                    let session = URLSession.shared
                                    
                                    //now create the URLRequest object using the url object
                                    var request = URLRequest(url: url)
                                    
                                    request.httpMethod = "POST"
                                
                                    
                                    let postString  = "REG=reg&FIRSTNAME=\(firstname!)&LASTNAME=\(lastname!)&USERNAME=\(username!)&PASSWORD=\(password!)"
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
                                            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                            //   print("dic: \(dictionary)")
                                                
                                                if var suc:Int=dictionary["success"] as!Int?{
                                             //       print("success: \(suc)")
                                                    
                                                    
                                                    
                                                    
                                                    if((suc as Int)==1){
                                                        //Display confirmation message
                                                        
                                                        
                                                        if let userID  = dictionary["userID"]{
                                                       //     print("userid: \(userID)")
                                                            
                                                            //Save data
                                                            //+++ SAVE DATA IN PHONE MEMORY
                                                            
                                                            UserDefaults.standard.setValue("true", forKey: "isLoggedUser")
                                                            UserDefaults.standard.setValue(userID, forKey: "userID")
                                                            
                                                            DispatchQueue.main.async{
                                                                
                                                                var storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                                                                //  var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("BookingControllerID") as UINavigationController
                                                                
                                                                
                                                                var vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "BookingControllerID") as UIViewController
                                                                
                                                                self.present(vc ,animated: true, completion: nil )
                                                            }
                                                            

                                                            
                                                            
                                                        }

                                                    }else{
                                                        //Chcek internet conectivity
                                                        if(!self.isConnectedToNetwork()){
                                                           DispatchQueue.main.async{
                                                            self.displayErrorAlert(userMessage: "No internet connection");
                                                             self.errorlblReg.text = "No internet connection"
                                                            }
                                                        }else{
                                                            DispatchQueue.main.async{
                                                            self.displayErrorAlert(userMessage: "Oops! Error");
                                                              self.errorlblReg.text = "Oops! Error"
                                                            }
                                                            
                                                                                                                    }
                                                
                                                
                                                
                                                    }
                                                }
                                                
                                                
                                            }
                                        } catch let error {
                                          //  print(error.localizedDescription)
                                        }
                                    })
                                    task.resume()
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                

                         //   print("done");

                    
                            
                        }
                    }
                    
                    
                    
                    
                    
                    //++++++
                
                
                
                
                
                
                
                
                
                } catch let error {
                           // print(error.localizedDescription)
                        }
                    });
                    task.resume();
            
            
            
            
            
            
            
            
            
        }
        
        
    
        }
 /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    
    
 */
    
    
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
    
    
    
    
            func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
            {
                textField.resignFirstResponder()
                return true
            }
            
            
   
    func isValidEmail(testStr:String) -> Bool {
        // print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    func displayErrorAlert(userMessage:String){
        
        let errorAlert=UIAlertController(title:"Alert",message:userMessage,preferredStyle:UIAlertControllerStyle.alert);
        
        let displayAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:nil);
        
        errorAlert.addAction(displayAction);
        self.present(errorAlert,animated:true,completion:nil);
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        regscrollview.contentSize = CGSize(width: 200, height: 620)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if  UIDevice.current.orientation.isLandscape{
            if(textField == txtregpasswordcon){
                regscrollview.setContentOffset(CGPoint.init(x: 0, y: 350), animated: true)
            }else if(textField == txtregpassword){
                regscrollview.setContentOffset(CGPoint.init(x: 0, y: 250), animated: true)
            }else if(textField == txtregusername){
                regscrollview.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
            }else if(textField == txtreglastname){
                 regscrollview.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
            }else if(textField == txtregfirstname){
                 regscrollview.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
            }
        }else{
            if(textField == txtregpasswordcon){
                regscrollview.setContentOffset(CGPoint.init(x: 0, y: 75), animated: true)
            }else if(textField == txtregpassword){
                regscrollview.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
            }
        }
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        regscrollview.setContentOffset(CGPoint.zero, animated: true)
    }
    

        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

        regView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        regView.layer.borderWidth = 3.0;
 self.hideKeyboard()
       
        // Do any additional setup after loading the view.
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
