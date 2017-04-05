//
//  GameViewController.swift
//  Yusan_v0.2
//
//  Created by RajKieran Basu on 4/2/17.
//  Copyright © 2017 RajKieran Basu. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    var scene: GameScene!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Configure the view
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
           // if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.size = view.bounds.size
                // Present the scene
                view.presentScene(scene)
        }
    }
}
    

