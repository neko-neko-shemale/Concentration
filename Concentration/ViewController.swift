//
//  ViewController.swift
//  Concentration
//
//  Created by Justin Dell Adam on 1/15/18.
//  Copyright © 2018 Li Xin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numbersOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var scoreCount = 0{
        didSet{
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func setNewGame(_ sender: UIButton) {
        game = Concentration(numbersOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = emojiThemes[randomTheme]!
        updateViewFromModel()
        flipCount = 0
        scoreCount = 0
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            scoreCount = game.score
            flipCount = game.flips
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiThemes = ["halloween" : ["🦇","😱","🙀","👿","🎃","👻","🍭","🍬","🍎","🌑"],
                       "animals" : ["🐶","🐱","🐼","🐰","🐻","🐯","🐵","🦆","🦋","🐿"],
                       "sports" : ["⚽️","🏀","🏈","⚾️","🎾","🏸","🥊","🏄🏼‍♂️","🚴‍♀️","🏊🏽‍♂️"],
                       "food" : ["🍇","🍓","🍌","🌽","🍔","🍟","🍝","🍩","🍫","🍿"],
                       "space" : ["🚀","🛰","🛸","🌑","🌕","🌎","☄️","🌌","📡","🔭"],
                       "entertainments" : ["🎥","💸","🌋","🗽","🗿","🗺","🏝","🚠","🎮","🎬"]]
    
    lazy var emojiKeys = Array(emojiThemes.keys)
    
    lazy var emojiChoices = emojiThemes[randomTheme]!
    
    var randomTheme : String{
        get{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiKeys.count)))
            return emojiKeys[randomIndex]
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

