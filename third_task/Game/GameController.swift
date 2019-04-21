//
//  ViewController.swift
//  memory
//
//  Created by Рома Сумороков on 29/03/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class GameController: UIViewController{
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var cardDesk: UICollectionView!
    @IBOutlet weak var resultsButton: UIButton!
    var startTime = 0.0
	var tapsInGame = 0
	
    lazy var game = Memory(nubmerofPairsOfCards: (Int(cardDesk.frame.width / 80) * Int(cardDesk.frame.height / 110)) / 2)
	
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.layer.cornerRadius = 8.0
        resultsButton.layer.cornerRadius = 8.0
        cardDesk.alpha = 0
		Results.load()
    }
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
	}
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = false
	}
	
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func resultsButtonPressed(_ sender: Any) {
		let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
		if Results.results.isEmpty {
			page.tableData.append("No results, play something")
		}
		for res in Results.results {
			page.tableData.append("\(res.date)\nTaps: \(res.taps)\nTime Spend: \(res.timeSpend)" )
		}
		self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.resultsButton.alpha = 0
            self.playButton.alpha = 0
			self.cardDesk.alpha = 1.0
        })
		startTime = NSDate.timeIntervalSinceReferenceDate
    }
    
	func resetGame() {
		emo = ["🦇", "🐺", "🐢", "🐙", "🦄", "🐦", "🦕", "🐳", "🦚", "🦉"]
        emoji.removeAll()
		
		self.cardDesk.alpha = 0
		UIView.animate(withDuration: 0.8, animations: {
			self.resultsButton.alpha = 1.0
			self.playButton.alpha = 1.0
			self.view.layoutIfNeeded()
		})
		
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy hh:mm"
		let resultDate = formatter.string(from: date)
		
		Results.add(element: GameResult(taps: "\(tapsInGame)", date: resultDate, interval: (NSDate.timeIntervalSinceReferenceDate - startTime).stringFromTimeInterval()))
		
        game.reset()
        for card in 0..<cardDesk.numberOfItems(inSection: 0) {
			let indexPath = IndexPath(item: card, section: 0)
            let cell = cardDesk.cellForItem(at: indexPath) as! CollectionViewCell
			cell.title.text = emoji(for: game.cards[indexPath.item])
            cell.reset()
        }
    }
    
    func updateButtons() {
        for btn in 0..<cardDesk.numberOfItems(inSection: 0) {
            let button = cardDesk.cellForItem(at: IndexPath(item: btn, section: 0)) as! CollectionViewCell
            let card = game.cards[btn]
            
                if card.isMatched {
                    UIView.animate(withDuration: 0.8, animations: {
                        button.alpha = 0.0
                    })
                }
                
                if card.isFaceUp {
                    if button.title.isHidden  {
                        button.flip()
                    }
                } else {
                    if !button.title.isHidden {
                        button.flip()
                    }
                }
            
        }
    }
    
    var emo = ["🦇", "🐺", "🐢", "🐙", "🦄", "🐦", "🦕", "🐳", "🦚", "🦉"]
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emo.count > 0 {
            let randomIndex = Int.random(in: 0..<emo.count)
            emoji[card.id] = emo.remove(at: randomIndex)
        }
        return emoji[card.id] ?? "?"
    }
}

extension GameController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((Int(collectionView.frame.width / 80) * Int(collectionView.frame.height / 110)) / 2) * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.title.text = emoji(for: game.cards[indexPath.item])
        cell.layer.cornerRadius = 8.0
        return cell
    }
	
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		tapsInGame += 1
        game.chooseCard(at: indexPath.item)
		if game.checkScore() {
			self.resetGame()
		} else {
        	updateButtons()
		}
		
    }

}

extension TimeInterval{
	func stringFromTimeInterval() -> String {
		
		let time = NSInteger(self)
		
		let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
		let seconds = time % 60
		let minutes = (time / 60) % 60
		
		return String(format: "%0.2d:%0.2d,%0.2d",minutes,seconds,ms)
	}

}
