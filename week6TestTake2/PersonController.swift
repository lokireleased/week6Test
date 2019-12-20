//
//  PersonController.swift
//  week6TestTake2
//
//  Created by tyson ericksen on 12/20/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import Foundation
import CoreData

class PersonController {


    
    static let shared = PersonController()

    var groups: [Person] {
        do {
            try fetchResultsController.performFetch()
            guard let groups = fetchResultsController.fetchedObjects else { return [] }
            return groups
            } catch {
                print("Error in retrieving information", error.localizedDescription)
                return []
            }
        }

    var fetchResultsController: NSFetchedResultsController<Person> = {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let titleSortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [titleSortDescription]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStorage.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }()

    func createPerson(name: String) {
        _ = Person(name: name)
        savePerson()
    }

    func deletePerson(person: Person) {
        CoreDataStorage.managedObjectContext.delete(person)
        savePerson()
    }

//    func createGroup() {
//        for person in groups {
//            let person1
//
//        }
//    }

    func savePerson() {
        do {
            try CoreDataStorage.managedObjectContext.save()
        } catch {
            print("error in saving information", error.localizedDescription)
        }
    }





//    func createGroup(name1: String, name2: String) {
//        let newGroup
//    }
}
