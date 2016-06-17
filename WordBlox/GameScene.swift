//
//  GameScene.swift
//  NSTimerTest
//
//  Created by Richard Lowe on 16/02/2016.
//  Copyright (c) 2016 Richard Lowe. All rights reserved.
//

import SpriteKit

/*============================================================*/
/*============================================================*/
/*============================================================*/

class GameScene: SKScene {
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    var menuSceneDelegate: MenuSceneDelegate?
    
    var countSquares = 0
    
    var selectedNodes:[BlockNode] = [BlockNode]()
    var lastNode : BlockNode!
    var checkNodes:[BlockNode] = [BlockNode]()
    var removeNodes:[BlockNode] = [BlockNode]()
    
    //var timerFlag = false
    
    var collision = UICollisionBehavior()
    
    var timer = Timer()
    
    var waitForExtraLoop = false
    
    var spacing = Int(100)
    
    //var tBegan = false
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score : \(score)"
        }
    }
    
    var wordScore: SKLabelNode!
    var wScore: Int = 0 {
        didSet {
            wordScore.text = "Word : \(wScore)"
        }
    }
    
    var wordLabel: SKLabelNode!
    var wordtext: String = "" {
        didSet {
            wordLabel.text = wordtext
        }
    }
    
    var allWords = [String]()
    
    //sound actions
    var playClick = SKAction()
    
    var button2 = SKSpriteNode()
    
    var star = SKEmitterNode(fileNamed: "particles")
    
    let file = "ospd"
    //let file = mbsingle
    
    var currentlyDeleting = false
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func didMove(to view: SKView) {
        //print ("didMoveToView")
        
        //print ("\(frame.height)")
        //print ("\(frame.width)")
        
        self.view!.isMultipleTouchEnabled = false
        
        //self.backgroundColor  = UIColor.seashellColor()
        self.backgroundColor  = UIColor.oldLaceColor()
        //self.backgroundColor  = UIColor.sandColor()
        
        addBase()
        
        addButton()
        
        makeRectGrid()
        
        //collision.translatesReferenceBoundsIntoBoundary = false
        //physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //physicsWorld.contactDelegate = self
        
        addLabels()
        
        score = 0
        wordtext = ""
        wScore = 0
        
        loadWords()

        //Prepare sounds
        playClick = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)

        startTimer()
        
    }
    
    override func willMove(from view: SKView) {
        print ("GameScene: willMoveFromView")
    }
    
    override func didApplyConstraints() {
        //print ("didApplyConstraints")
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func addLabels() {
        
        gameScore = SKLabelNode()
        gameScore.text = ""
        gameScore.fontColor = SKColor.black()
        gameScore.fontSize = 25
        gameScore.fontName = mainFont
        gameScore.position = CGPoint(x: 20, y:10.0)
        gameScore.horizontalAlignmentMode = .left
        self.addChild(gameScore)
        
        wordScore = SKLabelNode()
        wordScore.text = ""
        wordScore.fontColor = SKColor.black()
        wordScore.fontSize = 25
        wordScore.fontName = mainFont
        wordScore.position = CGPoint(x: 20, y:30.0)
        wordScore.horizontalAlignmentMode = .left
        self.addChild(wordScore)
        
        wordLabel = SKLabelNode()
        wordLabel.text = ""
        wordLabel.fontColor = SKColor.black()
        wordLabel.fontSize = 25
        wordLabel.fontName = mainFont
        wordLabel.position = CGPoint(x: 20, y:50.0)
        wordLabel.horizontalAlignmentMode = .left
        self.addChild(wordLabel)
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func addBase (){
        
        let base = SKSpriteNode (texture: nil, size: CGSize(width: frame.width, height : 10))
        base.position = CGPoint(x:frame.width/2, y: frame.height/6 )
        base.color = SKColor.black()
        base.name = "base"
        
        //topRight.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        base.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height : base.frame.height))
        
        base.physicsBody?.affectedByGravity = false
        base.physicsBody?.isDynamic = false
        base.physicsBody?.allowsRotation = false

        self.addChild(base)
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func addButton() {
        
        button2 = SKSpriteNode (texture: nil, size: CGSize(width: 150, height : 50))
        button2.position = CGPoint(x:frame.width-50, y: 50)
        button2.color = SKColor.lightGray()
        button2.name = "button2"
        addChild(button2)
        
        let label2 = SKLabelNode()
        label2.text = "Menu"
        label2.fontColor = SKColor.black()
        label2.fontSize = 20
        label2.fontName = mainFont
        label2.position = CGPoint(x:0, y:-(button2.frame.height/10))
        label2.name = "button2"
        button2.addChild(label2)
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func loadWords () {
        
        if let WordsPath = Bundle.main().pathForResource(file, ofType: "txt") {
            //if let WordsPath = NSBundle.mainBundle().pathForResource("mbsingle", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: WordsPath){
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
    
    func startTimer() {
        
        //print("**************************** startTimer ******************************")
        
        //timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameScene.updateTimer), userInfo: nil, repeats: true)
        
        //timerFlag = false
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func wordIsReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func updateTimer () {
        
        timer.invalidate()
        
//        let additionalSpacing = CGFloat(spacing + 25)

        let useSize =  50
        spacing  = (Int(frame.width) - (useSize * 5))/6
//        let useHeight  = Int(frame.height)

        
        if removeNodes.count != 0 {
            
            currentlyDeleting = true
            
            print ("Timer : \(removeNodes.count)")
            if waitForExtraLoop == false {
                
                if removeNodes.count > 0 {
                    
                    for remNode in removeNodes {
                        
                        print ("X : \(remNode.position.x)")
                        
                        let col = Int(remNode.position.x / CGFloat(useSize + spacing) )
                        
                        
                        print ("Col : \(col)")
                        
                        if remNode.parent != nil {
                            
                            score = score + remNode.getPoints()
                            if let starParticles = SKEmitterNode(fileNamed: "particles") {
                                starParticles.position = remNode.position
                                starParticles.zPosition = 20
                                addChild(starParticles)
                            }
                            
                            self.run(SKAction.playSoundFileNamed("coin", waitForCompletion: false))
                            RunAfterDelay(1.0) {

                                remNode.removeFromParent()
                                self.addRectInCol (col)
                            }
                        }
                        
                        removeNodes.removeFirst()
                        //++score
                        
                        if removeNodes.count == 0 {
                            waitForExtraLoop = true
                        }
                        
                        break
                    }
                }
                
            } else {
                waitForExtraLoop = false
            }
            
        } else {
            currentlyDeleting = false
        }
        
        startTimer()
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func didChangeSize(_ oldSize: CGSize) {
        
        //print ("didChangeSize")
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func makeRectGrid(){

        let useSize =  50
        spacing  = (Int(frame.width) - (useSize * 5))/6
        let useHeight  = Int(frame.height)
 
        print("spacing : \(spacing)")
        print("useSize : \(useSize)")
        print("useHeight : \(useHeight)")
        
        
        for x in 0...4 {
            for y in 0...7 {
                
                //UIColor.sandColor()
                //UIColor.almondColor()
                
                let block = BlockNode(color: UIColor.sandColor() , size: CGSize(width: 50, height: 50))
                
                block.position = CGPoint(x: x * (useSize + spacing) + (useSize/2) + spacing, y: (y * useSize) + useHeight )
                
                //print("x : \(block.position.x)")

                block.setValue (randomScrabbleLetters())
                block.setPoints (calcScrabblePoints(block.getValue()))
                block.setup( view! )
                addChild(block)
                
                //allNodes.append (block)
                
            }
        }
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func calcScrabblePoints(_ value : String ) -> Int {
        
        
        switch value {
        case "E","A","O","T","I","N","R","S","L","U" :
            return 1
        case "D", "G" :
            return 2
        case "C","M","B","P" :
            return 3
        case "H","F","W","Y","V" :
            return 4
        case "K" :
            return 5
        case "J", "X" :
            return 8
        case "Qu", "Z" :
            return 10
        default :
            return 0
        }
        
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
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func addRectInCol( _ col : Int){
        
        let useSize =  50
        spacing  = (Int(frame.width) - (useSize * 5))/6
        let useHeight  = Int(frame.height)
        
        let x = col
        
//        let block = BlockNode(color: UIColor.sandColor(), size: CGSize(width: 50, height: 50))
//        block.position = CGPoint(x: (x * 60) + spacing, y: 770 )
        
        let block = BlockNode(color: UIColor.sandColor() , size: CGSize(width: 50, height: 50))
        block.position = CGPoint(x: x * (useSize + spacing) + (useSize/2) + spacing, y: useHeight )

        
        block.setValue (randomScrabbleLetters())
        block.setPoints (calcScrabblePoints(block.getValue()))
        
        block.setup(view! )
        addChild(block)
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesBegan ****")

        self.run(playClick)

        if currentlyDeleting == false {
            
            for touch in touches {
                
                wordtext = ""
                selectedNodes.removeAll()
                wScore = 0
                
                let location = touch.location(in: self)
                if let theName = self.atPoint(location).name {
                    
                    switch theName {
                    case "button2" :
                        
                        print ("button2")
                        button2.color = SKColor.red()
                        RunAfterDelay(0.5) {
                            self.menuSceneDelegate?.loadMainScene()
                        }
                        break
                        
                    case "block" :
                        
                        if let node = self.atPoint(location) as? BlockNode {
                            
                            wordtext = ""
                            selectedNodes.removeAll()
                            //tBegan = true
                            wScore = 0
                            
                            
                            wordtext = wordtext + node.getValue()
                            
                            node.highlightTexture()
                            
                            //clear lastnode
                            if lastNode != nil {
                                if lastNode.getSelected() == true {
                                    lastNode.setSelected(value: false)
                                    lastNode.standardTexture()
                                }
                            }
                            
                            lastNode = node
                            node.setSelected(value: true)
                            
                            wScore = node.getPoints()
                            
                            selectedNodes.append(node)
                            
                            //print ("Node Count : \(selectedNodes.count)")
                            //print ("Nodex: \(node.getValue())")
                            
                        }
                        break
                        
                    default :
                        break
                    }
                    
                }
            }
        }
        print ("**** touchesBegan ENDED ****")
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesMoved ****")
        
        if currentlyDeleting == false {
            
            for touch in touches {
                
                let location = touch.location(in: self)
                
                if let theName = self.atPoint(location).name {
                    
                    switch theName {
                    case "button2" :
                        break
                        
                    case "block" :
                        
                        if let node = self.atPoint(location) as? BlockNode {
                            
                            //check if finger has been lifted
                            //if tBegan == true {
                            
                            if lastNode != node {
                                
                                //print ("selected = \(node.getSelected())")

                                self.run(playClick)

                                //check to see if node has already been selected
                                if !node.getSelected() {
                                    
                                    node.highlightTexture()
                                    node.setSelected(value: true)
                                    
                                    wScore = wScore + node.getPoints()
                                    wordtext = wordtext + node.getValue()
                                    
                                    selectedNodes.append( node)
                                    lastNode = node
                                    
                                } else {
                                    
                                    // node.getSelected() must be true
                                    
                                    for nodes in selectedNodes {
                                        //print ("pos \(nodes.position)")
                                        nodes.standardTexture()
                                        nodes.setSelected(value: false)
                                        
                                        //print ("\(nodes.getValue())")
                                    }
                                    
                                    node.standardTexture()
                                    node.setSelected(value: false)
                                    
                                    wScore = 0
                                    selectedNodes.removeAll()
                                    //tBegan = false
                                    checkValid()
                                    
                                }
                            }
                        }
                        break
                    default :
                        break
                    }
                }
            }
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesEnded ****")
        
        if currentlyDeleting == false {
            
            for _ in touches {
                
                if selectedNodes.count > 1 {
                    
                    for nodes in selectedNodes {
                        //print ("pos \(nodes.position)")
                        nodes.standardTexture()
                        nodes.setSelected(value: false)
                        
                        //print ("\(nodes.getValue())")
                    }
                    
                    checkValid()
                    
                } else {
                    
                    for nodes in selectedNodes {
                        //print ("pos \(nodes.position)")
                        nodes.standardTexture()
                        nodes.setSelected(value: false)
                        
                        //print ("\(nodes.getValue())")
                    }
                    
                    wordtext = ""
                    wScore = 0
                    selectedNodes.removeAll()
                    
                }
            }
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func checkValid() {
        
        print ("checkValid : \(removeNodes.count)")
        //wordtext = ""
        
        var UpperWordtext = wordtext.lowercased()
        if file == "ospd" {
            UpperWordtext = wordtext.uppercased()
        }
        
        print ("Word : \(UpperWordtext)")
        print ("Length : \(UpperWordtext.characters.count)")
        print ("Count : \(allWords.count)")
        
        //UpperWordtext = "A*A"
        
        if UpperWordtext != "" {
            
            if allWords.contains(UpperWordtext) {
                print("We've got apples!")
                
                if selectedNodes.count > 0 {
                    
                    for nodes in selectedNodes {
                        
                        if nodes.parent != nil {
                            
                            removeNodes.append(nodes)
                        }
                    }
                } else {
                    print("hmmmm - not good")
                }
                
            } else {
                
                print("No apples here – sorry!")
                
                for nodes in selectedNodes {
                    //print ("pos \(nodes.position)")
                    nodes.standardTexture()
                    nodes.setSelected(value: false)
                    
                    //print ("\(nodes.getValue())")
                }
                
                wordtext = ""
                wScore = 0
            }
        } else {
            print("opps - its blanks")
            
        }
        
        ////======================================////
        // the below code is NOT required for this project
        // it is just a test of formatting with NSPredicate
        
        // [cd] = case-insensitive and diacritic-insensitive.
        // insensitive to diacritics, which are accent marks added to letters to alter a word's meaning or pronunciation
        
        
        //working - returns 15 results - all 2 letters starting with A
        //            let testWord = "A?"
        //            let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
        
        //working - returns 192 results - all 4 letters starting with A
        //            let testWord = "A???"
        //            let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
        
        //working - returns 4408 results - any length - all starting with A
        //            let testWord = "A*"
        //            let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
        
        //working - returns 131 results - any length - all starting with A?H
        //            let testWord = "A?H*"
        //            let aPredicate = NSPredicate(format: "SELF LIKE %@", testWord)
        
        //working - returns 3806 results - all containing "AT"
        //            let testWord = "AT"
        //            let aPredicate = NSPredicate(format: "SELF contains [c] %@", testWord)
        
        //            let hipHipArray = (allWords as NSArray).filteredArrayUsingPredicate(aPredicate)
        //            // hipHipArray = ["hip", "hip"]
        //
        //            print ("\(hipHipArray.count)")
        //
        //
        //            for i in 0...hipHipArray.count-1 {
        //                 print ("\(hipHipArray[i])")
        //            }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
}

