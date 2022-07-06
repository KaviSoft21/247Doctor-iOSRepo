//
//  ViewController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 30/11/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollViewL: UIScrollView!
    
    @IBOutlet var homeView: UIView!
    
    @IBOutlet weak var callNowbtn: UIButton!
   
    
    @IBOutlet weak var callBackbtn: UIButton!
    
    @IBOutlet weak var bookNowbtn: UIButton!
    
    @IBOutlet weak var telebtn: UIButton!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBOutlet weak var regbtn: UIButton!
    
    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var bulklbl: UILabel!
    
    @IBOutlet weak var visitlbl: UILabel!
    
    
    @IBOutlet weak var carImg: UIImageView!
    
    @IBOutlet weak var urlbtn: UIButton!
    
    
    @IBOutlet weak var calllbl: UILabel!

    
    @IBAction func openSite(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://www.247doctor.com.au")! as URL)

    }
    
    @IBAction func callNow(_ sender: Any) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(1800247477)"){
            let application:UIApplication = UIApplication.shared
            if(application.canOpenURL(phoneCallURL as URL)){
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
     
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollViewL.contentSize = CGSize(width: 200, height: 620)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    scrollViewL.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
       // scrollViewL.layer.borderColor = UIColor.green.cgColor
      //  scrollViewL.layer.borderWidth = 2.0;
        
    homeView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
       
        homeView.layer.borderWidth = 3.0;

        
        
       
      //  urlbtn.addTarget(self, action: "openSite", for: .touchUpInside)
        
        
        
      //  callNowbtn.backgroundColor = UIColor.redColor()
        // Do any additional setup after loading the view, typically from a nib.
        
    /*    let screenSize:  CGRect =  UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight =  screenSize.height
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRectMake(0, 120, screenWidth, screenHeight));
        scrollView.contentSize = CGSizeMake(screenWidth, 1500)
        
        scrollView.addSubview(logoImg)
        scrollView.addSubview(bulklbl)
        scrollView.addSubview(visitlbl)
        scrollView.addSubview(callNowbtn)
        scrollView.addSubview(callBackbtn)
        scrollView.addSubview(bookNowbtn)
        scrollView.addSubview(telebtn)
        scrollView.addSubview(loginbtn)
        scrollView.addSubview(regbtn)
        scrollView.addSubview(carImg)
        scrollView.addSubview(urllbl)
        scrollView.addSubview(calllbl)
        
        view.addSubview(scrollView)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

