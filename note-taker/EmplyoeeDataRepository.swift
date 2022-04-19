//
//  EmplyoeeDataRepository.swift
//  note-taker
//
//  Created by Nitesh  on 07/08/21.
//  Copyright © 2021 nitpa.org. All rights reserved.
//

import Foundation
import CoreData

protocol EmplyoeeRepository {
    func create(employee: Employee)
    func fetchAll() -> [Employee]?
    func fetch(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee)
    func delete(employee: Employee)
    
}

struct EmplyoeeDataRepository: EmplyoeeRepository {
    
    
    func create(employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistenceStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.profilePic = employee.profilePic
        
        /// saves to data base as there is a change
        PersistenceStorage.shared.saveContext()
    }
    
    func fetchAll() -> [Employee]? {
        let result = PersistenceStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
        
        var emplyoees: [Employee] = []
        result?.forEach({ cdEmployee in
            emplyoees.append(cdEmployee.convertToEmplyoee())
        })
        return emplyoees
    }
    
    func fetch(byIdentifier id: UUID) -> Employee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id=%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistenceStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            
            return result?.convertToEmplyoee()
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func update(employee: Employee) {
        
    }
    
    func delete(employee: Employee) {
        
    }    
}
