//
//  Person+Convience.swift
//  week6TestTake2
//
//  Created by tyson ericksen on 12/20/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStorage.managedObjectContext) {
        self.init(context: context)
        self.name = name
        
    }
}
