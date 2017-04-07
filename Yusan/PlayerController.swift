//
//  PlayerController.swift
//  Yusan
//
//  Created by RajKieran Basu on 4/5/17.
//  Copyright © 2017 Pace CS 389 2017 Team 5. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerController: SKSpriteNode {
    
    
    var currentMoveSpeed: Double!
    var playerSpeedX: CGFloat = 0.0
    var playerSpeedY: CGFloat = 0.0
    var maxSpeed: CGFloat = 10
    
    var runAction:SKAction?
    
    
    
    init() {
        super.init(texture: nil, color: UIColor.orange, size: CGSize.init(width: 40, height: 40))
        
        
//        var body: SKPhysicsBody = SKPhysicsBody(circleOfRadius: 20)
//        body.isDynamic = true
//        body.affectedByGravity = true
//        body.allowsRotation = false
//        
//        body.categoryBitMask = BodyType.player.rawValue
//        
//        body.contactTestBitMask = BodyType.ground.rawValue
//        
//        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Player Speed
    
    func modXSpeedAndScale() {
        if (playerSpeedX > maxSpeed) {
            playerSpeedX  = maxSpeed
        } else if (playerSpeedX < -maxSpeed) {
            playerSpeedX = -maxSpeed
        }
        
        if (playerSpeedX > 0) {
            self.xScale = 1
        } else {
            self.xScale = -1
        }
    }
}
