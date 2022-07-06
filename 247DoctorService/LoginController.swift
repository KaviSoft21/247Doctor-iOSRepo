//
//  LoginController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 30/11/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit
import SystemConfiguration

class LoginController: UIViewController  , UITextFieldDelegate {
   // @IBOutlet var loginView: UIView!
    
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginsrollview: UIScrollView!
    
    //@IBOutlet weak var logUserNametxt: UITextField!
    
    @IBOutlet weak var logUserNametxt: UITextField!
    
    @IBOutlet weak var errorlblLogin: UILabel!
    
    //@IBOutlet weak var errorlblLogin: UILabel!
   // @IBOutlet weak var logPasswordtxt: UITextField!
    
    @IBOutlet weak var logPasswordtxt: UITextField!
    let resource = Utility()
    
    

    @IBAction func goHome(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func tappedLogin(_ sender: Any) {
        let userName = logUserNametxt.text
        let password = logPasswordtxt.text
        
        
        if((userName?.isEmpty)! || (password?.isEmpty)!){
            //Display error alert
            // print("error display");
            errorlblLogin.text = "All fields are required"
            displayErrorAlert(userMessage: "All fields are required");
            return;
            
        }else
            
            if( !isValidEmail(testStr: userName!)){
                //Display error alert
                // print("error display");
                errorlblLogin.text = "Invalid Email"
                displayErrorAlert(userMessage: "Invalid Email");
                return;
                
            }else{
                //send request
                
                
                //++++
                
                //create the url with NSURL
                let url = URL(string: resource.url)!
                
                //create the session object
                let session = URLSession.shared
                
                //now create the URLRequest object using the url object
                var request = URLRequest(url: url)
                
                request.httpMethod = "POST"
                
             //   print("username\(userName)")
             //   print("pass\(password)")
                
                let postString  = "LGN=LOGIN&UNAME=\(userName!)&PASSWORD=\(password!)"
                request.httpBody =  postString.data(using: String.Encoding.utf8)
                
                
                
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
                       //     print("login response\(dictionary)")
                            
                            
                            if var suc:Int = dictionary["success"] as! Int {
                           //     print("login success: \(suc)")
                                
                                
                                
                                
                                if((suc as Int)==1){
                                    //Display confirmation message
                                    
                                    
                                    
                                    if let userID  = dictionary["userId"]{
                                        
                                    //    print("userid: \(userID)")
                                        
                                        
                                        //Save data
                                        //+++ SAVE DATA IN PHONE MEMORY
                                        
                                    //    print("userid: \(userID)")
                                        
                                        
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
                                      //  print("no internet connection")
                                        DispatchQueue.main.async{
                                        self.errorlblLogin.text = "No internet connection"
                                        self.displayErrorAlert(userMessage: "No internet connection");
                                        }
                                        
                                    }else{
                                       // print("Invalid user name or password")
                                        DispatchQueue.main.async{                                        self.errorlblLogin.text = "Invalid user name or password"
                                        self.displayErrorAlert(userMessage: "Invalid user name or password");
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                    } catch let error {
                     //   print(error.localizedDescription)
                    }
                })
                task.resume()
                
                //++++++++
                
                
                
                
                
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
   
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    
    
    
    @available(iOS 8.0, *)
    func displayErrorAlert(userMessage:String){
        
        let errorAlert=UIAlertController(title:"Alert",message:userMessage,preferredStyle:UIAlertControllerStyle.alert)
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
        loginsrollview.contentSize = CGSize(width: 200, height: 620)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if  UIDevice.current.orientation.isLandscape{
            if(textField == logUserNametxt){
                loginsrollview.setContentOffset(CGPoint.init(x: 0, y: 150), animated: true)
            } else if(textField == logPasswordtxt){
                loginsrollview.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
            }

        }
        /*else{
            if(textField == logUserNametxt){
                loginsrollview.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
            }        }
        
        */
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginsrollview.setContentOffset(CGPoint.zero, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        
        loginView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        loginView.layer.borderWidth = 3.0;

        self.hideKeyboard()
        
        super.viewDidLoad()
        logUserNametxt.delegate = self
        logPasswordtxt.delegate = self
        
       

        // Do any additional setup after loading the view.
    }
    
    
     
  /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
 
 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // self.view.endEditing(true)
        return true
    }
     */

    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
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

}
