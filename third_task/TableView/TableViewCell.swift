//
//  TableViewCell.swift
//  third_task
//
//  Created by Рома Сумороков on 18/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func setup(with name: String) {
        label.text = name
    }
}
