//
//  ViewController.swift
//  text
//
//  Created by Tesiro on 16/11/13.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds seconds: Double, completion: ()->()) {
//    let popTime = dispatch_time(DISPATCH_TIME_NOW , Int64( Double(NSEC_PER_SEC) * seconds ))
//    
//    dispatch_after(popTime, DispatchQueue.main) {
//        completion()
//    }
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
    let status = UIImageView(image: UIImage(named : "banner"))
    let label = UILabel()
    let messages = ["connecting...", "authorizing...", "Sending credentials...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x -= view.bounds.width;
        username.center.x -= view.bounds.width;
        password.center.x -= view.bounds.width;
        
        loginButton.center.y += 30
        loginButton.alpha = 0.0
        
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
        
       
        UIView.animate(withDuration: 3.5, delay: 0.4, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [], animations: {
            () -> Void in
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1.0
        }, completion: nil)
        
        self.animateCloud(cloud: cloud1)
        self.animateCloud(cloud: cloud2)
        self.animateCloud(cloud: cloud3)
        self.animateCloud(cloud: cloud4)
        
    }
    
    func showMesage(index index : Int) -> () {
        label.text = messages[index]
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut,.transitionCurlDown], animations: {() -> Void in
            self.status.isHidden = false
        }, completion: {
            (_) -> Void in
           //变形动画完成后执行的操作
            if index < self.messages.count - 1 {
                self.removeMessage(index: index)
                
            }else {
                self.resetForm()
            }
            
        })
    }
    
    func removeMessage(index index: Int){
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
        }) { (_) -> Void in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMesage(index: index + 1)
        }
    }
    
    func resetForm() {
        UIView.transition(with: status, duration: 0.2, options: .transitionCurlUp, animations: {
            self.status.isHidden = true
            self.status.center = self.statusPosition
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
        }, completion: nil)
    }
    func animateCloud(cloud: UIImageView) {
        let cloudSpeed = 45.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }, completion: {_ in
            cloud.frame.origin.x = -cloud.frame.size.width
            self.animateCloud(cloud: cloud)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20, height: 20)
        spinner.startAnimating()
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
        
        statusPosition = status.center
        
    }
    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [], animations: {
            () -> Void in
            self.loginButton.bounds.size.width += 80
        }, completion: {
            _ in
            self.showMesage(index: 0)
        })
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            () -> Void in
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85 ,green : 0.83,blue:0.45,alpha: 1.0);
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
            self.spinner.alpha = 1.0
        }, completion: nil)
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

