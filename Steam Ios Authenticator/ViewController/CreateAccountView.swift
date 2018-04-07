//
//  CreateAccountView.swift
//  Steam Ios Authenticator
//
//  Created by Ислам Киясов on 21.03.2018.
//  Copyright © 2018 Ислам Киясов. All rights reserved.
//

import UIKit
import CoreData

class CreateAccountView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var accountNameField: TextFiled!
    
    @IBOutlet weak var passwordField: TextFiled!
    
    @IBOutlet weak var sharedSecretField: TextFiled!
    
    @IBOutlet weak var identitySecretField: TextFiled!
    
    @IBOutlet weak var steamId: TextFiled!
    
    @IBAction func tap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        if(accountNameField.text!.count < 3 || passwordField.text!.count < 5 || sharedSecretField.text!.count < 5 || identitySecretField.text!.count < 5 || steamId.text!.count < 5)  {
            let alert = UIAlertController(title: "Ошибка!", message: "Заполните поля!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            return self.present(alert, animated: true, completion: nil);
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        request.predicate = NSPredicate(format: "steamId == %@", steamId.text!)
        
        do {
            let data = try context.fetch(request);
            
            if(data.count > 0) {
                let alert = UIAlertController(title: "Ошибка!", message: "Вы уже добавляли этот аккаунт!", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                clearTextField()
            } else {
                if Account.create(data: [
                    "accountName" : accountNameField.text!,
                    "password" : passwordField.text!,
                    "sharedSecret" : sharedSecretField.text!,
                    "identitySecret" : identitySecretField.text!,
                    "steamId" : steamId.text!
                    ]) {
                    
                    let alert = UIAlertController(title: "Успешно!", message: "Аккаунт добавлен!", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    clearTextField()
                }
            }
            
        } catch {
            print("error")
        }
        
    }
    
    func clearTextField(){
        accountNameField.text = ""
        passwordField.text = ""
        sharedSecretField.text = ""
        identitySecretField.text = ""
        steamId.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
