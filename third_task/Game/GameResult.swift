//
//  GameResult.swift
//  third_task
//
//  Created by Рома Сумороков on 19/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import Foundation

class GameResult: NSObject, NSCoding {
    var taps: String
    var date: String
    var timeSpend: String
    
    init(taps: String, date: String, interval: String) {
        self.taps = taps
        self.date = date
        self.timeSpend = interval
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.taps, forKey: "taps")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.timeSpend, forKey: "timeSpend")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.taps = aDecoder.decodeObject(forKey: "taps") as? String ?? ""
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        self.timeSpend = aDecoder.decodeObject(forKey: "timeSpend") as? String ?? ""
    }
}
