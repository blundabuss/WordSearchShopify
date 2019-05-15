//
//  WordCell.swift
//  Wordsearch
//
//  Created by Lucas McDonald on 2019-05-12.
//  Copyright © 2019 Lucas McDonald. All rights reserved.
//

import UIKit

class WordCell: UICollectionViewCell {
    weak var viewController : ViewController?
   // var guessVector:GuessVector?
    var selectedColor = UIColor.black;
    var normalColor = UIColor.white;
    var sucessColor = UIColor(red: 217/255, green: 208/255, blue: 43/255, alpha: 1)
    var guessVector:GuessVector?;
    
    @IBOutlet weak var LetterOutlet: UIButton!

    @IBAction func touchUp(_ sender: Any) {
        if((viewController?.cellTouch(cell: self))!)
       {
        print("attempting to set " + (guessVector?.letter)! + " on")
        if(self.LetterOutlet.titleColor(for: .normal) != sucessColor){

        LetterOutlet.setTitleColor(self.selectedColor, for: .normal)
        }
       }
    }

    func notSelected()
    {//need to set on main thread, UI updates all need to be mainthread
        print("attempting to set " + (guessVector?.letter)! + " off")
        if(self.LetterOutlet.titleColor(for: .normal) != sucessColor){
            self.LetterOutlet.setTitleColor(self.normalColor, for: .normal)
        }
    }
    func foundWord()
    {//need to set on main thread, UI updates all need to be mainthread
        print("attempting to set " + (guessVector?.letter)! + " sucess")
        self.LetterOutlet.setTitleColor(self.sucessColor, for: .normal)
        
    }
}
