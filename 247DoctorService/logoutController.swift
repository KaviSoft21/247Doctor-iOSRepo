//
//  logoutController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 19/12/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit

class logoutController: UIViewController {
    
    
    @IBOutlet weak var logoutbtn: UIButton!
    
   // @IBOutlet var logoutView: UIView!
    
    @IBOutlet var logoutView: UIView!
    
    
    @IBAction func logout(_ sender: Any) {
        
        //Save data
        //+++ SAVE DATA IN PHONE MEMORY
        UserDefaults.standard.set("false",forKey:"isLoggedUser");
         UserDefaults.standard.synchronize();
        
        DispatchQueue.main.async{
            
            
            
            let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
            
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeControllerID") as UIViewController
            
            
            self.present(vc ,animated: true, completion: nil )
            
        }

        
        
        
    }
    
    @IBAction func bookNow(_ sender: Any) {
         DispatchQueue.main.async{

            
            
            let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
            //  var vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("BookingControllerID") as UINavigationController
            
            
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "BookingControllerID") as UIViewController
            
            
            self.present(vc ,animated: true, completion: nil )
            
        }
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func callNow(_ sender: Any) {
         if let phoneCallURL:NSURL = NSURL(string:"tel://\(1800247477)"){
            let application:UIApplication = UIApplication.shared
            if(application.canOpenURL(phoneCallURL as URL)){
                application.openURL(phoneCallURL as URL);
            }
        }

    }

    
    @IBAction func BackHome(_ sender: Any) {
      
        DispatchQueue.main.async{
            
            
            
            let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
            
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeControllerID") as UIViewController
            
            
            self.present(vc ,animated: true, completion: nil )
            
        }
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        logoutView.layer.borderWidth = 3.0;


        // Do any additional setup after loading the view.
        let isloggedUser  = UserDefaults.standard.bool(forKey: "isLoggedUser")
        if(isloggedUser == true){
            logoutbtn.isHidden = false
        }else{
            logoutbtn.isHidden = true
        }
        
        
        
        
        
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
