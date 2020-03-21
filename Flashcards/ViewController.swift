//
//  ViewController.swift
//  Flashcards
//
//  Created by Karina on 2/22/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String;
    var answer: String;
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
            
        if flashcards.count == 0{
            updateFlashcard(question: "Who wrote Digital Fortress", answer: "Dan Brown")
        } else {
            updateLabels()
            updateNextPrevButtons()
            
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden){
            frontLabel.isHidden = false
            backLabel.isHidden = true
        } else {
            frontLabel.isHidden = true
            backLabel.isHidden = false
        }

    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        
    }
    func updateFlashcard (question: String, answer: String){
        let flashcard = Flashcard(question : question, answer : answer)
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our next index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        //frontLabel.text = question
        //backLabel.text = answer
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        if currentIndex == flashcards.count + 1{
            prevButton.isEnabled = false
        } else{
            prevButton.isEnabled = true
        }
        
    }
    
    func updateLabels(){
        
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self 
    }
    
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer : dictionary["answer"]!)
            }
            flashcards.append(contentsOf:savedCards)
        }
}
}
    
  

