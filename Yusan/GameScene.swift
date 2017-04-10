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
    case panLeft = 8
    case panRight = 16
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let worldNode: SKNode = SKNode()
    
    var playerChar: PlayerController!
    var ground: SKSpriteNode!
    var dStickBase: SKSpriteNode!
    var dStickCirc: SKSpriteNode!
    var movementPane: SKSpriteNode!
    var panningPanRight: SKSpriteNode!
    var panningPanLeft: SKSpriteNode!
    var jumpingPane: SKSpriteNode!
    var jumpBuBase: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    let HALF_CIRCLE_RADIANS = 1.57079633
    var stickMoving: Bool = false
    var jumping: Bool = false

    
    
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        backgroundColor = SKColor.yellow
        anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        
        //Ground
//      ground = RBStaticGround(size: CGSize(width: view.frame.width, height: 20))
//      ground = SKSpriteNode(texture: nil, color: UIColor.black, size: CGSize.init(width: view.frame.width*4, height: 20))
//      ground.position = CGPoint.init(x: view.frame.width/2, y: 10)
        
        addChild(worldNode)
        
        
        //Character
        playerChar = PlayerController()
        playerChar.position = CGPoint.init(x: 10, y: 50)
 //     playerChar = PlayerController()
        
        
        //DStick
        dStickBase = SKSpriteNode(texture: nil, color: UIColor.gray, size: CGSize.init(width: 50, height: 50))
        dStickCirc = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: CGSize.init(width: 30, height: 30))
        movementPane = SKSpriteNode(texture: nil, color: UIColor.white, size: CGSize.init(width: view.frame.width, height: view.frame.height))
        
        panningPanLeft = SKSpriteNode(texture: nil, color: UIColor.darkGray, size: CGSize.init(width: view.frame.width/3, height: view.frame.height*2))
        panningPanRight = SKSpriteNode(texture: nil, color: UIColor.darkGray, size: CGSize.init(width: view.frame.width/3, height: view.frame.height*2))
        
        
        
        //Jump Button
        jumpBuBase = SKSpriteNode(texture: nil, color: UIColor.gray, size: dStickBase.size)
        jumpButton = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: dStickCirc.size)
        jumpingPane = SKSpriteNode(texture: nil, color: UIColor.white, size: CGSize.init(width: view.frame.width, height: view.frame.height))

        
        addChild(panningPanLeft)
        panningPanLeft.position = CGPoint(x: 0 - view.frame.width + panningPanLeft.size.width/2, y: 0)
        panningPanLeft.zPosition = -1
        addChild(panningPanRight)
        panningPanRight.position = CGPoint(x: 0 + view.frame.width - panningPanRight.size.width/2, y: 0)
        panningPanRight.zPosition = -1
        
        panningPanRight.alpha = 0.5
        panningPanLeft.alpha = 0.5
        
    
        
        
        
        
        addChild(movementPane)
        movementPane.position = CGPoint(x: 0 - view.frame.width/2, y: 0 - view.frame.height/2)
        movementPane.zPosition = -10
        addChild(dStickBase)
        dStickBase.position = CGPoint(x: -view.frame.width/2 - 80, y: 60)
        dStickBase.zPosition = 1
        addChild(dStickCirc)
        dStickCirc.position = dStickBase.position
        dStickCirc.zPosition = 2
        
        dStickCirc.alpha = 0
        dStickBase.alpha = 0

        
        worldNode.addChild(playerChar)
        playerChar.zPosition = 0
        
        addChild(jumpingPane)
        jumpingPane.position = CGPoint(x: 0 + view.frame.width/2, y: 0 - view.frame.height/2)
        jumpingPane.zPosition = -10
        addChild(jumpBuBase)
        jumpBuBase.position = CGPoint(x: view.frame.width - 80, y: 60)
        addChild(jumpButton)
        jumpButton.position = jumpBuBase.position
        
        jumpButton.alpha = 0
        jumpBuBase.alpha = 0
        
        //STARTINGGROUND
        
        var startingGroundData: [String:String] = ["BodyType": "square", "Location": "{-300, -150}", "PlaceMultiplesOnX": "25"]
        
        var startingGround = ObjectController(theDict: startingGroundData)
        worldNode.addChild(startingGround)
        startingGround.zPosition = -2
        
        
        //PLATFORM
        
        var platformData: [String:String] = ["BodyType": "square", "Location": "{0, 40}", "PlaceMultiplesOnX": "1"]

        
        let platform = ObjectController(theDict: platformData)
        addChild(platform)
        platform.zPosition = 0
            
            
        
        //GROUND
        
  //      var groundData: [String:String] = ["Bodytype": "square", "Location": "{"]
        
        
        
        let newLocation: CGPoint = CGPoint.init(x: playerChar.position.x, y: playerChar.position.y + 100)
        let moveUp: SKAction = SKAction.move(to: newLocation, duration: 1)
        moveUp.timingMode = .easeInEaseOut
        
        let wait: SKAction = SKAction.wait(forDuration: 1)
        let seq: SKAction = SKAction.group([wait, moveUp])
        playerChar.run(seq)
        
        
       /*
        let spawnPlatform: SKAction = SKAction.run {
            spawnAPlatform()
        }
        let delay:SKAction = SKAction.wait(forDuration: 1.5)
        let spawnSeq:SKAction = SKAction.sequence([spawnPlatform, delay])
        let spawnSeqForever: SKAction = SKAction.repeatForever(spawnSeq)
        self.run(spawnSeqForever)
        
        let moveRight:SKAction = SKAction.moveBy(x: -playerChar.playerSpeedX*2, y: 0, duration: 0.2)
        let removePlatform:SKAction = SKAction.removeFromParent()
        let moveRightandRemove:SKAction = SKAction.sequence([moveRight, removePlatform])
        
 */
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
            
            
            let fadeInStick: SKAction = SKAction.fadeAlpha(to: 1, duration: 0.1)
            
            //DSTICK
            
            if (movementPane.frame.contains(location)) {
                
                dStickCirc.alpha = 0.5
                dStickBase.alpha = 0.5
                stickMoving = true
                print("moving")
                
                if (dStickCirc.frame.contains(location)) {
                    dStickBase.run(fadeInStick)
                    dStickCirc.run(fadeInStick)
                    
                } else {
                    dStickBase.position = location
                    dStickCirc.position = dStickBase.position
                    dStickBase.run(fadeInStick)
                    dStickCirc.run(fadeInStick)
                
                }
                
            } else {
                stickMoving = false
                
            }
            
            
            //JUMP BUTTON
            if (jumpingPane.frame.contains(location)) {
                
                jumpBuBase.alpha = 0.5
                jumpButton.alpha = 0.5
                jumping = true
                print("jumping")

                if (jumpButton.frame.contains(location)) {
                    jumpBuBase.run(fadeInStick)
                    jumpButton.run(fadeInStick)
                    
                } else {
                    jumpBuBase.position = location
                    jumpButton.position = jumpBuBase.position
                    jumpBuBase.run(fadeInStick)
                    jumpButton.run(fadeInStick)
                }
                
                playerChar.jump()
        
            } else {
                jumping = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            
            if (stickMoving == true) {
            
                let v = CGVector(dx: location.x - dStickBase.position.x, dy: location.y - dStickBase.position.y)
                let angle = atan2(v.dy, v.dx)
                let deg = angle * CGFloat(180/M_PI)
            
            
                let length: CGFloat = dStickBase.frame.size.height/2
                let xDist: CGFloat = sin (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
                let yDist: CGFloat = cos (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
            
            
            
                //stops dstick from going out too far.
                
                if (dStickBase.frame.contains(location)) {
                    dStickCirc.position = location
                    
                } else {
                    dStickCirc.position = CGPoint(x: dStickBase.position.x - xDist, y: dStickBase.position.y + yDist)
                }
                
                
                //Setting up player Speed
                
                let multiplier: CGFloat = 0.1
                playerChar.playerSpeedX = v.dx * multiplier
                playerChar.modXSpeedAndScale()
            
                    
                    
            }
            
                
                
//              playerSpeedY = v.dy * multiplier
               // playerChar.modXSpeedAndScale()
                
                
                
                // end stick active
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        resetJoyStick()
        resetJumpButton()
        
        
        if (stickMoving == true) {
            
            //Stops the player when the stick is
            playerChar.playerSpeedX = 0
          
            
        } else if (stickMoving == false){
            
            //Assumes let go of a button
            
            
        }
    }
    
    
    
    func resetJoyStick() {
        
        let moveBack:SKAction = SKAction.move(to: dStickBase.position, duration: 0.1)
        moveBack.timingMode = .easeOut
        dStickCirc.run(moveBack)
        
        //Fade the dstick out when the player is not touching the screen
        
        let fadeStick:SKAction = SKAction.fadeAlpha(to: 0, duration: 0.3)
        dStickCirc.run(fadeStick)
        dStickBase.run(fadeStick)
        
    }
    
    func resetJumpButton() {
        
        let moveBack:SKAction = SKAction.move(to: jumpBuBase.position, duration: 0.1)
        moveBack.timingMode = .easeOut
        jumpButton.run(moveBack)
        
        //Fade the dstick out when the player is not touching the screen
        
        let fadeStick:SKAction = SKAction.fadeAlpha(to: 0, duration: 0.3)
        jumpButton.run(fadeStick)
        jumpBuBase.run(fadeStick)
        
    }
    
    
    
    
    
    
    //
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    //    }
    //
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        if ( self.isPaused == false) {
        
            playerChar.update()
    /*
            if (panningPanRight.frame.contains(playerChar)) {
                let moveRight:SKAction = SKAction.moveBy(x: -playerChar.playerSpeedX*2, y: 0, duration: 0.2)
                worldNode.run(moveRight)
                
            }
            
            if (panningPanLeft.frame.contains(playerChar)) {
                let moveLeft:SKAction = SKAction.moveBy(x: playerChar.playerSpeedX, y: 0, duration: 0.2)
                
                
            }
    */
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue && contact.bodyB.categoryBitMask == BodyType.ground.rawValue) {
            
            //print("bodyA was out player and bodyB was the ground")
            
            if let character = contact.bodyA.node as? PlayerController {
                
               character.stopJumpFromPlatform()
                
                
            }
        } else if (contact.bodyB.categoryBitMask == BodyType.player.rawValue && contact.bodyA.categoryBitMask == BodyType.ground.rawValue) {
            
            //print("bodyB was out player and bodyA was the ground")
            
            if let character = contact.bodyB.node as? PlayerController {
                
                character.stopJumpFromPlatform()
                
                
                
        
                
            }
        }
        
        
        
        
        
        
        
    }
}
