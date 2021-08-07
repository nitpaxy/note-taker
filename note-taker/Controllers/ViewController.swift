//
//  ViewController.swift
//  note-taker
//
//  Created by Nitesh  on 03/05/21.
//  Copyright © 2021 nitpa.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
//        createRecord()
        fetchEmp()
    }
    
    func createRecord() {
        let emp = Employee(context: PersistenceStorage.shared.context)
        emp.name = "Nitesh Patil"
        PersistenceStorage.shared.saveContext()
    }
    
    func fetchEmp() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path)
        
        do {
            guard let result = try PersistenceStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {
                return
            }
            result.forEach({debugPrint($0.name)})
        } catch let error {
            debugPrint(error)
        }
    }
}

