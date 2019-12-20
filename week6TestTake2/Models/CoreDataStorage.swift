//
//  CoreDataStorage.swift
//  week6TestTake2
//
//  Created by tyson ericksen on 12/20/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import Foundation
import CoreData


enum CoreDataStorage {

    static let container: NSPersistentContainer = {
        let appName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("error in creating container", error.localizedDescription)
            }
        }
        return container
    }()
    
    static var managedObjectContext: NSManagedObjectContext { return container.viewContext }
}
