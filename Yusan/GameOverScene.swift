//
//  GameOverScene.swift
//  Yusan
//
//  Created by RajKieran Basu on 5/3/17.
//  Copyright © 2017 Pace CS 389 2017 Team 5. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        let myLabel = SKLabelNode(fontNamed: "Courier")
        myLabel.text = "Game Over"
        myLabel.fontSize = 45
        myLabel.position = CGPoint.init(x: self.frame.midX, y: self.frame.midY)
        
        addChild(myLabel)
        
        let continueLabel = SKLabelNode(fontNamed: "Courier")
        continueLabel.text = "Touch to continue.."
        continueLabel.fontSize = 20
        continueLabel.position = CGPoint.init(x: self.frame.midX, y: self.frame.midY - 60)
        
        addChild(continueLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let tryAgain = GameScene(fileNamed: "GameScene")
        tryAgain?.scaleMode = .aspectFill
        self.view?.presentScene(tryAgain!, transition: SKTransition.fade(withDuration: 0.5))

    }
    
    
}
