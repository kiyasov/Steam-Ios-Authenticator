//
//  ViewController.swift
//  Steam Ios Authenticator
//
//  Created by Ислам Киясов on 20.03.2018.
//  Copyright © 2018 Ислам Киясов. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var accountNameTextView: UITextView!
    
    var sharerSecret = String()
    var timer = Timer()
    
    @IBOutlet weak var clipboardButton: UIButton!
    
    @IBOutlet weak var codeTextView: UITextView!
    
    @IBAction func clipboardButton(_ sender: Any) {
        UIPasteboard.general.string = codeTextView.text
        
        let alert = UIAlertController(title: "Успешно!", message: "Код скопирован в буфер.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
           initStart ()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
        initStart();
    }
    
    func initStart () {
        let data = Account.getAll()
        
        if(data!.count > 0) {
            self.sharerSecret = data![0].sharedSecret!
            accountNameTextView.text = data![0].accountName!;
            
            if !self.timer.isValid {
                self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(getAuthCode), userInfo: nil, repeats: true)
                getAuthCode();
            }
        } else {
            if self.timer.isValid {
                self.timer.invalidate()
            }
            
            clipboardButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func getAuthCode()
    {
        let code = SteamTotp.getAuthCode(shared_secret: self.sharerSecret, time_offset: 0)
        codeTextView.text = code;
    }
    
    
}

