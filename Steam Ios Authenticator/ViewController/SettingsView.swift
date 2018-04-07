//
//  SettingsView.swift
//  Steam Ios Authenticator
//
//  Created by Ислам Киясов on 21.03.2018.
//  Copyright © 2018 Ислам Киясов. All rights reserved.
//

import UIKit

class SettingsView: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var accountsListButton: UIButton!
    
    @IBOutlet weak var resetDataButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBAction func resetDataButton(_ sender: Any) {
        if Account.cleanAccounts() {
            let alert = UIAlertController(title: "Успешно!", message: "Данные сброшены!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            createAccountButton.isEnabled = true
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
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
            accountsListButton.isEnabled = false
            createAccountButton.isEnabled = false
            resetDataButton.isHidden = false
        } else {
            resetDataButton.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
