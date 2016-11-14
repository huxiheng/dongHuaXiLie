//
//  ViewController.swift
//  text
//
//  Created by Tesiro on 16/11/13.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

import UIKit

func delay( seconds : Double, completion:()->()){
    //DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds)

    
}

class ViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named : "cape_front"))
    let label = UILabel()
    let messages = ["connecting...", "authorizing...", "Sending credentials...", "Failed"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x -= view.bounds.width;
        username.center.x -= view.bounds.width;
        password.center.x -= view.bounds.width;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            () -> Void in
            self.heading.center.x += self.view.bounds.width;
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            () -> Void in
            self.username.center.x += self.view.bounds.width
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.curveEaseInOut], animations: {
            () -> Void in
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20, height: 20)
        spinner.stopAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaName", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        
    }
    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField == username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

