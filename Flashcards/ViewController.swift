//
//  ViewController.swift
//  Flashcards
//
//  Created by Martin Mihaylov on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
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
        frontLabel.text = question
        backLabel.text = answer
    }
    
    
}

