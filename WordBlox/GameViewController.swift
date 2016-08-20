//
//  GameViewController.swift
//  NSTimerTest
//
//  Created by Richard Lowe on 16/02/2016.
//  Copyright (c) 2016 Richard Lowe. All rights reserved.
//

import AVFoundation
import SpriteKit
import UIKit

/*============================================================*/
/*============================================================*/
/*============================================================*/

protocol MenuSceneDelegate {
    func loadMainScene()
    func loadGameScene()
    func loadWordFinderScene()
    func loadAnagramScene()
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

let mainFont = "ChalkboardSE-Regular"
var musicPlayer:AVAudioPlayer!

class GameViewController: UIViewController, MenuSceneDelegate {
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print ("\(view.frame)")
        
        loadMainScene()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        musicPlayer = setupAudioPlayerWithFile("bg_country", type: "mp3")
        musicPlayer.numberOfLoops = -1
        //musicPlayer.play()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        //        print ("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
        
        let skView = self.view as! SKView
        if let scene = skView.scene {
            if scene.size != self.view.bounds.size {
                scene.size = self.view.bounds.size
            }
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer  {
        let url = Bundle.main.url(forResource: file as String, withExtension: type as String)
        //let url = Bundle.main.urlForResource(file as String, withExtension: type as String)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    func loadMainScene() {
        print ("GameViewController: loadMainScene")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        // Configure the scene
        let menuScene = MainScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        
        skView.presentScene(menuScene)

        menuScene.menuSceneDelegate = self
        
    }
    
    func loadGameScene() {
        print ("GameViewController: loadGameScene")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
        
        skView.ignoresSiblingOrder = true
        
        let menuScene = GameScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        
        skView.presentScene(menuScene)
        
        menuScene.menuSceneDelegate = self
        
    }
    
    func loadWordFinderScene() {
        print ("GameViewController: loadWordFinderScene")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.ignoresSiblingOrder = true
        
        let menuScene = WordFinderScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        
        skView.presentScene(menuScene)
        
        menuScene.menuSceneDelegate = self
        
    }
    
    func loadAnagramScene() {
        
        print ("GameViewController: loadAnagramScene")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.ignoresSiblingOrder = true
        
        let menuScene = AnagramScene(size: skView.bounds.size)
        menuScene.scaleMode = .aspectFill
        
        skView.presentScene(menuScene)
        
        menuScene.menuSceneDelegate = self
        
    }

    
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
