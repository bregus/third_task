//
//  SecondViewController.swift
//  forth
//
//  Created by Рома Сумороков on 12/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text ?? "Nothing"
        //label.transform = CGAffineTransform(rotationAngle: .pi / 2.0 + .pi)
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
