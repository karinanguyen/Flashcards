//
//  ViewController.swift
//  Flashcards
//
//  Created by Karina on 2/22/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    func updateFlashcard (question: String, answer: String){
        
        frontLabel.text = question
        backLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self 
    }
}

