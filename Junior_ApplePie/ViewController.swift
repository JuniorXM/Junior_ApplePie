//
//  ViewController.swift
//  Junior_ApplePie
//
//  Created by Junior Morocho on 3/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var listOfWords = ["bob","chicken","jose", "math", "soccer", "program"]
    let lives = 7
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
    @IBOutlet var letterButtons: [UIButton]!
    var currentGame: Game!
    @IBAction func ButtonPressed(_ sender: UIButton) {
           sender.isEnabled = false
           let letterString = sender.title(for: .normal)!
           let letter = Character(letterString.lowercased())
           currentGame.playerGuessed(letter: letter)
          
           updateGameState()
       }
    func enableLetterButtons(_enable:Bool){
        for button in letterButtons{
            button.isEnabled = _enable
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    func newRound(){
        if  !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, movesRemaining: lives, guessedLetters: [])
            enableLetterButtons(_enable:true)
             updateUI()
        }
        else{
            enableLetterButtons(_enable:false)
        }
    }
    
   
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        

        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        imageView.image = UIImage(named: "Tree \(currentGame.movesRemaining)")
        
    }
    func updateGameState() {
        if currentGame.movesRemaining == 0 {
        totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
        totalWins += 1
        }
        else {
        updateUI()
        }

    }


}

