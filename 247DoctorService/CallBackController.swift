//
//  CallBackController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 18/12/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit
import SystemConfiguration


class CallBackController: UIViewController , UITextFieldDelegate{
   // @IBOutlet var callbackView: UIView!
    @IBOutlet weak var callbackscroll: UIScrollView!
    
    @IBOutlet var callbackView: UIView!
    @IBOutlet weak var errorcallbacklbl: UILabel!
  
    @IBOutlet weak var firstnamecb: UITextField!
      @IBOutlet weak var lastnamecb: UITextField!
    
    @IBOutlet weak var contactnumbercb: UITextField!
    
    @IBOutlet weak var callmebtn: UIButton!
    @IBOutlet weak var callhomebtn: UIButton!
    
    
   // @IBOutlet weak var errorcallbacklbl: UILabel!
    
    let resource = Utility()
  

    
    
    @IBAction func goHome(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callBack(_ sender: Any) {
            
        errorcallbacklbl.text = ""
        
        let firstNametxt = firstnamecb.text
        let lastNametxt = lastnamecb.text
        let contactNumtxt =  contactnumbercb.text
        
        
        
        if((firstNametxt?.isEmpty)!){
            displayErrorAlert(userMessage: "Add first name");
            errorcallbacklbl.text = "Add first name"
        
        }else if((lastNametxt?.isEmpty)!){
            displayErrorAlert(userMessage: "Add last name");
            errorcallbacklbl.text = "Add last name"
            
        }else if((contactNumtxt?.isEmpty)!){
            displayErrorAlert(userMessage: "Add contact number");
            errorcallbacklbl.text = "Add contact number"
            
        }else if((contactNumtxt?.characters.count) != 10){
            displayErrorAlert(userMessage: "Invalid contact number");
            errorcallbacklbl.text = "Invalid contact number"
        }else{
            
            //Save data
         
            
            

            //create the url with NSURL
            let url = URL(string:   resource.url)! //change the url
            
            //create the session object
            let session = URLSession.shared
            
            //now create the URLRequest object using the url object
           var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let postString  = "CABACK=call&FIRSTNAME=\(firstNametxt!)&LASTNAME=\(lastNametxt!)&CONTACTNUMBER=\(contactNumtxt!)"
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
                        // print("dic: \(dictionary)")
                    
                         if var suc:Int=dictionary["success"] as! Int{
                            
                         //   print("success: \(suc)")
                            
                            
                            
                            
                            if((suc as Int)==1){
                                //Display confirmation message
                              //  print("successsss")
                                DispatchQueue.main.async{
                                self.displayErrorAlert(userMessage: "Request has been sent successfully");
                                self.errorcallbacklbl.text = "Request has been sent successfully"
                                }
                                
                                
                            }else{
                            //    print("not successss ")
                                //Chcek internet conectivity
                                if(!self.isConnectedToNetwork()){
                                    DispatchQueue.main.async{
                                    self.displayErrorAlert(userMessage: "No internet connection");
                                      self.errorcallbacklbl.text = "No internet connection"
                                    }
                                }else{
                                    DispatchQueue.main.async{
                                    self.displayErrorAlert(userMessage: "Oops! Error");
                                      self.errorcallbacklbl.text = "Oops! Error"
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
    

    
    
    func displayErrorAlert(userMessage:String){
        
        let errorAlert=UIAlertController(title:"Alert",message:userMessage,preferredStyle:UIAlertControllerStyle.alert);
        
        let displayAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:nil);
        
        errorAlert.addAction(displayAction);
        self.present(errorAlert,animated:true,completion:nil);
        
    }

    
    /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
*/
    
    
       
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        callbackscroll.contentSize = CGSize(width: 200, height: 620)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      if  UIDevice.current.orientation.isLandscape{
        if(textField == contactnumbercb){
            callbackscroll.setContentOffset(CGPoint.init(x: 0, y: 350), animated: true)
        }else if(textField == lastnamecb){
            callbackscroll.setContentOffset(CGPoint.init(x: 0, y: 250), animated: true)
        }else{
            callbackscroll.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
        }
        }else{
        if(textField == contactnumbercb){
            callbackscroll.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
        }else if(textField == lastnamecb){
            callbackscroll.setContentOffset(CGPoint.init(x: 0, y: 50), animated: true)
        }
        }
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        callbackscroll.setContentOffset(CGPoint.zero, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.callmebtn.titleLabel?.textColor = UIColor.white
        
       // self.callmebtn.applyGradient(colours: [UIColor.yellow, UIColor.blue])
        
        
        
        firstnamecb.delegate=self
        lastnamecb.delegate=self
        contactnumbercb.delegate=self
        self.hideKeyboard()
        
        callbackView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        callbackView.layer.borderWidth = 3.0;


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


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
