//
//  ViewController.swift
//  Flashcards
//
//  Created by Martin Mihaylov on 2/20/21.
//

import UIKit


struct Flashcard {
    var question: String
    var answer: String
}



class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the powerhouse of the cell?", answer: "The Mitochondria")
        }
        
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
   
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()

    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if frontLabel.isHidden == true
        {frontLabel.isHidden = false}
        
        else if frontLabel.isHidden == false
        {frontLabel.isHidden = true}
            
    }
    
    func updateFlashcard(question : String, answer: String){
        
        let flashcard = Flashcard(question: question, answer: answer)
       
        flashcards.append(flashcard)
        
        print("Added new flashcard :)")
        print("We now have \(flashcards.count) flashcards :)")
        
        currentIndex = flashcards.count - 1
        
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }
        
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        }
        
        else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
        
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.setValue(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
 
}
