//
//  TableViewController.swift
//  third_task
//
//  Created by Рома Сумороков on 18/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tableData.isEmpty {
            for _ in 0..<100 {
                tableData.append("\(Int.random(in: 0..<50))")
            }
        }
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self as UITableViewDelegate
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension TableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.setup(with: tableData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let second = SecondViewController.instance() as? SecondViewController {
            second.text = tableData[indexPath.row]
            navigationController?.pushViewController(second, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
