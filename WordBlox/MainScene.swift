//
//  MainScene.swift
//  WordBlox1
//
//  Created by Richard Lowe on 18/02/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

import SpriteKit
import AVFoundation

/*============================================================*/
/*============================================================*/
/*============================================================*/

class MainScene: SKScene {
 
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    let button1 = SKSpriteNode (texture: nil, size: CGSize(width: 200, height : 50))
    let button2 = SKSpriteNode (texture: nil, size: CGSize(width: 200, height : 50))
    let button3 = SKSpriteNode (texture: nil, size: CGSize(width: 200, height : 50))

    var menuSceneDelegate: MenuSceneDelegate?

    //var backgroundMusic: SKAudioNode!

    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor  = UIColor.oldLaceColor()
        
        addButtons()
        
//        backgroundMusic = SKAudioNode(fileNamed: "click")
//        addChild(backgroundMusic)
//        
//        backgroundMusic.
        
        
        var backGroundMusic = AVAudioPlayer()
        let bgMusicUrl:URL = Bundle.main.url(forResource: "Click", withExtension: "wav")!
        
        do {
        backGroundMusic = try AVAudioPlayer(contentsOf:bgMusicUrl)
        backGroundMusic.numberOfLoops = (-1)
        backGroundMusic.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
    }
    
    override func willMove(from view: SKView) {
        print ("MainScene: willMoveFromView")
    }
    
    override func didApplyConstraints() {
        //print ("didApplyConstraints")
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func addButtons () {
        
        button1.position = CGPoint(x:frame.width/2, y: (frame.height/4) * 3)
        button1.color = SKColor.lightGray
        button1.name = "button1"
        addChild(button1)
        
        let label = SKLabelNode()
        label.text = "Game"
        label.fontColor = SKColor.black
        label.fontSize = 20
        label.fontName = mainFont
        label.position = CGPoint(x:0, y:-(button1.frame.height/10))
        label.name = "button1"
        button1.addChild(label)
        
        button2.position = CGPoint(x:frame.width/2, y: (frame.height/4) * 2)
        button2.color = SKColor.lightGray
        button2.name = "button2"
        addChild(button2)
        
        let label2 = SKLabelNode()
        label2.text = "Word Finder"
        label2.fontColor = SKColor.black
        label2.fontSize = 20
        label2.fontName = mainFont
        label2.position = CGPoint(x:0, y:-(button2.frame.height/10))
        label2.name = "button2"
        button2.addChild(label2)
        
        button3.position = CGPoint(x:frame.width/2, y: (frame.height/4) * 1)
        button3.color = SKColor.lightGray
        button3.name = "button3"
        addChild(button3)
        
        let label3 = SKLabelNode()
        label3.text = "Anagram"
        label3.fontColor = SKColor.black
        label3.fontSize = 20
        label3.fontName = mainFont
        label3.position = CGPoint(x:0, y:-(button3.frame.height/10))
        label3.name = "button3"
        button3.addChild(label3)
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print ("**** touchesBegan ****")
        
        for touch in touches {
            
            let location = touch.location(in: self)
            

            if let theName = self.atPoint(location).name {

                print ("\(theName)")

                switch theName {
                case "button1" :
                    button1.color = SKColor.red
                    RunAfterDelay(0.5) {
                        self.menuSceneDelegate?.loadGameScene()
                    }
                    break
                case "button2" :
                    button2.color = SKColor.red
                    RunAfterDelay(0.5) {
                        self.menuSceneDelegate?.loadWordFinderScene()
                    }
                    break
                case "button3" :
                    button3.color = SKColor.red
                    RunAfterDelay(0.5) {
                        self.menuSceneDelegate?.loadAnagramScene()
                    }
                    break
                default :
                    print ("default")

                    break
                }

            } else {
                print ("Error")
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
            if let theName = self.atPoint(location).name {
                
                switch theName {
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
                default :
                    print ("default")
                    
                    break
                }
            }
        }
    }
    

}
