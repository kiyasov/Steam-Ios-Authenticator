//
//  CoreDataManager.swift
//  ProjectManager
//
//  Created by Ислам on 26.01.2018.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
}









