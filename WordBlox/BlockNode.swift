//
//  BlockNode.swift
//  NSTimerTest
//
//  Created by Richard Lowe on 16/02/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

import Foundation
import SpriteKit

/*============================================================*/
/*============================================================*/
/*============================================================*/

enum ColliderType: UInt32 {
    case triangle = 1
    case square = 2
    case circle = 4
    case polygon = 8
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

class BlockNode: SKSpriteNode {
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    var aPath = UIBezierPath()
    
    var myView = SKView()
    
    var myValue = ""
    var myPoints = Int()
    var myDynamic = true
    var myGravity = true
    
    var selected = Bool()
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
//    init(texture: SKTexture!, color: SKColor, size: CGSize, points : Int) {
//        
//        myPoints = points
//        
//        print ("****BlockNode init ****")
//        super.init(texture: texture, color: color, size: size)
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    deinit {
        // perform the deinitialization
        print ("****BlockNode deinit ****")
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func setup(_ view : SKView) {
        
        print ("****BlockNode setup ****")
        myView = view
        
        selected = false
        
        name = "block"
        
        //aPath = UIBezierPath(roundedRect: CGRectMake(0.0,0.0,size.width, size.height), cornerRadius: 10.0)
        
        
        standardTexture()
        
        configurePhysics()
    }
    
//    func setColor (value : SKColor) {
//        self.color = value
//    }
    
    func getColor () -> SKColor {
        return self.color
    }
    
    func setValue (_ value : String) {
        myValue = value
    }
    
    func getValue () -> String {
        return myValue
    }
    
    func setPoints (_ value: Int) {
         myPoints = value
    }
    
    func getPoints () -> Int {
        return myPoints
    }
    
    func setSelected (value : Bool) {
        selected = value
    }
    
    func getSelected () -> Bool {
        return selected
    }
    
    func setDynamic (_ value : Bool) {
        myDynamic = value
    }
    
    func getDynamic () -> Bool {
        return myDynamic
    }
    
    func setGravity (_ value : Bool) {
        myGravity = value
        //print ("myGravity : \(myGravity)")
        
    }
    
    func getGravity () -> Bool {
        return myGravity
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func configurePhysics() {
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: size.height+5), center: CGPoint(x: 0, y: 0))
        // How forces affect the body
        physicsBody?.affectedByGravity = myGravity
        physicsBody?.isDynamic = myDynamic
        physicsBody?.allowsRotation = false
        
        physicsBody?.restitution = 0.0
        physicsBody?.mass = 100
        physicsBody?.density = 1
        physicsBody?.friction = 0.0
        physicsBody?.linearDamping = 1.0
        physicsBody?.angularDamping = 0.0
        
        physicsBody?.collisionBitMask = ColliderType.square.rawValue
        physicsBody?.categoryBitMask = ColliderType.square.rawValue
        physicsBody?.contactTestBitMask = ColliderType.square.rawValue
        
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func standardTexture() {
        
        let background = SKSpriteNode(imageNamed: "wood2")
        background.size = CGSize(width: size.width + 4, height: size.height + 4)
        background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        background.zPosition = 12
        
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -3 , y: -3, width: size.width + 6, height: size.height + 6), cornerRadius: size.height/5).cgPath
        shape.position = CGPoint(x: -background.frame.width/2 + 2 , y: -background.frame.width/2 + 2)
        shape.glowWidth = 0
        shape.lineWidth = 3
        shape.strokeColor = SKColor.black()
        shape.fillColor = SKColor.clear()
        //shape.fillColor = self.color
        shape.zPosition = 11
        //shape.setScale(0.5)
        background.addChild(shape)
        
        let myLabel = SKLabelNode(fontNamed:"Ariel")
        myLabel.text = myValue
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x: background.frame.midX - (background.frame.midX/20) , y: background.frame.midY - (background.frame.midY/3))
        myLabel.fontColor = UIColor.black()
        myLabel.zPosition = 12
        shape.addChild(myLabel)

        if myPoints > 0 {
            let myPointsLabel = SKLabelNode(fontNamed:"Ariel")
            myPointsLabel.text =  String(myPoints)
            myPointsLabel.fontSize = 12;
            myPointsLabel.position = CGPoint(x: shape.frame.width - (20), y: 4)
            myPointsLabel.fontColor = UIColor.black()
            myPointsLabel.zPosition = 12
            shape.addChild(myPointsLabel)
        }
        
        let redTex:SKTexture = myView.texture(from: background)!
        self.texture = redTex
        
    }
 
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func highlightTexture() {
        
        let background = SKSpriteNode(imageNamed: "wood2")
        background.size = CGSize(width: size.width + 4, height: size.height + 4)
        background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        background.zPosition = 12
        
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -3 , y: -3, width: size.width + 6, height: size.height + 6), cornerRadius: size.height/5).cgPath
        shape.position =  CGPoint(x: -background.frame.width/2 + 2 , y: -background.frame.width/2 + 2)
        shape.glowWidth = 2
        shape.lineWidth = 3
        shape.strokeColor = SKColor.red()
        shape.fillColor = SKColor.clear()
        //shape.fillColor = self.color
        shape.zPosition = 11
        //shape.setScale(0.5)
        background.addChild(shape)
        
        let myLabel = SKLabelNode(fontNamed:"Ariel")
        myLabel.text = myValue
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x: background.frame.midX - (background.frame.midX/20) , y: background.frame.midY - (background.frame.midY/3))
        myLabel.fontColor = UIColor.black()
        myLabel.zPosition = 12
        shape.addChild(myLabel)
        
        if myPoints > 0 {
            let myPointsLabel = SKLabelNode(fontNamed:"Ariel")
            myPointsLabel.text =  String(myPoints)
            myPointsLabel.fontSize = 12;
            myPointsLabel.position = CGPoint(x: shape.frame.width - (23), y: 4)
            myPointsLabel.fontColor = UIColor.black()
            myPointsLabel.zPosition = 12
            shape.addChild(myPointsLabel)
        }
        
        let redTex:SKTexture = myView.texture(from: background)!
        self.texture = redTex
        
        //self.runAction(SKAction.playSoundFileNamed("Click", waitForCompletion: false))
    }
    
    
    
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func touched(_ point: CGPoint) {
    }
    
}
