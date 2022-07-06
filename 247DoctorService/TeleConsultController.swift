//
//  TeliConsultController.swift
//  247DoctorService
//
//  Created by NEIL UDUKALA on 18/12/2016.
//  Copyright (c) 2016 247 Doctor Service. All rights reserved.
//

import UIKit

class TeleConsultController: UIViewController {
    //@IBOutlet var teleView: UIView!
    @IBOutlet var teleView: UIView!
    @IBOutlet weak var telescrol: UIScrollView!
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
        telescrol.contentSize = CGSize(width: 200, height: 620)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teleView.layer.borderColor = UIColor(red:7/255.0, green:135/255.0, blue:84/255.0, alpha: 1.0).cgColor
        
        teleView.layer.borderWidth = 3.0;


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
