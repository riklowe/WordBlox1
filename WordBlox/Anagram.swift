//
//  Anagram.swift
//  WordBlox1
//
//  Created by Richard Lowe on 23/02/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

//http://www.rosettacode.org/wiki/Anagrams#Swift

//"heart"
//ather earth erath harte hater herat raeth rahte rathe reath rehat thare thear threa


import Foundation
import SpriteKit
import CoreData
import AVFoundation

/*============================================================*/
/*============================================================*/
/*============================================================*/

extension String {
    
    var charactersAscending : String {
        return String(Array(characters).sorted())
    }
}

class AnagramScene: SKScene {
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    var button1 = SKSpriteNode()
    var button2 = SKSpriteNode()
    var button3 = SKSpriteNode()
    var button4 = SKSpriteNode()
    
    var menuSceneDelegate: MenuSceneDelegate?
    
    var wordLabel: SKLabelNode!
    var wordtext: String = "" {
        didSet {
            wordLabel.text = wordtext
        }
    }
    
    var infoLabel: SKLabelNode!
    var infotext: String = "" {
        didSet {
            infoLabel.text = infotext
        }
    }
    
    var allWords = [String]()

    //sound actions
    var playClick = SKAction()

    var resultLabel: SKLabelNode!
    //var multiLabel = SKMultilineLabel(text: "", labelWidth: 250, pos: CGPoint(x: 200, y: 200))
    
    /// Scroll view
    weak var scrollView: CustomScrollView!
    
    /// Moveable node in the scrollView
    var moveableNode = SKNode()
    
    var page1ScrollView = SKSpriteNode()
    var page2ScrollView = SKSpriteNode()
    var page3ScrollView = SKSpriteNode()
    var page4ScrollView = SKSpriteNode()
    var page5ScrollView = SKSpriteNode()
    var page6ScrollView = SKSpriteNode()
    var page7ScrollView = SKSpriteNode()
    var page8ScrollView = SKSpriteNode()
    var page9ScrollView = SKSpriteNode()
    var page10ScrollView = SKSpriteNode()
    
    var multiLabel1 = SKMultilineLabel(text:"", labelWidth:0)
    var multiLabel2 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel3 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel4 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel5 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel6 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel7 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel8 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel9 = SKMultilineLabel(text:" ", labelWidth:1)
    var multiLabel10 = SKMultilineLabel(text:" ", labelWidth:1)
    
    let hScrollLabel1 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel2 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel3 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel4 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel5 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel6 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel7 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel8 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel9 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
    let hScrollLabel10 = SKLabelNode(fontNamed:"ChalkboardSE-Regular")

    var firstTime = true
    
    var gCount = 0
    
    var timer = Timer()
    
    var foundArray: [String] = []
    
    var lastNode : BlockNode!

    var startTime = Date()

    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor  = UIColor.oldLaceColor()
        
        addButtons()
        
        wordtext = ""
        infotext = ""
        
        loadWords()
        
        /// add moveable node
        addChild(moveableNode)
        
        
        /// VERTICAL SCROLLING
        //prepareVerticalScrolling()
        
        
        /// HORIZONTAL SCROLLING
        prepareHorizontalScrolling()
        
        
        makeLettersGrid()
        
        listAllFonts()
        
        //prepareAVPlayer()
        
        //Prepare sounds
        playClick = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
        
    }
    
    override func willMove(from view: SKView) {
        print ("WordFinderScene: willMoveFromView")
        
        scrollView.removeFromSuperview()
        
        self.removeAllChildren()
        
    }
    
    override func didApplyConstraints() {
        //print ("didApplyConstraints")
    }
    
    func prepareAVPlayer() {
        
        var backGroundMusic = AVAudioPlayer()
        //let bgMusicUrl:URL = Bundle.main.urlForResource("Click", withExtension: "wav")!
        let bgMusicUrl:URL = Bundle.main.url(forResource: "Click", withExtension: "wav")!
        
        do {
            backGroundMusic = try AVAudioPlayer(contentsOf:bgMusicUrl)
            backGroundMusic.numberOfLoops = (-1)
            backGroundMusic.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/

    func addButtons() {

        let buttonWidth = Int(frame.width/2.1)
        let buttonHeight = Int(50)
        
        button1 = SKSpriteNode (texture: nil, size: CGSize(width: buttonWidth, height : buttonHeight))
        button1.position = CGPoint(x:frame.width/4.2, y: 50)
        button1.color = SKColor.limeColor()
        button1.name = "button1"
        button1.zPosition = 10
        addChild(button1)
        
        let label = SKLabelNode()
        label.text = "Clear"
        label.fontColor = SKColor.black
        label.fontSize = 20
        label.fontName = mainFont
        label.position = CGPoint(x:0, y:-(button1.frame.height/10))
        label.name = "button1"
        button1.addChild(label)
        
        button2 = SKSpriteNode (texture: nil, size: CGSize(width: buttonWidth, height : buttonHeight))
        button2.position = CGPoint(x: (frame.width/4.2) * 3.2, y: 50)
        button2.color = SKColor.limeColor()
        button2.name = "button2"
        button2.zPosition = 10
        addChild(button2)
        
        let label2 = SKLabelNode()
        label2.text = "Menu"
        label2.fontColor = SKColor.black
        label2.fontSize = 20
        label2.fontName = mainFont
        label2.position = CGPoint(x:0, y:-(button2.frame.height/10))
        label2.name = "button2"
        button2.addChild(label2)
        
        //babyBlueColor
        button3 = SKSpriteNode (texture: nil, size: CGSize(width: frame.width, height : CGFloat(buttonHeight)))
        button3.position = CGPoint(x: frame.width/2, y: (frame.height/10) * 6)
        button3.color = SKColor.coralColor()
        button3.name = "button3"
        button3.zPosition = 10
        addChild(button3)
        
        let label3 = SKLabelNode()
        label3.text = "Search"
        label3.fontColor = SKColor.black
        label3.fontSize = 20
        label3.fontName = mainFont
        label3.position = CGPoint(x:0, y:-(button3.frame.height/10))
        label3.name = "button3"
        button3.addChild(label3)
        
        wordLabel = SKLabelNode(fontNamed:mainFont)
        wordLabel.text = ""
        wordLabel.fontColor = SKColor.black
        wordLabel.fontSize = 30
        wordLabel.position = CGPoint(x: 20, y: self.frame.height - 40)
        wordLabel.horizontalAlignmentMode = .left
        self.addChild(wordLabel)
        
        infoLabel = SKLabelNode(fontNamed:mainFont)
        infoLabel.text = ""
        infoLabel.fontColor = SKColor.black
        infoLabel.fontSize = 16
        infoLabel.position = CGPoint(x: 20, y: self.frame.height - 260)
        infoLabel.horizontalAlignmentMode = .left
        self.addChild(infoLabel)
        
        resultLabel = SKLabelNode(fontNamed:mainFont)
        resultLabel.text = ""
        resultLabel.fontColor = SKColor.black
        resultLabel.fontSize = 45
        resultLabel.position = CGPoint(x: 20, y: frame.height - 50)
        resultLabel.horizontalAlignmentMode = .left
        self.addChild(resultLabel)
    }

    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func loadWords () {

        //        let wordsURL = NSURL(string: "http://www.puzzlers.org/pub/wordlists/unixdict.txt")!
        //
        //        do {
        //            wordsstring = try NSString(contentsOfURL:wordsURL , encoding: NSUTF8StringEncoding)
        //        } catch {
        //            print("Dim background error")
        //        }
        //        let allwords = wordsstring.componentsSeparatedByString("\n")
        

        if let WordsPath = Bundle.main.path(forResource: "ospd", ofType: "txt") {
        //if let WordsPath = NSBundle.mainBundle().pathForResource("mbsingle", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: WordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
            print ("Loaded : \(allWords.count)")
            //            print ("\(allWords[0])")
            //            print ("\(allWords[0].characters.count)")
            
        } else {
            allWords = ["ERROR"]
            //print ("ERROR")
            
        }
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func makeLettersGrid(){
        
        var num = 0

        let useSize = Int(frame.width/7)
        let spacing  = Int(frame.width/7)
        let useHeight  = Int(frame.height/2)
        
        for y in 0...7 {
            for x in 0...5 {
                
                if num > 26 {
                    break
                }
                
                let block = BlockNode(color: UIColor.sandColor() , size: CGSize(width: 44, height: 44))
                block.position = CGPoint(x:  (x * useSize) + spacing, y: useHeight - (y * useSize))
                
                switch num {
                    //                case 26 :
                    //                    block.setValue ("?")
                    //                    block.color = SKColor.almondColor()
                    //
                    //                case 27 :
                    //                    block.setValue ("*")
                    //                    block.color = SKColor.almondColor()
                    //
                case 26 :
                    block.setValue ("<")
                    block.color = SKColor.almondColor()
                    
                default :
                    block.setValue (AlphabetByIndex (num))
                }
                
                block.setPoints (0)
                block.setDynamic(false)
                block.setGravity(false)
                block.setup( view! )
                addChild(block)
                
                num += 1
                
            }
        }
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func update(_ currentTime: TimeInterval) {
        
    }

    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func startTimer() {
        
        print("**************************** startTimer ******************************")
        
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(AnagramScene.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer () {
        print("**************************** updateTimer ******************************")
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func TICK(){ startTime =  Date() }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func TOCK(_ function: String = #function, file: String = #file, line: Int = #line){
        //print("\(function) Time: \(startTime.timeIntervalSinceNow)\nLine:\(line) File: \(file)")
        print("\(function) Time: \(startTime.timeIntervalSinceNow)")
    }
    
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func searchAny() {
        
        //        let myCombinations = combinations([1,2,3,4],k: 2)
        //        print ("\(myCombinations)")
        //        //[[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
        //
        //        let  myPermute = permute(["A", "B", "C"])
        //        print ("\(myPermute)")
        //        // {"BA", "AC", "ABC", "AB", "BCA", "CB", "BC", "CAB", "ACB", "CA", "CBA", "BAC"}
        //
        //        let  myPermute1 = permute(["A", "A", "B"])
        //        print ("\(myPermute1)")
        //        // {"BA", "BAA", "AAB", "AB", "ABA", "AA"}
        //
        //        let  myPermute2 = permute(["A", "A", "B"], minStringLen: 1)
        //        print ("\(myPermute2)")
        //        // {"BA", "A", "BAA", "AB", "AA", "B", "AAB", "ABA"}
        //
        //        let  myPermute3 = permute(["A", "A", "B"], minStringLen: 3)
        //        print ("\(myPermute3)")
        //        // {"ABA", "BAA", "AAB"}
        
        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        print ("***** \(#function) *****")
        
//        You can convert to a set and back to an array again quite easily:        
//        let unique = Array(Set(originals))
        
        //var testSet = [String]()
        let testString = wordtext.uppercased()
        
        let testSet = Array( testString.characters.map {String($0)})
        //print ("\(testSet)")
        
//        TICK()
//        let combinations = (testSet.permutations().powerSet().filter{ $0.count >= 2 })
//        let combPerms = (combinations.flatMap{ $0.permutations() })
//        //let newSet = Set(combPerms)
//        TOCK("New Permutations")
//        
//        print ("New Per : \(newSet.count)")

        //["a", "r", "t", "p"]
        
        
        //print ("Call permute")
        
        //arr.capacity
        //arr.reserveCapacity(100)
        //arr.removeAll(keepCapacity: <#T##Bool#>)
        
        //myPermute4.capacity
        
        var  myPermute4: Set<String> = Set()
        //var  myPermute4 = Set<String>(minimumCapacity: 10000000)
        
//        Get Permutations Time: -20.8509419560432
//        Permutation count : 982800
//        Intersection count : 359
//        Intersection Time: -4.29530400037766
//        Sort Time: -0.0740299820899963
//        Display Time: -2.92022299766541
        
        TICK()
        if testSet.count > 7 {
            myPermute4 = permute(testSet , minStringLen: 5)
        } else {
            myPermute4 = permute(testSet)
        }
        TOCK("Get Permutations")
        
       //let  myPermute4 = permute(["p", "a", "r", "t"])

        print ("Permutation count : \(myPermute4.count)")
        
        //infotext = ("Permutations : \(myPermute4.count)")
        
        //SET is UNIQUE list with NO duplicates ??? not sure about this
        //They are faster than arrays
        
        //ARRAYis a ordered collection, firstly.  
        //Each member of an array is at a specific index that you access through it’s subscript (the [#]
        //the objects at each index need not be distinct. You could have same value stored in every location
        

        foundArray.removeAll()
        
        //allWords is the dictionary - String array
        let allWordsSET = Set(allWords)
        
        //We now have two sets -
        
        //one contains the whole dictionary (allWordsSET)
        //print ("Set count : \(allWordsSET.count)")
        
        //one contains all permutations of the letters the user entered (myPermute4)
        //print ("Pemute count : \(myPermute4.count)")
        
        TICK()
        let tempArray = Array(myPermute4.intersection(allWordsSET))
        print ("Intersection count : \(tempArray.count)")
        TOCK("Intersection")
        
        infotext = ("letter perms : \(myPermute4.count)         words : \(tempArray.count)")
        
//        TICK()
//        //try with filter
//        let arrFiltered = myPermute4.filter{ allWordsSET.contains($0) }
//        print ("Filtered count : \(arrFiltered.count)")
//        TOCK("filter")


        //foundArray = tempArray.sort()
        
        TICK()
        //foundArray = tempArray.sorted(isOrderedBefore: { $0.characters.count > $1.characters.count })
        
        foundArray = tempArray.sorted()
        
        TOCK("Sort")

        /*============================================================*/
        /*============================================================*/
        /*============================================================*/
        TICK()

        if firstTime == true {
            
            multiLabel1 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page1ScrollView.addChild(multiLabel1)
            
            multiLabel2 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page2ScrollView.addChild(multiLabel2)
            
            multiLabel3 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page3ScrollView.addChild(multiLabel3)
            
            multiLabel4 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page4ScrollView.addChild(multiLabel4)
            
            multiLabel5 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page5ScrollView.addChild(multiLabel5)
            
            multiLabel6 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page6ScrollView.addChild(multiLabel6)
            
            multiLabel7 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page7ScrollView.addChild(multiLabel7)
            
            multiLabel8 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page8ScrollView.addChild(multiLabel8)
            
            multiLabel9 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page9ScrollView.addChild(multiLabel9)
            
            multiLabel10 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.black,
                leading: 18, alignment: .left , shouldShowBorder: false)
            page10ScrollView.addChild(multiLabel10)
            
            firstTime = false
        }
        
        multiLabel1.text  = ""
        multiLabel2.text  = ""
        multiLabel3.text  = ""
        multiLabel4.text  = ""
        multiLabel5.text  = ""
        multiLabel6.text  = ""
        multiLabel7.text  = ""
        multiLabel8.text  = ""
        multiLabel9.text  = ""
        multiLabel10.text  = ""
        
        hScrollLabel1.fontColor = UIColor.oldLaceColor()
        hScrollLabel2.fontColor = UIColor.oldLaceColor()
        hScrollLabel3.fontColor = UIColor.oldLaceColor()
        hScrollLabel4.fontColor = UIColor.oldLaceColor()
        hScrollLabel5.fontColor = UIColor.oldLaceColor()
        hScrollLabel6.fontColor = UIColor.oldLaceColor()
        hScrollLabel7.fontColor = UIColor.oldLaceColor()
        hScrollLabel8.fontColor = UIColor.oldLaceColor()
        hScrollLabel9.fontColor = UIColor.oldLaceColor()
        hScrollLabel10.fontColor = UIColor.oldLaceColor()
        
        var count = 0
        var testStg = ""
        
        if foundArray.count > 0 {
            for i in 0...foundArray.count-1 {
                
                //print ("\(foundArray[i]) \(count)")
                
                testStg = foundArray[i]
                count = count + testStg.characters.count
                
                switch count {
                case 1..<140:
                    multiLabel1.text = multiLabel1.text +  String(foundArray[i]) + ", "
                    break
                case 141..<280 :
                    multiLabel2.text = multiLabel2.text +  String(foundArray[i]) + ", "
                    hScrollLabel1.fontColor = UIColor.red
                    break
                case 281..<420 :
                    multiLabel3.text = multiLabel3.text +  String(foundArray[i]) + ", "
                    hScrollLabel2.fontColor = UIColor.red
                    break
                case 421..<560 :
                    multiLabel4.text = multiLabel4.text +  String(foundArray[i]) + ", "
                    hScrollLabel3.fontColor = UIColor.red
                    break
                case 561..<700 :
                    multiLabel5.text = multiLabel5.text +  String(foundArray[i]) + ", "
                    hScrollLabel4.fontColor = UIColor.red
                    break
                case 701..<840 :
                    multiLabel6.text = multiLabel6.text +  String(foundArray[i]) + ", "
                    hScrollLabel5.fontColor = UIColor.red
                    break
                case 841..<980 :
                    multiLabel7.text = multiLabel7.text +  String(foundArray[i]) + ", "
                    hScrollLabel6.fontColor = UIColor.red
                    break
                case 981..<1120 :
                    multiLabel8.text = multiLabel8.text +  String(foundArray[i]) + ", "
                    hScrollLabel7.fontColor = UIColor.red
                    break
                case 1121..<1260 :
                    multiLabel9.text = multiLabel9.text +  String(foundArray[i]) + ", "
                    hScrollLabel8.fontColor = UIColor.red
                   break
                case 1261..<1400 :
                    hScrollLabel10.fontColor = UIColor.red
                    multiLabel9.text = multiLabel10.text +  String(foundArray[i]) + ", "
                    multiLabel10.text = multiLabel10.text +  String(foundArray[i]) + ", "
                    break
                default :
                    multiLabel10.text = multiLabel10.text +  "..."
                    break
                }
                
                if count > 1400 {
                    break
                }
                
                //if you reached the end of the loop
                // remove the last comma
                if i == foundArray.count-1 {
                    
                    switch count {
                    case 1..<140:
                        multiLabel1.text = String(multiLabel1.text.characters.dropLast())
                        multiLabel1.text = String(multiLabel1.text.characters.dropLast())
                        break
                    case 141..<280 :
                        multiLabel2.text = String(multiLabel2.text.characters.dropLast())
                        multiLabel2.text = String(multiLabel2.text.characters.dropLast())
                        break
                    case 281..<420 :
                        multiLabel3.text = String(multiLabel3.text.characters.dropLast())
                        multiLabel3.text = String(multiLabel3.text.characters.dropLast())
                        break
                    case 421..<560 :
                        multiLabel4.text = String(multiLabel4.text.characters.dropLast())
                        multiLabel4.text = String(multiLabel4.text.characters.dropLast())
                        break
                    case 561..<700 :
                        multiLabel5.text = String(multiLabel5.text.characters.dropLast())
                        multiLabel5.text = String(multiLabel5.text.characters.dropLast())
                        break
                    case 701..<840 :
                        multiLabel6.text = String(multiLabel6.text.characters.dropLast())
                        multiLabel6.text = String(multiLabel6.text.characters.dropLast())
                        break
                    case 841..<980 :
                        multiLabel7.text = String(multiLabel7.text.characters.dropLast())
                        multiLabel7.text = String(multiLabel7.text.characters.dropLast())
                        break
                    case 981..<1120 :
                        multiLabel8.text = String(multiLabel8.text.characters.dropLast())
                        multiLabel8.text = String(multiLabel8.text.characters.dropLast())
                        break
                    case 1121..<1260 :
                        multiLabel9.text = String(multiLabel9.text.characters.dropLast())
                        multiLabel9.text = String(multiLabel9.text.characters.dropLast())
                        break
                    case 1261..<1400 :
                        multiLabel10.text = String(multiLabel10.text.characters.dropLast())
                        multiLabel10.text = String(multiLabel10.text.characters.dropLast())
                        break
                    default :
                        multiLabel10.text = multiLabel10.text +  "..."
                        break
                    }
                    
                }
            }
        } else {
            multiLabel1.text = "No Results"
        }
        
        //scroll back to first screen
        scrollView.setContentOffset(CGPoint(x: frame.width * 9, y: 0), animated: true)
        TOCK("Display")
        
        //infoLabel.text = ("")
        
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func searchExact() {
//        
//        
//        /*============================================================*/
//        /*============================================================*/
//        /*============================================================*/
//        
//                let FindWordtext = wordtext.lowercaseString
//        
//                var foundArray: [String] = []
//        
//                var UpperWordtext = ""
//                for _ in 0...FindWordtext.characters.count - 1 {
//                    UpperWordtext = UpperWordtext + "?"
//                }
//        
////                print ("Word : \(UpperWordtext)")
////                print ("Length : \(UpperWordtext.characters.count)")
//                print ("Count : \(allWords.count)")
//        
//                let testWord = UpperWordtext
//        
//                let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
//        
//                let checkArray = (allWords as NSArray).filteredArrayUsingPredicate(aPredicate)
//        
//                print ("\(checkArray.count) \(UpperWordtext.characters.count) letter words in dictionary")
//        
//        
//        
//                for countWord in 0...checkArray.count-1 {
//        
//                    if anagramTest(phrase1: FindWordtext, phrase2: checkArray[countWord] as! String) {
//                        print ("\(checkArray[countWord])")
//                        foundArray.append(checkArray[countWord] as! String)
//                    }
//        
//                }
//        
//        
//        /*============================================================*/
//        /*============================================================*/
//        /*============================================================*/
//        
//        if firstTime == true {
//            
//            multiLabel1 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page1ScrollView.addChild(multiLabel1)
//            
//            multiLabel2 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page2ScrollView.addChild(multiLabel2)
//            
//            multiLabel3 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page3ScrollView.addChild(multiLabel3)
//            
//            multiLabel4 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page4ScrollView.addChild(multiLabel4)
//            
//            multiLabel5 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page5ScrollView.addChild(multiLabel5)
//            
//            multiLabel6 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page6ScrollView.addChild(multiLabel6)
//            
//            multiLabel7 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page7ScrollView.addChild(multiLabel7)
//            
//            multiLabel8 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page8ScrollView.addChild(multiLabel8)
//            
//            multiLabel9 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page9ScrollView.addChild(multiLabel9)
//            
//            multiLabel10 = SKMultilineLabel(text: "", labelWidth: Int(view!.frame.width-100) , pos: CGPoint(x:0, y: (page1ScrollView.frame.height/2) - 50),
//                fontName: "ChalkboardSE-Regular", fontSize: 14, fontColor: SKColor.blackColor(),
//                leading: 18, alignment: .Left , shouldShowBorder: false)
//            page10ScrollView.addChild(multiLabel10)
//            
//            firstTime = false
//        }
//        
//        
//        multiLabel1.text  = ""
//        multiLabel2.text  = ""
//        multiLabel3.text  = ""
//        multiLabel4.text  = ""
//        multiLabel5.text  = ""
//        multiLabel6.text  = ""
//        multiLabel7.text  = ""
//        multiLabel8.text  = ""
//        multiLabel9.text  = ""
//        multiLabel10.text  = ""
//        
//        var count = 0
//        var testStg = ""
//        if foundArray.count > 0 {
//            for i in 0...foundArray.count-1 {
//                
//                print ("\(foundArray[i]) \(count)")
//                testStg = foundArray[i]
//                count = count + testStg.characters.count
//                
//                switch count {
//                case 1..<140:
//                    multiLabel1.text = multiLabel1.text +  String(foundArray[i]) + ", "
//                    break
//                case 141..<280 :
//                    multiLabel2.text = multiLabel2.text +  String(foundArray[i]) + ", "
//                    break
//                case 281..<420 :
//                    multiLabel3.text = multiLabel3.text +  String(foundArray[i]) + ", "
//                    break
//                case 421..<560 :
//                    multiLabel4.text = multiLabel4.text +  String(foundArray[i]) + ", "
//                    break
//                case 561..<700 :
//                    multiLabel5.text = multiLabel5.text +  String(foundArray[i]) + ", "
//                    break
//                case 701..<840 :
//                    multiLabel6.text = multiLabel6.text +  String(foundArray[i]) + ", "
//                    break
//                case 841..<980 :
//                    multiLabel7.text = multiLabel7.text +  String(foundArray[i]) + ", "
//                    break
//                case 981..<1120 :
//                    multiLabel8.text = multiLabel8.text +  String(foundArray[i]) + ", "
//                    break
//                case 1121..<1260 :
//                    multiLabel9.text = multiLabel9.text +  String(foundArray[i]) + ", "
//                    break
//                case 1261..<1400 :
//                    multiLabel10.text = multiLabel10.text +  String(foundArray[i]) + ", "
//                    break
//                default :
//                    multiLabel10.text = multiLabel10.text +  "..."
//                    break
//                }
//                
//                if count > 1400 {
//                    break
//                }
//                
//                //if you reached the end of the loop
//                // remove the last comma
//                if i == foundArray.count-1 {
//                    
//                    switch count {
//                    case 1..<140:
//                        multiLabel1.text = String(multiLabel1.text.characters.dropLast())
//                        multiLabel1.text = String(multiLabel1.text.characters.dropLast())
//                        break
//                    case 141..<280 :
//                        multiLabel2.text = String(multiLabel2.text.characters.dropLast())
//                        multiLabel2.text = String(multiLabel2.text.characters.dropLast())
//                        break
//                    case 281..<420 :
//                        multiLabel3.text = String(multiLabel3.text.characters.dropLast())
//                        multiLabel3.text = String(multiLabel3.text.characters.dropLast())
//                        break
//                    case 421..<560 :
//                        multiLabel4.text = String(multiLabel4.text.characters.dropLast())
//                        multiLabel4.text = String(multiLabel4.text.characters.dropLast())
//                        break
//                    case 561..<700 :
//                        multiLabel5.text = String(multiLabel5.text.characters.dropLast())
//                        multiLabel5.text = String(multiLabel5.text.characters.dropLast())
//                        break
//                    case 701..<840 :
//                        multiLabel6.text = String(multiLabel6.text.characters.dropLast())
//                        multiLabel6.text = String(multiLabel6.text.characters.dropLast())
//                        break
//                    case 841..<980 :
//                        multiLabel7.text = String(multiLabel7.text.characters.dropLast())
//                        multiLabel7.text = String(multiLabel7.text.characters.dropLast())
//                        break
//                    case 981..<1120 :
//                        multiLabel8.text = String(multiLabel8.text.characters.dropLast())
//                        multiLabel8.text = String(multiLabel8.text.characters.dropLast())
//                        break
//                    case 1121..<1260 :
//                        multiLabel9.text = String(multiLabel9.text.characters.dropLast())
//                        multiLabel9.text = String(multiLabel9.text.characters.dropLast())
//                        break
//                    case 1261..<1400 :
//                        multiLabel10.text = String(multiLabel10.text.characters.dropLast())
//                        multiLabel10.text = String(multiLabel10.text.characters.dropLast())
//                        break
//                    default :
//                        multiLabel10.text = multiLabel10.text +  "..."
//                        break
//                    }
//                    
//                }
//            }
//        } else {
//            multiLabel1.text = "No Results"
//        }
//        
//        //scroll back to first screen
//        scrollView.setContentOffset(CGPoint(x: frame.width * 9, y: 0), animated: true)
//        
//        
//        
    }

    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesBegan ****")
        
        self.run(playClick)
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //            if let node = self.nodeAtPoint(location) as? SKSpriteNode {
            //
            //                switch node.name! {
            
            if let theName = self.atPoint(location).name {
                
                switch theName {
                case "button1" :   //Clear
                    print ("button1")
                    button1.color = SKColor.red
                    wordtext = ""
                    infotext = ""
                    
                    if firstTime == false {
                        multiLabel1.text  = ""
                        multiLabel2.text  = ""
                        multiLabel3.text  = ""
                        multiLabel4.text  = ""
                        multiLabel5.text  = ""
                        multiLabel6.text  = ""
                        multiLabel7.text  = ""
                        multiLabel8.text  = ""
                        multiLabel9.text  = ""
                        multiLabel10.text  = ""
                    }
                    
                    RunAfterDelay(0.5) {
                        self.button1.color = SKColor.limeColor()
                    }
                    break
                    
                case "button2" :   //Main Menu
                    print ("button2")
                    button2.color = SKColor.red
                    RunAfterDelay(0.5) {
                        self.menuSceneDelegate?.loadMainScene()
                    }
                    break
                    
                case "button3" :   //Search
                    print ("button3")
                    
                    button3.color = SKColor.red
                    if firstTime == false {
                        multiLabel1.text  = ""
                        multiLabel2.text  = ""
                        multiLabel3.text  = ""
                        multiLabel4.text  = ""
                        multiLabel5.text  = ""
                        multiLabel6.text  = ""
                        multiLabel7.text  = ""
                        multiLabel8.text  = ""
                        multiLabel9.text  = ""
                        multiLabel10.text  = ""
                    }
                    RunAfterDelay(0.5) {
                        self.button3.color = SKColor.coralColor()
                        self.searchAny()
                    }
                    break
                                        
                case "block" :
                    
                    if let node = self.atPoint(location) as? BlockNode {
                        
                        if !node.getSelected() {
                            
                            //clear lastnode
                            if lastNode != nil {
                                if lastNode.getSelected() == true {
                                    lastNode.setSelected(value: false)
                                    lastNode.standardTexture()
                                }
                            }

                            node.highlightTexture()
                            node.setSelected(value: true)
                            
                            lastNode = node
                            
                            if node.getValue() != "<" {
                                
                                if wordtext.characters.count < 9 {
                                    wordtext = wordtext + node.getValue()
                                }
                            } else {
                                
                                //let choppedString = String(theString.characters.dropLast())
                                wordtext = String(wordtext.characters.dropLast())
                                
                            }
                        }
                        
                        if firstTime == false {
                            multiLabel1.text  = ""
                            multiLabel2.text  = ""
                            multiLabel3.text  = ""
                            multiLabel4.text  = ""
                            multiLabel5.text  = ""
                            multiLabel6.text  = ""
                            multiLabel7.text  = ""
                            multiLabel8.text  = ""
                            multiLabel9.text  = ""
                            multiLabel10.text  = ""
                        }
                        
                        infotext = ""

                    }
                    
                default :
                    print ("default")
                    
                    break
                }
                
            }
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesMoved ****")
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let node = self.atPoint(location) as? SKSpriteNode {
                
                switch node.name! {
                case "button1" :
                    print ("button1")
                    
                    break
                case "button2" :
                    print ("button2")
                    
                    break
                default :
                    print ("default")
                    
                    break
                }
            }
        }
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesEnded ****")
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let theName = self.atPoint(location).name {
                
                switch theName {
                case "button1" :
                    print ("button1")
                    
                    break
                case "button2" :
                    print ("button2")
                    
                    break
                case "block" :
                    
                    if let node = self.atPoint(location) as? BlockNode {
                        
                        if (node.name == "block") {
                            
                            if node.getSelected() {
                                
                                node.standardTexture()
                                node.setSelected(value: false)
                                
                            }
                        }
                    }
                    break
                default :
                    print ("default")
                    
                    break
                }
            }
            
            
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    // MARK: - Vertical scrolling properties
    func prepareVerticalScrolling() {
        
        /// set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height),
            scene: self, moveableNode: moveableNode, scrollDirection: .vertical, view: view!)
        
        // * 3 makes it 3times as long as screen
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height * 3)
        view!.addSubview(scrollView)
        
        let boxPath = UIBezierPath(rect: scrollView.frame)
        let box = SKShapeNode(path: boxPath.cgPath)
        box.strokeColor = SKColor.red
        box.lineWidth = 10.0
        moveableNode.addChild(box)
        
        
        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        page1ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.size.width/2, height: scrollView.frame.size.height/2))
        page1ScrollView.position = CGPoint(x: scrollView.frame.midX, y: scrollView.frame.midY)
        moveableNode.addChild(page1ScrollView)
        
        let boxPath1 = UIBezierPath(rect: page1ScrollView.frame)
        let box1 = SKShapeNode(path: boxPath1.cgPath)
        box1.strokeColor = SKColor.yellow
        box1.lineWidth = 5.0
        moveableNode.addChild(box1)
        
        
        page2ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.size.width/2, height: scrollView.frame.size.height/2))
        page2ScrollView.position = CGPoint(x: scrollView.frame.midX, y: scrollView.frame.midY - (scrollView.frame.size.height))
        moveableNode.addChild(page2ScrollView)
        
        let boxPath2 = UIBezierPath(rect: page2ScrollView.frame)
        let box2 = SKShapeNode(path: boxPath2.cgPath)
        box2.strokeColor = SKColor.orange
        box2.lineWidth = 5.0
        moveableNode.addChild(box2)
        
        
        page3ScrollView = SKSpriteNode(color: SKColor.clear, size: CGSize(width: scrollView.frame.size.width/2, height: scrollView.frame.size.height/2))
        page3ScrollView.position = CGPoint(x: scrollView.frame.midX, y: scrollView.frame.midY - (scrollView.frame.size.height * 2))
        moveableNode.addChild(page3ScrollView)
        
        let boxPath3 = UIBezierPath(rect: page3ScrollView.frame)
        let box3 = SKShapeNode(path: boxPath3.cgPath)
        box3.strokeColor = SKColor.purple
        box3.lineWidth = 5.0
        moveableNode.addChild(box3)
        
        
        /// Test label page 1
        let myLabel = SKLabelNode(fontNamed:"ChalkboardSE-Regular")
        myLabel.text = "Moveable"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x: 0, y: 0)
        page1ScrollView.addChild(myLabel)
        
        /// Test sprite page 2
        let sprite = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        sprite.position = CGPoint(x: 0, y: 0)
        page2ScrollView.addChild(sprite)
        
        /// Test sprite page 3
        let sprite2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 50, height: 50))
        sprite2.position = CGPoint(x: 0, y: 0)
        page3ScrollView.addChild(sprite2)
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    // MARK: - Horizontal scrolling properties
    func prepareHorizontalScrolling() {
        
        //        let testSprite3 = SKSpriteNode(color: SKColor.orangeColor(), size: CGSize(width: 50, height: 50))
        //        testSprite3.position = CGPointMake(0, 0)
        //        addChild(testSprite3)
        
        
        /// Set up scrollView
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height),
            scene: self, moveableNode: moveableNode, scrollDirection: .horizontal, view: view!)
        
        // * 5 makes it three times as wide as screen
        scrollView.contentSize = CGSize(width: self.frame.size.width * 10, height: self.frame.size.height)
        
        view!.addSubview(scrollView)
        
        //moveableNode.position = CGPoint (x: 0, y: (self.frame.size.height/2))
        
        let aWidth = self.frame.size.width
        
        /// Set scrollView to first page
        scrollView.setContentOffset(CGPoint(x: aWidth * 9, y: 0), animated: true)
        
        //        let boxPath = UIBezierPath(rect: scrollView.frame)
        //        let box = SKShapeNode(path: boxPath.CGPath)
        //        box.strokeColor = SKColor.redColor()
        //        box.lineWidth = 10.0
        //        moveableNode.addChild(box)
        
        
        let pageHeight = scrollView.frame.height/2.6
        
        print ("self: \(self.frame)")
        print ("scrollView: \(scrollView.frame)")
        print ("moveableNode: \(moveableNode.frame)")
        
        /// ScrollView Sprites for each page in scrollView
        /// Makes positioning much easier.
        
        page1ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page1ScrollView.zPosition = -1
        page1ScrollView.position = CGPoint(x: scrollView.frame.midX - (aWidth * 9),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 1: \(page1ScrollView.position)")
        moveableNode.addChild(page1ScrollView)
        
        let boxPath1 = UIBezierPath(rect: page1ScrollView.frame)
        let box1 = SKShapeNode(path: boxPath1.cgPath)
        box1.strokeColor = SKColor.lightGray
        box1.lineWidth = 5.0
        moveableNode.addChild(box1)
        
        page2ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page2ScrollView.zPosition = -1
        page2ScrollView.position = CGPoint(x: scrollView.frame.midX - (aWidth * 8),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 2: \(page2ScrollView.position)")
        moveableNode.addChild(page2ScrollView)
        
        let boxPath2 = UIBezierPath(rect: page2ScrollView.frame)
        let box2 = SKShapeNode(path: boxPath2.cgPath)
        box2.strokeColor = SKColor.lightGray
        box2.lineWidth = 5.0
        moveableNode.addChild(box2)
        
        
        page3ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page3ScrollView.zPosition = -1
        page3ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 7),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 3: \(page3ScrollView.position)")
        moveableNode.addChild(page3ScrollView)
        
        let boxPath3 = UIBezierPath(rect: page3ScrollView.frame)
        let box3 = SKShapeNode(path: boxPath3.cgPath)
        box3.strokeColor = SKColor.lightGray
        box3.lineWidth = 5.0
        moveableNode.addChild(box3)
        
        
        page4ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page4ScrollView.zPosition = -1
        page4ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 6),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 4: \(page4ScrollView.position)")
        moveableNode.addChild(page4ScrollView)
        
        let boxPath4 = UIBezierPath(rect: page4ScrollView.frame)
        let box4 = SKShapeNode(path: boxPath4.cgPath)
        box4.strokeColor = SKColor.lightGray
        box4.lineWidth = 5.0
        moveableNode.addChild(box4)
        
        
        page5ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page5ScrollView.zPosition = -1
        page5ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 5),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 5: \(page5ScrollView.position)")
        moveableNode.addChild(page5ScrollView)
        
        let boxPath5 = UIBezierPath(rect: page5ScrollView.frame)
        let box5 = SKShapeNode(path: boxPath5.cgPath)
        box5.strokeColor = SKColor.lightGray
        box5.lineWidth = 5.0
        moveableNode.addChild(box5)
        
        
        page6ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page6ScrollView.zPosition = -1
        page6ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 4),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 6: \(page6ScrollView.position)")
        moveableNode.addChild(page6ScrollView)
        
        let boxPath6 = UIBezierPath(rect: page6ScrollView.frame)
        let box6 = SKShapeNode(path: boxPath6.cgPath)
        box6.strokeColor = SKColor.lightGray
        box6.lineWidth = 5.0
        moveableNode.addChild(box6)
        
        page7ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page7ScrollView.zPosition = -1
        page7ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 3),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 7: \(page7ScrollView.position)")
        moveableNode.addChild(page7ScrollView)
        
        let boxPath7 = UIBezierPath(rect: page7ScrollView.frame)
        let box7 = SKShapeNode(path: boxPath7.cgPath)
        box7.strokeColor = SKColor.lightGray
        box7.lineWidth = 5.0
        moveableNode.addChild(box7)
        
        page8ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page8ScrollView.zPosition = -1
        page8ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 2),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 8: \(page8ScrollView.position)")
        moveableNode.addChild(page8ScrollView)
        
        let boxPath8 = UIBezierPath(rect: page8ScrollView.frame)
        let box8 = SKShapeNode(path: boxPath8.cgPath)
        box8.strokeColor = SKColor.lightGray
        box8.lineWidth = 5.0
        moveableNode.addChild(box8)
        
        page9ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page9ScrollView.zPosition = -1
        page9ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 1),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 9: \(page9ScrollView.position)")
        moveableNode.addChild(page9ScrollView)
        
        let boxPath9 = UIBezierPath(rect: page9ScrollView.frame)
        let box9 = SKShapeNode(path: boxPath9.cgPath)
        box9.strokeColor = SKColor.lightGray
        box9.lineWidth = 5.0
        moveableNode.addChild(box9)
        
        page10ScrollView = SKSpriteNode(color: SKColor.oldLaceColor(), size: CGSize(width: scrollView.frame.width, height: pageHeight))
        page10ScrollView.zPosition = -1
        page10ScrollView.position = CGPoint(x: scrollView.frame.midX  - (aWidth * 0),y: (scrollView.frame.height - (pageHeight/2)))
        print ("Page 10: \(page10ScrollView.position)")
        moveableNode.addChild(page10ScrollView)
        
        let boxPath10 = UIBezierPath(rect: page10ScrollView.frame)
        let box10 = SKShapeNode(path: boxPath10.cgPath)
        box10.strokeColor = SKColor.lightGray
        box10.lineWidth = 5.0
        moveableNode.addChild(box10)
        
        
        /// Test label page 1
        ////        let sprite1 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        ////        sprite1.position = CGPointMake(0, 0)
        ////        page1ScrollView.addChild(sprite1)
        //
        hScrollLabel1.text = " ---->"
        hScrollLabel1.fontSize = 16
        hScrollLabel1.fontColor = SKColor.red
        hScrollLabel1.position = CGPoint(x: 0,  y: -(page1ScrollView.frame.height / 3))
        page1ScrollView.addChild(hScrollLabel1)
        //
        //        /// Test sprite page 2
        ////        let sprite2 = SKSpriteNode(color: SKColor.purpleColor(), size: CGSize(width: 50, height: 50))
        ////        sprite2.position = CGPointMake(0, 0)
        ////        page2ScrollView.addChild(sprite2)
        //
        hScrollLabel2.text = "<-----  ---->"
        hScrollLabel2.fontSize = 16
        hScrollLabel2.fontColor = SKColor.red
        hScrollLabel2.position = CGPoint(x: 0,  y: -(page2ScrollView.frame.height / 3))
        page2ScrollView.addChild(hScrollLabel2)
        //
        //        /// Test sprite page 3
        ////        let sprite3 = SKSpriteNode(color: SKColor.orangeColor(), size: CGSize(width: 50, height: 50))
        ////        sprite3.position = CGPointMake(0, 0)
        ////        page3ScrollView.addChild(sprite3)
        //
        hScrollLabel3.text = "<-----  ---->"
        hScrollLabel3.fontSize = 16
        hScrollLabel3.fontColor = SKColor.red
        hScrollLabel3.position = CGPoint(x: 0,  y: -(page3ScrollView.frame.height / 3))
        page3ScrollView.addChild(hScrollLabel3)
        //
        //        /// Test sprite page 4
        ////        let sprite4 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        ////        sprite4.position = CGPointMake(0, 0)
        ////        page4ScrollView.addChild(sprite4)
        //
        hScrollLabel4.text = "<-----  ---->"
        hScrollLabel4.fontSize = 16
        hScrollLabel4.fontColor = SKColor.red
        hScrollLabel4.position = CGPoint(x: 0,  y: -(page4ScrollView.frame.height / 3))
        page4ScrollView.addChild(hScrollLabel4)
        //
        //        /// Test sprite page 5
        ////        let sprite5 = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 50, height: 50))
        ////        sprite5.position = CGPointMake(0, 0)
        ////        page5ScrollView.addChild(sprite5)
        //
        hScrollLabel5.text = "<-----  ---->"
        hScrollLabel5.fontSize = 16
        hScrollLabel5.fontColor = SKColor.red
        hScrollLabel5.position = CGPoint(x: 0,  y: -(page5ScrollView.frame.height / 3))
        page5ScrollView.addChild(hScrollLabel5)
        
        hScrollLabel6.text = "<-----  ---->"
        hScrollLabel6.fontSize = 16
        hScrollLabel6.fontColor = SKColor.red
        hScrollLabel6.position = CGPoint(x: 0,  y: -(page6ScrollView.frame.height / 3))
        page6ScrollView.addChild(hScrollLabel6)
        
        hScrollLabel7.text = "<-----  ---->"
        hScrollLabel7.fontSize = 16
        hScrollLabel7.fontColor = SKColor.red
        hScrollLabel7.position = CGPoint(x: 0,  y: -(page7ScrollView.frame.height / 3))
        page7ScrollView.addChild(hScrollLabel7)
        
        hScrollLabel8.text = "<-----  ---->"
        hScrollLabel8.fontSize = 16
        hScrollLabel8.fontColor = SKColor.red
        hScrollLabel8.position = CGPoint(x: 0,  y: -(page8ScrollView.frame.height / 3))
        page8ScrollView.addChild(hScrollLabel8)
        
        hScrollLabel9.text = "<-----  ---->"
        hScrollLabel9.fontSize = 16
        hScrollLabel9.fontColor = SKColor.red
        hScrollLabel9.position = CGPoint(x: 0,  y: -(page9ScrollView.frame.height / 3))
        page9ScrollView.addChild(hScrollLabel9)
        
        hScrollLabel10.text = "<----- "
        hScrollLabel10.fontSize = 16
        hScrollLabel10.fontColor = SKColor.red
        hScrollLabel10.position = CGPoint(x: 0,  y: -(page10ScrollView.frame.height / 3))
        page10ScrollView.addChild(hScrollLabel10)
        
        hScrollLabel1.fontColor = UIColor.oldLaceColor()
        hScrollLabel2.fontColor = UIColor.oldLaceColor()
        hScrollLabel3.fontColor = UIColor.oldLaceColor()
        hScrollLabel4.fontColor = UIColor.oldLaceColor()
        hScrollLabel5.fontColor = UIColor.oldLaceColor()
        hScrollLabel6.fontColor = UIColor.oldLaceColor()
        hScrollLabel7.fontColor = UIColor.oldLaceColor()
        hScrollLabel8.fontColor = UIColor.oldLaceColor()
        hScrollLabel9.fontColor = UIColor.oldLaceColor()
        hScrollLabel10.fontColor = UIColor.oldLaceColor()

        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    func searchTest() {
//        
//        let UpperWordtext = "????"
//        
//        print ("Word : \(UpperWordtext)")
//        print ("Length : \(UpperWordtext.characters.count)")
//        print ("Count : \(allWords.count)")
//        
//        let testWord = UpperWordtext
//        
//        let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
//        
//        let checkArray = (allWords as NSArray).filteredArrayUsingPredicate(aPredicate)
//        
//        print ("\(checkArray.count)")
//        
//        
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    //generate all permutations of a string
//    
//    func generate(n: Int, var a: [String]){
//        if n == 1 {
//            gCount += 1
//            //print("\(gCount) ", a.joinWithSeparator(""))
//            
//        } else {
//            for i in 0 ..< n - 1 {
//                generate(n - 1, a: a)
//                if n % 2 == 0 {
//                    let temp = a[i]
//                    a[i] = a[n-1]
//                    a[n-1] = temp
//                }
//                else {
//                    let temp = a[0]
//                    a[0] = a[n-1]
//                    a[n-1] = temp
//                }
//            }
//            generate(n - 1, a: a)
//        }
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    func testGenerateAllPermutations() {
//        
//        gCount = 0
//        let str = "lowe"
//        let strArray = str.characters.map { String($0) }
//        generate(str.characters.count, a: strArray)
//        print ("count : \(gCount)")
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    func areAnagrams(phrase1: String, phrase2: String) -> Bool
//    {
//        if phrase1.isEmpty { return false }
//        if phrase2.isEmpty { return false }
//        
//        var trimmedPhrase1 = stripWordBoundaries(phrase1)
//        var trimmedPrhase2 = stripWordBoundaries(phrase2)
//        
//        trimmedPhrase1 = trimmedPhrase1.lowercaseString
//        trimmedPrhase2 = trimmedPrhase2.lowercaseString
//        
//        if trimmedPrhase2 == trimmedPhrase1 {
//            return false
//        }
//        if trimmedPrhase2.characters.count != trimmedPhrase1.characters.count {
//            return false
//        }
//        let chars1 = trimmedPhrase1.characters.sort()
//        let chars2 = trimmedPrhase2.characters.sort()
//        
//        if chars1 == chars2 {
//            return true
//        }
//        return false
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    // let's treat "Ray.adverb" as a word so period would not be stripped, but "Adverb-Ray?" would become AdverbRay
//    func stripWordBoundaries(string: String) -> String
//    {
//        var words : [String] = []
//        string.enumerateSubstringsInRange(string.characters.indices, options: .ByWords) {
//            (substring, _, _, _) -> () in
//            words.append(substring!)
//        }
//        return words.joinWithSeparator("")
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    func anagramTest(phrase1 ph1: String, phrase2 ph2: String) -> Bool
//    {
//        if areAnagrams(ph1, phrase2: ph2) {
//            //print("'\(ph1)' and '\(ph2)' are anagrams")
//            return true
//        }
//        else {
//            //print("'\(ph1)' and '\(ph2)' are NOT anagrams")
//            return false
//        }
//        
//    }
    
//    /*============================================================*/
//    /*============================================================*/
//    /*============================================================*/
//    
//    //http://stackoverflow.com/questions/25162500/apple-swift-generate-combinations-with-repetition
//    
//    func sliceArray(var arr: Array<Int>, x1: Int, x2: Int) -> Array<Int> {
//        var tt: Array<Int> = []
//
//        
//        //for var ii = x1; ii <= x2; ii += 1 {
//        //RL replaced
//        for ii in x1...x2 {
//            tt.append(arr[ii])
//        }
//        return tt
//    }
//    
//    func combinations(var arr: Array<Int>, k: Int) -> Array<Array<Int>> {
//        //        var i: Int
//        //        var subI : Int
//        
//        var ret: Array<Array<Int>> = []
//        var sub: Array<Array<Int>> = []
//        var next: Array<Int> = []
//        
//        for i in 0 ..< arr.count {
//            if(k == 1){
//                ret.append([arr[i]])
//            }else {
//                sub = combinations(sliceArray(arr, x1: i + 1, x2: arr.count - 1), k: k - 1)
//                for subI in 0 ..< sub.count {
//                    next = sub[subI]
//                    next.insert(arr[i], atIndex: 0)
//                    ret.append(next)
//                }
//            }
//            
//        }
//        return ret
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func permute(_ list: [String], minStringLen: Int = 2) -> Set<String> {
        print ("***** \(#function) *****")
        
        func permute(_ fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
            
            if toList.count >= minStringLen {
                set.insert(toList.joined(separator: ""))
            }
            if !fromList.isEmpty {
                for (index, item) in fromList.enumerated() {
                    var newFrom = fromList
                    newFrom.remove(at: index)
                    permute(newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
                }
            }
        }
        
        //var set = Set<String>()
        var  set = Set<String>(minimumCapacity: 2000000)

        permute(list, toList:[], minStringLen: minStringLen, set: &set)
        return set
    }
    

}



