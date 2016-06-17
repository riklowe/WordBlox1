//
//  Helper.swift
//  NSTimerTest
//
//  Created by Richard Lowe on 16/02/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

import Foundation
import UIKit

/*============================================================*/
/*============================================================*/
/*============================================================*/

func RandomInt(_ min: Int, max: Int) -> Int {
    if max < min { return min }
    return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}

func RandomFloat() -> Float {
    return Float(arc4random()) /  Float(UInt32.max)
}

func RandomFloat(_ min: Float, max: Float) -> Float {
    return (Float(arc4random()) / Float(UInt32.max)) * (max - min) + min
}

func RandomDouble(_ min: Double, max: Double) -> Double {
    return (Double(arc4random()) / Double(UInt32.max)) * (max - min) + min
}

func RandomCGFloat() -> CGFloat {
    return CGFloat(RandomFloat())
}

func RandomCGFloat(_ min: Float, max: Float) -> CGFloat {
    return CGFloat(RandomFloat(min, max: max))
}

func RandomColor() -> UIColor {
    return UIColor(red: RandomCGFloat(), green: RandomCGFloat(), blue: RandomCGFloat(), alpha: 1)
}

func RandomFixedColor() -> UIColor {
    
    var pickCol = UIColor.white()
    
    let randCol = RandomInt(1, max: 7)
    switch randCol {
    case 1 :
        pickCol = UIColor.red()
    case 2 :
        pickCol = UIColor.gray()
    case 3 :
        pickCol = UIColor.green()
    case 4 :
        pickCol = UIColor.yellow()
    case 5 :
        pickCol = UIColor.blue()
    case 6 :
        pickCol = UIColor.purple()
    case 7 :
        pickCol = UIColor.cyan()
    case 8 :
        pickCol = UIColor.magenta()
    case 9 :
        pickCol = UIColor.orange()
    case 10 :
        pickCol = UIColor.brown()
    default:
        break
    }
    return UIColor(cgColor: pickCol.cgColor)
}

func RandomLetter() -> String {
    let uppercaseLetters = Array(65...90).map {String(UnicodeScalar($0))}
    let randomIndex = arc4random_uniform(UInt32(uppercaseLetters.count))
    return uppercaseLetters[Int(randomIndex)]
}

func AlphabetByIndex(_ value: Int) -> String {
    let uppercaseLetters = Array(65...90).map {String(UnicodeScalar($0))}
    return uppercaseLetters[Int(value)]
}

func randomAlphaNumericString(_ length: Int) -> String {
    
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    for _ in (0..<length) {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let newCharacter = allowedChars[allowedChars.characters.index(allowedChars.startIndex, offsetBy: randomNum)]
        randomString += String(newCharacter)
    }
    
    return randomString
}

func randomVowel() -> String {
    
    let allowedChars = "AEIOUY"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    let randomNum = Int(arc4random_uniform(allowedCharsCount))
    let newCharacter = allowedChars[allowedChars.characters.index(allowedChars.startIndex, offsetBy: randomNum)]
    randomString += String(newCharacter)
    
    return randomString
}

func randomNonVowel() -> String {
    
    let allowedChars = "BCDFGHJKLMNPQRSTVWXZ"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    let randomNum = Int(arc4random_uniform(allowedCharsCount))
    var newCharacter = String(allowedChars[allowedChars.characters.index(allowedChars.startIndex, offsetBy: randomNum)])
    
    if newCharacter == "Q" {
        newCharacter = "Qu"
    }
    randomString += newCharacter
    
    return randomString
}

func randomScrabbleLetters() -> String {
    /*
    Scrabble Letters
    4 blank tiles (scoring 0 points)
    1 point:  E ×24, A ×16, O ×15, T ×15, I ×13, N ×13, R ×13, S ×10, L ×7, U ×7
    2 points: D ×8, G ×5
    3 points: C ×6, M ×6, B ×4, P ×4
    4 points: H ×5, F ×4, W ×4, Y ×4, V ×3
    5 points: K ×2
    8 points: J ×2, X ×2
    10 points: Q ×2, Z ×2
    
    A	16	1	8%
    B	4	3	2%
    C	6	3	3%
    D	8	2	4%
    E	24	1	12%
    F	4	4	2%
    G	5	2	3%
    H	5	4	3%
    I	13	1	7%
    J	2	8	1%
    K	2	5	1%
    L	7	1	4%
    M	6	3	3%
    N	13	1	7%
    O	15	1	8%
    P	4	3	2%
    Q	2	10	1%
    R	13	1	7%
    S	10	1	5%
    T	15	1	8%
    U	7	1	4%
    V	3	4	2%
    W	4	4	2%
    X	2	8	1%
    Y	4	4	2%
    Z	2	10	1%
    Tot 196		1.000
    
    */
    
    var allowedChars = "AAAAAAAAAAAAAAAABBBBCCCCCCDDDDDDDDEEEEEEEEEEEEEEEEEEEEEEEE"
    allowedChars = allowedChars + "FFFFGGGGGHHHHHIIIIIIIIIIIIIJJKK"
    allowedChars = allowedChars + "FFFFGGGGGHHHHHIIIIIIIIIIIIIJJKKLLLLLLLMMMMMMNNNNNNNNNNNNN"
    allowedChars = allowedChars + "OOOOOOOOOOOOOPPPPQQRRRRRRRRRRRRRSSSSSSSSSSTTTTTTTTTTTTTTTUUUUUUUVVV"
    allowedChars = allowedChars + "WWWWXXYYYYZZ"
    
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    let randomNum = Int(arc4random_uniform(allowedCharsCount))
    var newCharacter = String(allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)])
    
    if newCharacter == "Q" {
        newCharacter = "Qu"
    }
    randomString += newCharacter
    
    return randomString
    

}

//func RunAfterDelay(_ delay: TimeInterval, block: DispatchData) {
//    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//    //DispatchQueue.main.after(when: time, block: block)
//    DispatchQueue.main.after(when: time, execute: block)
//}

func RunAfterDelay(_ delay: TimeInterval, block: (Void) -> Void) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.after(when: time, execute: block)
}
