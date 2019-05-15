//
//  WordSearch.swift
//  Wordsearch
//
//  Created by Lucas McDonald on 2019-05-09.
//  Copyright © 2019 Lucas McDonald. All rights reserved.
//

import Foundation
class WordSearch{
    //recursive tree down
    var matrix = [[Character]]();
    public var trymatrix = [[Character]]();

    var words = [String]();
    var seed : String?
    var count: Int;
    var xRandom: [Int]?;
    var yRandom: [Int]?;
    
    init(Count:Int)
    {
        self.count = Count;
        
    }
    func addCapitalize(word:String)
    {
        
        words.append(word.uppercased());
    }
    func GenerateRandomMap()
    {
        //Swift, Kotlin, ObjectiveC, Variable, Java, Mobile.

        xRandom = randomArrayNoDuplicates();
        yRandom = randomArrayNoDuplicates();
        addCapitalize(word: "Java")
        addCapitalize(word: "Swift")
        addCapitalize(word: "Kotlin")
        addCapitalize(word: "ObjectiveC")
        addCapitalize(word: "Variable")
        addCapitalize(word: "Mobile")

        //words.append("Theoritcal")

        trymatrix = [[Character]](repeating: [Character](repeating: ">", count: count), count: count)

        trymatrix = recursiveWordCreation(currentWord: 0, currentMatrix: trymatrix)
    }
    
    
    var notFound = true;
    func recursiveWordCreation(currentWord:Int,currentMatrix:[[Character]]?) -> [[Character]]
    {

        if(currentMatrix == nil)
        {
           // print("Nil occured, at recuriveWordCreation")
            return [[]];
            
        }
        var curWord = "<";
            //print(curWord);
            if((currentWord > words.count-1))
            {
                
                return currentMatrix!
            }
            curWord = words[currentWord];

            var solutionMatrix = fit(currentWord: curWord,currentMatrix: currentMatrix!)
           // print("Solution Matrix for " + curWord + " is ")
        //print(solutionMatrix);
            
            if(currentMatrix?.count != 0)
            {
                for x in solutionMatrix{
                    return recursiveWordCreation(currentWord:currentWord+1,currentMatrix: x)
                }
            }
            return currentMatrix ?? [[]];
        
            
    }
    
    
    func randomArrayNoDuplicates() -> [Int]
    {
        //Fisher-Yates Shuffle Algorithm
        //https://learnappmaking.com/shuffling-array-swift-explained/
        var finalArray = [Int]()
        
        var counter = [Int]();
        for i in 0..<count
        {
            counter.append(i);
        }
            for _ in 0..<counter.count
            {
            let rand = Int(arc4random_uniform(UInt32(counter.count)))
                finalArray.append(counter[rand])
                counter.remove(at: rand)
            }
        return finalArray;
    }
    
    
    func fit(currentWord:String,currentMatrix:[[Character]]) -> [[[Character]]]
    {
        
        //returns a matrices of possible solution matrices
        var succesfulMatrixes = [[[Character]]]()
        //var xRandomList = [Int](repeating: Int.random(in: 0..<6), count: 6)
        //var yRandomList = [Int](repeating: Int.random(in: 0..<6), count: 6)
        for x in 0..<currentMatrix.count
        {
            for y in 0..<currentMatrix[x].count
            {
                var temp = offSetCheck(x: x,y: y,offX: 1,offY: 0,currentMatrix: currentMatrix,word: currentWord);
                if(temp != nil)
                {
                    succesfulMatrixes.append(temp!);
                }
                temp = offSetCheck(x: x,y: y,offX: 1,offY: 1,currentMatrix: currentMatrix,word: currentWord);
                if(temp != nil)
                {
                    succesfulMatrixes.append(temp!);
                }
                temp = offSetCheck(x: x,y: y,offX: 0,offY: 1,currentMatrix: currentMatrix,word: currentWord);
                if(temp != nil)
                {
                    succesfulMatrixes.append(temp!);
                }
                
            }
        }
        /*
        print("These are the succesful matrixes for: " + currentWord)
        print(succesfulMatrixes[0]);
        print(succesfulMatrixes.count);
 */
        return succesfulMatrixes;

        
        }
    
    
    
    func offSetCheck(x:Int,y:Int,offX:Int,offY:Int, currentMatrix:[[Character]], word:String) -> [[Character]]?
    {
        var newMatrix = currentMatrix;
        var i = 0;
        
        if(xRandom![x]+(offX*word.count) <= currentMatrix.count && yRandom![y]+(offY*word.count) <= currentMatrix[0].count ){
        for letter in word
            {
            
            let tempLetter = currentMatrix[xRandom![x]+offX*i][yRandom![y]+offY*i];

            
            if(tempLetter != letter && tempLetter != Character(">"))
            {
                print("Nill at:" + String(tempLetter));
                return nil;
            }
            newMatrix[xRandom![x]+offX*i][yRandom![y]+offY*i] = letter;
            i+=1;
            }
        }
    if(i == word.count)
    {
        return newMatrix;
    }
    return nil;
        
    
    }
}

