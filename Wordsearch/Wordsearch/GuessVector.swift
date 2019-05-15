//
//  GuessVector.swift
//  Wordsearch
//
//  Created by Lucas McDonald on 2019-05-15.
//  Copyright © 2019 Lucas McDonald. All rights reserved.
//

import Foundation
class GuessVector{
    //class used to compare vectors and store information concerning the spot in question for easy access
    
    var x:Int;
    var y:Int;
    let letter: String;
    init(x:Int,y:Int,letter:String)
    {
        self.x = x;
        self.y = y;
        self.letter = letter;
    }
    func subtractVector(subtractor:GuessVector) -> GuessVector
    {//used to generate offset and direction, returns a direction vector (no string)
        let resultX = x - subtractor.x;
        let resultY = y - subtractor.y;
        return GuessVector(x: resultX, y: resultY, letter: "")
    }
    
    
    func CompareVectorOffsetTwice(add:GuessVector,compare:GuessVector) -> Bool
    {  //if the rate of change is the same (check two blocks back to ensure they arent changing direction)
        
        
        print("xCOMPARING " + String(compare.x) + " TO " + String(add.x*2))
        if(compare.x == x + add.x*2)
        {
            print("yCOMPARING " + String(compare.y) + " TO " + String(add.y*2))
            
            if(compare.y == y + add.y*2)
            {
                return true;
            }
        }
        return false;
    }
    
    
}
