//
//  GameScene.swift
//  Yusan
//
//  Created by Hayden McClure on 4/3/17.
//  Copyright © 2017 Pace CS 389 2017 Team 5. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType:UInt32 {
    
    case player = 1
    case ground = 2
    case platform = 4
    case anotherBody2 = 8
    case anotherBody3 = 16
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playerChar: PlayerController!
    var ground: SKSpriteNode!
    var dStickBase: SKSpriteNode!
    var dStickCirc: SKSpriteNode!
    var jumpBuBase: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    let HALF_CIRCLE_RADIANS = 1.57079633
    var moving: Bool = false
    var jumping: Bool = false
    
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        //Ground
        //      ground = RBStaticGround(size: CGSize(width: view.frame.width, height: 20))
        ground = SKSpriteNode(texture: nil, color: UIColor.brown, size: CGSize.init(width: view.frame.width*4, height: 20))
        ground.position = CGPoint.init(x: view.frame.width/2, y: 10)
        
        
        //Character
        playerChar = PlayerController()
        playerChar.position = CGPoint.init(x: 10, y: 50)
 //       playerChar = PlayerController()
        
        
        //DStick
        dStickBase = SKSpriteNode(texture: nil, color: UIColor.cyan, size: CGSize.init(width: 50, height: 50))
        dStickCirc = SKSpriteNode(texture: nil, color: UIColor.blue, size: CGSize.init(width: 30, height: 30))
        
        //Jump Button
        jumpBuBase = SKSpriteNode(texture: nil, color: UIColor.gray, size: dStickBase.size)
        jumpButton = SKSpriteNode(texture: nil, color: UIColor.white, size: dStickCirc.size)
        
        
        addChild(dStickBase)
        dStickBase.position = CGPoint(x: -view.frame.width/2 - 80, y: 60)
        addChild(dStickCirc)
        dStickCirc.position = dStickBase.position
        
        addChild(playerChar)
        addChild(ground)
        
        addChild(jumpBuBase)
        jumpBuBase.position = CGPoint(x: view.frame.width - 80, y: 60)
        addChild(jumpButton)
        jumpButton.position = jumpBuBase.position
        
        //      var groundData: [String:String] = ["BodyType": "square", "Location": "{-500, -150}", "PlaceMultiplesOnX": "8"]
        
        //      let platform = Platform(theDict: groundData)
        //      addChild(platform)
        //      platform.zPosition = -1
        
        
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches) {
            let location = touch.location(in: self)
            
            if (dStickCirc.frame.contains(location)) {
                moving = true
                print("moving")
            } else {
                moving = false
            }
            if (jumpButton.frame.contains(location)) {
                jumping = true
                print("jumping")
            } else {
                jumping = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            
            let v = CGVector(dx: location.x - dStickBase.position.x, dy: location.y - dStickBase.position.y)
            let angle = atan2(v.dy, v.dx)
            let deg = angle * CGFloat(180/M_PI)
            
            
            let length: CGFloat = dStickBase.frame.size.height/2
            let xDist: CGFloat = sin (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
            let yDist: CGFloat = cos (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
            
            
            if (moving == true) {
                //              target!.position =  CGPoint(x: playerChar.position.x - xDist, y: playerChar.position.y + yDist)
                
                if (dStickBase.frame.contains(location)) {
                    dStickCirc.position = location
                    
                } else {
                    dStickCirc.position = CGPoint(x: dStickBase.position.x - xDist, y: dStickBase.position.y + yDist)
                }
                
            }
            
            //Speed
            
            let multiplier: CGFloat = 0.1
            playerChar.playerSpeedX = v.dx * multiplier
            playerChar.modXSpeedAndScale()
            
            
            
            // end stick active
            
            
//            if (jumping == true) {
//                playerChar.playerSpeedY = 10
//                let jump: SKAction = SKAction.applyForce(CGVector.init(dx: 0, dy: playerChar.playerSpeedY), duration: 1.0)
//                jump.timingMode = .easeOut
//                let fall: SKAction = SKAction.applyForce(CGVector.init(dx: 0, dy: -playerChar.playerSpeedY), duration: 1)
//                // jump.timingMode = .linear
//                fall.timingMode = .easeIn
//                playerChar.playerSpeedY = 0
//                run(jump)
//                run(fall)
////                playerChar.playerSpeedY = v.dy * multiplier
//                jumping = false
//            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (moving == true) {
            let moveBack:SKAction = SKAction.move(to: dStickBase.position, duration: 0.1)
            moveBack.timingMode = .easeOut
            
            dStickCirc.run(moveBack)
            
            playerChar.playerSpeedX = 0
        }
    }
    //
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    //    }
    //
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        playerChar.position = CGPoint.init(x: playerChar.position.x + playerChar.playerSpeedX, y: playerChar.position.y + playerChar.playerSpeedY)
        
        
        
        
        
    }
}
