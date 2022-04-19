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
    func update(employee: Employee) -> Bool
    func delete(employee: Employee) -> Bool
    
}

// Employee Entitiy Data Repository Layer
struct EmplyoeeDataRepository: EmplyoeeRepository {
    
    // Create record in for Emplyoee Entity.
    func create(employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistenceStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.profilePic = employee.profilePic
        
        /// saves to data base as there is a change
        PersistenceStorage.shared.saveContext()
    }
    
    // Fetches record for Emplyoee Entity.
    func fetchAll() -> [Employee]? {
        let result = PersistenceStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
        
        var emplyoees: [Employee] = []
        result?.forEach({ cdEmployee in
            emplyoees.append(cdEmployee.convertToEmplyoee())
        })
        return emplyoees
    }
    
    // Fetches record for one Emplyoee.
    func fetch(byIdentifier id: UUID) -> Employee? {
        
        let result = getCDEmployee(byId: id)
        guard result != nil else { return nil }
        return result?.convertToEmplyoee()
    }
    
    // Updates record for one Emplyoee.
    func update(employee: Employee) -> Bool {
        let cdEmloyee = getCDEmployee(byId: employee.id)
        guard cdEmloyee != nil else { return false }
        cdEmloyee?.email = employee.email
        cdEmloyee?.name = employee.name
        cdEmloyee?.profilePic = employee.profilePic
        
        PersistenceStorage.shared.saveContext()
        return true
    }
    
    // Deletes record for one Emplyoee.
    func delete(employee: Employee) -> Bool {
        let cdEmloyee = getCDEmployee(byId: employee.id)
        guard cdEmloyee != nil else { return false }
        
        PersistenceStorage.shared.context.delete(cdEmloyee!)
        return true
    }
    
    private func getCDEmployee(byId id: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id=%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistenceStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
