//
//  CDEmployee+CoreDataProperties.swift
//  note-taker
//
//  Created by Nitesh  on 07/08/21.
//  Copyright © 2021 nitpa.org. All rights reserved.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profilePic: Data?

}

extension CDEmployee : Identifiable {
    
    func convertToEmplyoee() -> Employee {
        return Employee(email: self.email!, name: self.name!, id: self.id!, profilePic: self.profilePic!)
    }
}
