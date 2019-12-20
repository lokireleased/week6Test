//
//  MainTableViewController.swift
//  week6TestTake2
//
//  Created by tyson ericksen on 12/20/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

  override func viewDidLoad() {
        super.viewDidLoad()

        PersonController.shared.fetchResultsController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
          let alertController = UIAlertController(title: "Add Person", message: "Whom do you want to randomize?", preferredStyle: .alert)
          let addButtonAction = UIAlertAction(title: "Add Person", style: .default) { (action) in
              guard let newPerson = alertController.textFields?[0].text else { return }
              PersonController.shared.createPerson(name: newPerson)
          }
          let cancelButtonAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
          alertController.addTextField { (_) in }
          alertController.addAction(addButtonAction)
          alertController.addAction(cancelButtonAction)
          self.present(alertController, animated: true)
    }
    
    
    @IBAction func randomizeButtonTapped(_ sender: UIBarButtonItem) {
        
        
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        let person = PersonController.shared.groups[indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.groups[indexPath.row]
            PersonController.shared.deletePerson(person: person)
        }
    }
}

extension MainTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
            case .insert:
            tableView.insertSections(indexSet, with: .fade)
            case .delete:
            tableView.deleteSections(indexSet, with: .fade)
            default:
            return
        }
    }
    
    func controller(_controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
                switch type {
                case .insert:
                    guard let newIndexPath = newIndexPath
                        else { return }
                    tableView.insertRows(at: [newIndexPath], with: .fade)
                case .delete:
                    guard let indexPath = indexPath
                        else { return }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .update:
                    guard let indexPath = indexPath
                        else { return }
                    tableView.reloadRows(at: [indexPath], with: .none)
                case .move:
                    guard let indexPath = indexPath, let newIndexPath = newIndexPath
                        else { return }
                    tableView.moveRow(at: indexPath, to: newIndexPath)
                @unknown default:
                    fatalError("NSFetchedResultsChangeType has new unhandled cases")
                }
        }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
