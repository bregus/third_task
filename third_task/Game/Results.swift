//
//  Results.swift
//  third_task
//
//  Created by Рома Сумороков on 20/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import Foundation

class Results {
    static var results = [GameResult]()
    
    static func add(element: GameResult) {
        self.results.insert(element, at: 0)
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: results, requiringSecureCoding: false )
            UserDefaults.standard.set(encodedData, forKey: "results")
        } catch {
            
        }
    }
    
    static func load() {
//        let dictionary = UserDefaults.standard.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            UserDefaults.standard.removeObject(forKey: key)
//        }
//        UserDefaults.standard.synchronize()
//        return
        if let decoded  = UserDefaults.standard.data(forKey: "results") {
            do {
                let decodedTeams = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [GameResult]
                results = decodedTeams!
            } catch {
                
            }
        }
    }
}
