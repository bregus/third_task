//
//  CollectionViewCell.swift
//  memory
//
//  Created by Рома Сумороков on 04/04/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cardBack: UIImageView!
    
    func flip() {
        title.isHidden = !title.isHidden
        cardBack.isHidden = !cardBack.isHidden
        UIView.transition(with: self, duration: 0.4, options: .transitionFlipFromRight, animations: nil,  completion: nil)
    }
    
    func reset() {
        self.alpha = 1.0
        cardBack.isHidden = false
        title.isHidden = true
    }
}
