//
//  ViewController.swift
//  Apple Pie
//
//  Created by Евгений Мелешков on 28.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program", "animals", "letters", "apple", "car", "cat"]
    let incorrectMovesAllowed = 7
    
    var currentGame: Game!
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var playerOneScore = 0
    var playerTwoScore = 0
    
       
    
    var state : Game.State = .playerOne {
        didSet {
            switch state {
            case .playerOne:
                playerOnePlays()
            case .playerTwo:
                playerTwoPlays()
            }
        }
    }
    

    
                @IBOutlet var scoringFeature:  UILabel!
                @IBOutlet var treeImageView: UIImageView!
    
                @IBOutlet var correctWordLabel: UILabel!

                @IBOutlet var scoreLabel: UILabel!
    
                @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    
    func playerOnePlays() {
        treeImageView.backgroundColor = #colorLiteral(red: 0.02918706462, green: 0.5688982606, blue: 1, alpha: 1)
        newRound()
    }
    
    func playerTwoPlays() {
        treeImageView.backgroundColor = #colorLiteral(red: 1, green: 0.6650813222, blue: 0.7805501819, alpha: 1)
        newRound()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
        func newRound() {
            if !listOfWords.isEmpty {
                let newWord = listOfWords.removeFirst()
                currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                enableLetterButtons(true)
                updateUI()
            } else {
                enableLetterButtons(false)
            }
        }
        
        func updateUI() {
            scoringFeature.text = "Player One Score: \(playerOneScore) | Player Two Score: \(playerTwoScore)"
            let letters = currentGame.formatedWord.map {String($0)}
            let wordWithSpacing = letters.joined(separator: " ")
            correctWordLabel.text = wordWithSpacing
            scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        }
        
        func updateGameState() {
            if currentGame.incorrectMovesRemaining == 0 {
                totalLosses += 1
                state = .playerTwo
                if totalLosses % 2 == 0 {
                    state = .playerOne
                }
            } else if currentGame.word == currentGame.formatedWord {
                totalWins += 1
            } else {
                updateUI()
            }
        }
    
                @IBAction func letterButtonPressed(_ sender: UIButton) {
                            sender.isEnabled = false
                            let letterString = sender.title(for: .normal)!
                            let letter = Character(letterString.lowercased())
                            currentGame.playerGuessed(letter: letter)
                    if currentGame.word == currentGame.formatedWord && state == .playerOne {
                        playerOneScore += 5
                    } else if currentGame.word.contains(letter) && state == .playerOne {
                        playerOneScore += 1
                    }
                    
                    if currentGame.word == currentGame.formatedWord && state == .playerTwo {
                        playerTwoScore += 5
                    } else if currentGame.word.contains(letter) && state == .playerTwo {
                        playerTwoScore += 1
                    }
                            updateGameState()
                        }
    
}

