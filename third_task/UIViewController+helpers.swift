//
//  UIViewController+helpers.swift
//  third_task
//
//  Created by Рома Сумороков on 18/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instance() -> UIViewController {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController
    }
}
