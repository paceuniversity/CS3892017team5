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
    var maxSpeed: CGFloat = 8
    
    var jumpHeight: CGFloat = 0
    var maxJumpHeight: CGFloat = 25


    var isUsingUmbrella: Bool = false
    var isJumping: Bool = false

    
    var idleAction:SKAction?
    var runAction:SKAction?
    var jumpAction:SKAction?

    
    
    init() {
        super.init(texture: nil, color: UIColor.black, size: CGSize.init(width: 40, height: 40))
        
        
        var body: SKPhysicsBody = SKPhysicsBody(circleOfRadius: 20)
        body.isDynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        
        body.categoryBitMask = BodyType.player.rawValue
        
        body.contactTestBitMask = BodyType.ground.rawValue
        body.contactTestBitMask = BodyType.panLeft.rawValue
        body.contactTestBitMask = BodyType.panRight.rawValue
        
        body.restitution = 0
        
        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Player Speed
    
    func modXSpeedAndScale() {
       
        //PLAYER SPEED
        if (playerSpeedX > maxSpeed) {
            playerSpeedX = maxSpeed
        } else if (playerSpeedX < -maxSpeed) {
            playerSpeedX = -maxSpeed
        }
        //PLAYER DIRECTION
        if (playerSpeedX > 0) {
            self.xScale = 1
        } else {
            self.xScale = -1
        }
    }

    func update() {
        self.position = CGPoint.init(x: self.position.x + playerSpeedX, y: self.position.y + jumpHeight)
     
    }
    
    func startRun() {
        self.run(runAction!)
        
    }
    
    
    func useUmbrella() {
        
        isUsingUmbrella = true
        
        
        if (self.xScale == 1) {
            
            playerSpeedX = 8
        } else {
            playerSpeedX = -8
        }
        
        let callAgain:SKAction = SKAction.run {
            self.taperSpeed()
        }
        let wait:SKAction = SKAction.wait(forDuration: 1/60)
        let seq:SKAction = SKAction.sequence([wait, callAgain])
        let doAgain:SKAction = SKAction.repeat(seq, count: 40)
        let stop:SKAction = SKAction.run {
            self.stopUsingUmbrella()
        }
        let seq2:SKAction = SKAction.sequence([doAgain, stop])
        self.run(seq2)
        
    }
    
    func taperSpeed() {
        
        playerSpeedX = playerSpeedX*0.9
        
    }
    
    func stopUsingUmbrella() {
        
        playerSpeedX = 0
        isUsingUmbrella = false
        
    }
    
    
    func jump() {
        
        if (isJumping == false) {
        
        
        isJumping = true
 //       self.run(jumpAction!)
        
        
        jumpHeight = maxJumpHeight
            
        let callAgain:SKAction = SKAction.run {
            self.taperSpeed()
        }
        let wait:SKAction = SKAction.wait(forDuration: 1/60)
        let seq:SKAction = SKAction.sequence([wait, callAgain])
        let doAgain:SKAction = SKAction.repeat(seq, count: 30)
        let stop:SKAction = SKAction.run {
            self.stopJump()
        }
        let seq2:SKAction = SKAction.sequence([doAgain, stop])
        self.run(seq2)
            
        }
        
    }
    
    func taperJump() {
        
        jumpHeight = jumpHeight*0.9
        
    }
    
    func stopJump() {
        
        jumpHeight = 0
        isJumping = false
        
    }
    
    func stopJumpFromPlatform() {
        
        if (isJumping == true) {
            stopJump()
            
            
        }
        
        
    }
    
    
    
    
    
    
}
