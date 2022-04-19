//
//  PersistenceStorage.swift
//  note-taker
//
//  Created by Nitesh  on 03/08/21.
//  Copyright © 2021 nitpa.org. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceStorage {
    
    private init() {}
    static let shared = PersistenceStorage()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "note_taker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var  context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        
        do {
            guard let result = try PersistenceStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
