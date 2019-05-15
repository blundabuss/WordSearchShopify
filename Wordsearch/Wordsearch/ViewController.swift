//
//  ViewController.swift
//  Wordsearch
//
//  Created by Lucas McDonald on 2019-05-09.
//  Copyright © 2019 Lucas McDonald. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var screenRect:CGRect?
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    var cellWidth:CGFloat = 0.0
    var cellHeight:CGFloat = 0.0
    var count:Int = 10
    var currentGuess :[GuessVector] = [];
    var percentageOfSceenForTable:CGFloat = 0.55;
    var wordSearchArray: [[Character]] = []
    var currentWords : [String] = [];
    var guessString = "";
    var wrongCount = 0;
    var wordFoundColor = UIColor(red: 219/255, green: 21/255, blue: 30/255, alpha: 1.0);
    //DB151E
    @IBOutlet weak var wordOutlet1: UILabel!
    @IBOutlet weak var wordOutlet2: UILabel!
    @IBOutlet weak var wordOutlet3: UILabel!
    @IBOutlet weak var wordOutlet4: UILabel!
    @IBOutlet weak var wordOutlet5: UILabel!
    @IBOutlet weak var wordOutlet6: UILabel!
    var wordOutletArray:[UILabel]!
    
    @IBOutlet weak var winOutlet: UILabel!
    
    
    
    let array:[String] = []
    
    @IBOutlet weak var guessLabelOutlet: UILabel!
    
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 10,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenRect = view.frame;
        screenWidth = view?.frame.width ?? 0;
        screenHeight = view?.frame.height ?? 0;
        cellWidth = (screenWidth)/(CGFloat(count))
        cellHeight = (screenHeight)/(CGFloat(count))
        let wordAlgorithm = WordSearch(Count: count);
        wordAlgorithm.GenerateRandomMap();
        currentWords = wordAlgorithm.words;
        wordOutletArray = [];
        wordOutlet1.text = currentWords[0];
        wordOutlet2.text = currentWords[1];
        wordOutlet3.text = currentWords[2];
        wordOutlet4.text = currentWords[3];
        wordOutlet5.text = currentWords[4];
        wordOutlet6.text = currentWords[5];
        wordOutletArray.append(wordOutlet1);
        wordOutletArray.append(wordOutlet2);
        wordOutletArray.append(wordOutlet3);
        wordOutletArray.append(wordOutlet4);
        wordOutletArray.append(wordOutlet5);
        wordOutletArray.append(wordOutlet6);
        
        wordSearchArray = wordAlgorithm.trymatrix;
        fillEmptySpace()
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowOffset = .zero
        collectionView.layer.shadowRadius = 20
        collectionView.layer.shadowPath = UIBezierPath(rect: collectionView.bounds).cgPath
        collectionView.layer.shouldRasterize = true
        collectionView.layer.rasterizationScale = UIScreen.main.scale
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fillEmptySpace()
    {
        for x in 0..<wordSearchArray.count
        {
            for y in 0..<wordSearchArray[0].count{
            if(wordSearchArray[x][y]==Character(">"))
            {
                
                wordSearchArray[x][y] = Character(randomLetter())
                
            }
            }
        }
        
    }
    //credit for the random letter https://kevinvanderlugt.com/generating-a-random-letter-string-in-swift
    let uppercaseLetters = (65...90).map {String(UnicodeScalar($0))}
    func randomLetter() -> String {
        return uppercaseLetters.randomElement()!
    }
    
    
    
    func cellTouch(cell:WordCell) ->Bool
    {
        if(canGuess(guessVector: cell.guessVector!))
        {
            
            currentGuess.append(cell.guessVector!)
            guessString.append(cell.LetterOutlet.currentTitle!);
            guessLabelOutlet.text?=guessString;
            if(checkIfWord())
            {
                if(currentWords.count == 0)
                {
                win();
                }
            }
            return true;
        }
     //   print("returning false at CELLTOUCH");
        resetGuess(cell: cell);
        return false;
    }
    
    func checkIfWord() -> Bool
    {
        for i in 0..<currentWords.count
        {
            var temp = currentWords[i];
            if(temp  == guessString)
            {
                print("Removing " + temp);
                    self.wordOutletArray[i].textColor = self.wordFoundColor;
                wordOutletArray.remove(at: i)
                wordRemove(i: i);
                return true;
            }

  
        }

        return false
    }
    
    func resetGuess(cell:WordCell)
    {
        print("RESETING")

        for i in currentGuess
        {
            let indexPath = IndexPath(item: i.x, section: i.y);
            if let cell = self.collectionView.cellForItem(at: indexPath) as! WordCell?
            {
                cell.notSelected();
            }
        }
        cell.notSelected();
        guessLabelOutlet.text = ""
        guessString = "";
        currentGuess = [];
        
        wrongCount += 1;
     
    }
    
    
    
    
    func wordRemove(i:Int)
    {
        currentWords.remove(at:i);
        for i in currentGuess
        {
            let indexPath = IndexPath(item: i.x, section: i.y);
            if let cell = self.collectionView.cellForItem(at: indexPath) as! WordCell?
            {
                cell.foundWord();
            }
        }
        guessLabelOutlet.text = ""
        guessString = "";
        currentGuess = [];

    
    }
    func win()
    {
        print("Winner is player");
        winOutlet.isHidden = false;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WordCell
        let letter = String(wordSearchArray[indexPath.row][indexPath.section])
        cell.LetterOutlet.setTitle(letter, for: .normal)
        cell.viewController = self;
        let tempVector = GuessVector(x: indexPath.row, y: indexPath.section, letter: letter)
        cell.guessVector = tempVector
        return cell;
    }

  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    

    
    func canGuess(guessVector: GuessVector) -> Bool
    { //two three quick tests to make sure if letters touched are aligned

        var tempString = guessString + guessVector.letter;
        //CHECK if new letter is even a possible solution
        var contains = false;
        for i in 0..<currentWords.count
        {
            //print("does " + currentWords[i] + " contain " + tempString)
            if(currentWords[i].contains(tempString))
            {
                contains = true;
            }
        }
        if(contains == false)
        {
            return false;
        }
        
        
        if(currentGuess.count < 1)
        {
            //no need to check for if it follows the same offset if this is the first move
            print("returning true as count < 1")
            //if there are no guesses
            return true;
         }
       
        let offSet = guessVector.subtractVector(subtractor: currentGuess[currentGuess.count-1])
        print("The offset is");
        print(String(offSet.x) + "," + String(offSet.y))
        
        if(abs(offSet.x) < 2 && abs(offSet.y) < 2) //abs needed as negative offset expected
        {
            print("offset passes test 1");
            //if its within 1 block away
            if(currentGuess.count<3)
            {
                print("offset returns <2");

                return true;
            }
            else
            {

                if(currentGuess[currentGuess.count-2].CompareVectorOffsetTwice(add: offSet,compare: guessVector))
                {
                    return true;
                }
                else
                {
                    print("offset fail")
                }
   
            }
        }
        return false;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        // Credit to jhilgert00
        // https://stackoverflow.com/questions/14674986/uicollectionview-set-number-of-columns
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = CGFloat(0)
        
        let leftInset = CGFloat(0)
        let rightInset = CGFloat(0)
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
    }
    

}



