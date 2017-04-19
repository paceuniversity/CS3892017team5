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
    

    var cam:SKCameraNode!
    let worldNode: SKNode = SKNode()
    let bg = SKSpriteNode.init(imageNamed: "Yusan_Background")
    let water = SKSpriteNode.init(imageNamed: "Water")

    
    
    var originNode: SKNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: 10, height: 10))
    var origin: CGPoint!
    var playerChar: PlayerController!
    var playerCurrentPos: CGPoint!
    var offset: CGPoint!
    
    var ground: SKSpriteNode!
    var dStickBase: SKSpriteNode!
    var dStickCirc: SKSpriteNode!
    var movementPane: SKSpriteNode!
    var panningPanRight: SKSpriteNode!
    var panningPanLeft: SKSpriteNode!
    var jumpingPane: SKSpriteNode!
    var stationaryPane: SKSpriteNode!
    var jumpBuBase: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    let HALF_CIRCLE_RADIANS = 1.57079633
    var stickMoving: Bool = false
    var jumping: Bool = false
    var panning: Bool = false
    
   

    
    
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        backgroundColor = SKColor.darkGray
        anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        bg.position = CGPoint.init(x: 0, y: 280)
        bg.setScale(1.5)
//        bg.yScale = 1.5
        addChild(bg)
        bg.zPosition = -10
//        bg.alpha = 1.0
       
        water.yScale = 0.4
        water.position = CGPoint.init(x: 0, y: -water.size.height*3/4)
        addChild(water)
        water.zPosition = -9
//        water.alpha = 0.9
        
        let wave1: SKAction = SKAction.moveBy(x: 0, y: 18, duration: 5)
            wave1.timingMode = .easeInEaseOut
        let wave2: SKAction = SKAction.moveBy(x: 0, y: -18, duration: 6)
            wave2.timingMode = .easeInEaseOut
        let wave: SKAction = SKAction.sequence([wave1, wave2])
        let waveForever: SKAction = SKAction.repeatForever(wave)

        water.run(waveForever)
        
        cam = SKCameraNode()
        self.camera = cam
        addChild(cam)
        cam.position = CGPoint(x: 0, y: 0)
        
        
        
        //WORLD NODE
        
        addChild(worldNode)
        worldNode.addChild(originNode)
        originNode.position = CGPoint.init(x: 0, y: 0)
        

        
        
        //CHARACTER
        
        playerChar = PlayerController()
        playerChar.position = CGPoint.init(x: 10, y: 50)
        
        
        //DSTICK
        
        dStickBase = SKSpriteNode(texture: nil, color: UIColor.gray, size: CGSize.init(width: 50, height: 50))
        dStickCirc = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: CGSize.init(width: 30, height: 30))
        movementPane = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: view.frame.width, height: view.frame.height))
        
        //PANNING
        
        
        panningPanLeft = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: view.frame.width*2/3, height: view.frame.height*2))
        panningPanRight = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: view.frame.width*2/3, height: view.frame.height*2))
//        stationaryPane = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: CGSize.init(width: view.frame.width*3/7, height: view.frame.height*2/3))
        
        
        
    /*
        panningPanLeft.physicsBody = SKPhysicsBody(rectangleOf: panningPanLeft.size)
        
        panningPanLeft.physicsBody!.isDynamic = false
        panningPanLeft.physicsBody!.categoryBitMask = BodyType.panLeft.rawValue
        panningPanLeft.physicsBody!.collisionBitMask = 0
        
        
        panningPanRight.physicsBody = SKPhysicsBody(rectangleOf: panningPanRight.size)
        
        panningPanRight.physicsBody!.isDynamic = false
        panningPanRight.physicsBody!.categoryBitMask = BodyType.panRight.rawValue
        panningPanLeft.physicsBody!.collisionBitMask = 0
        
   */
        
        
        //JUMP BUTTON
        
        jumpBuBase = SKSpriteNode(texture: nil, color: UIColor.gray, size: dStickBase.size)
        jumpButton = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: dStickCirc.size)
        jumpingPane = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize.init(width: view.frame.width, height: view.frame.height))

        
        
        
//        cam.addChild(stationaryPane)
//        stationaryPane.position = cam.position
//        stationaryPane.zPosition = -1
        
        cam.addChild(panningPanLeft)
        panningPanLeft.position = CGPoint(x: 0 - view.frame.width + panningPanLeft.size.width/2, y: 0)
        panningPanLeft.zPosition = -1
       
        cam.addChild(panningPanRight)
        panningPanRight.position = CGPoint(x: 0 + view.frame.width - panningPanRight.size.width/2, y: 0)
        panningPanRight.zPosition = -1
        
        panningPanRight.alpha = 0.5
        panningPanLeft.alpha = 0.5
        
    
        
        
        
        
        cam.addChild(movementPane)
        movementPane.position = CGPoint(x: cam.position.x - view.frame.width/2, y: cam.position.y - view.frame.height/2)
        movementPane.zPosition = -10
        cam.addChild(dStickBase)
        dStickBase.position = CGPoint(x: -view.frame.width/2 - 80, y: 60)
        dStickBase.zPosition = 1
        cam.addChild(dStickCirc)
        dStickCirc.position = dStickBase.position
        dStickCirc.zPosition = 2
        
        dStickCirc.alpha = 0
        dStickBase.alpha = 0
// ADD PLAYER
        worldNode.addChild(playerChar)
        playerChar.zPosition = 0
        
        cam.addChild(jumpingPane)
        jumpingPane.position = CGPoint(x: cam.position.x + view.frame.width/2, y: cam.position.y - view.frame.height/2)
        jumpingPane.zPosition = -10
        cam.addChild(jumpBuBase)
        jumpBuBase.position = CGPoint(x: view.frame.width - 80, y: 60)
        cam.addChild(jumpButton)
        jumpButton.position = jumpBuBase.position
        
        jumpButton.alpha = 0
        jumpBuBase.alpha = 0
        
        //STARTINGGROUND
        
        var startingGroundData: [String:String] = ["BodyType": "square", "Location": "{-2000, -700}", "PlaceMultiplesOnX": "100", "Spacing": "0"]
        
        var startingGround = ObjectController(theDict: startingGroundData)
        worldNode.addChild(startingGround)
        startingGround.zPosition = -2
        
        
        //PLATFORM
        
        var platformData: [String:String] = ["BodyType": "square", "Location": "{-300, -550}", "PlaceMultiplesOnX": "1", "Spacing": "0"]
        var platform2Data: [String:String] = ["BodyType": "square", "Location": "{0, -550}", "PlaceMultiplesOnX": "30", "Spacing": "1"]


        
        let platform = ObjectController(theDict: platformData)
        worldNode.addChild(platform)
        platform.zPosition = 0
        
        let platform2 = ObjectController(theDict: platform2Data)
        worldNode.addChild(platform2)
        platform2.zPosition = 0

            
        
        var panLeftData: [String:String] = ["Bodytype": "panleft"]
        
        
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
            
            
            //START STICK ACTIVE
            
            if (stickMoving == true) {
            
                let v = CGVector(dx: location.x - dStickBase.position.x, dy: location.y - dStickBase.position.y)
                let angle = atan2(v.dy, v.dx)
//                let deg = angle * CGFloat(180/M_PI)
            
            
                let length: CGFloat = dStickBase.frame.size.height/2
                let xDist: CGFloat = sin (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
                let yDist: CGFloat = cos (angle - CGFloat(HALF_CIRCLE_RADIANS)) * length
            
            
            
                //stops dstick from going out too far.
                
                if (dStickBase.frame.contains(location)) {
                    dStickCirc.position = location
                    
                } else {
                    dStickCirc.position = CGPoint(x: dStickBase.position.x - xDist, y: dStickBase.position.y + yDist)
                }
                
                
                //SETTING UP PLAYER SPEED
                
                let multiplier: CGFloat = 0.1
                playerChar.playerSpeedX = v.dx * multiplier
                playerChar.modXSpeedAndScale()
            
                    
                    
            }
            
                
                
//              playerSpeedY = v.dy * multiplier
               // playerChar.modXSpeedAndScale()
                
                
                
                // END STICK ACTIVE
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
    


    
    func moveWorld() {
        let moveNode: SKAction = SKAction.moveBy(x: -offset.x/22, y: -offset.y/20, duration: 0.2)
//        let moveNode2: SKAction = SKAction.move(to: playerCurrentPos, duration: 0.2)
        
  //Don't let the world offset be greater than the node offset!!
        let moveWorld:SKAction = SKAction.moveBy(x: offset.x/22, y: offset.y/40, duration: 0.2)
        let moveBackGround:SKAction = SKAction.moveBy(x: offset.x/200, y: offset.y/200, duration: 0.2)
        let moveWater:SKAction = SKAction.moveBy(x: offset.x/100, y: offset.y/190, duration: 0.2)
        




//        let moveWorld2:SKAction = SKAction.moveBy(x: -playerChar.playerSpeedX, y: offset.y/20, duration: 0.2)
//        let movecam:SKAction = SKAction.moveBy(x: -playerChar.playerSpeedX, y: offset.y/40, duration: 0.2)
//        let movecam2:SKAction = SKAction.moveBy(x: 0, y: offset.y/20, duration: 0.2)
//        -playerChar.position.y - origin.y

//        var viewOffsetX: CGFloat!
//        var viewOffsetY: CGFloat!
//        var moveToPos: CGPoint!
//        let maxL:CGPoint =  worldNode.convert(playerChar.position, to: scene!)
        
        /*
        
        if (stationaryPane.frame.contains(playerCurrentPos) ) {
            panning = false
            originNode.position = playerCurrentPos
        } else {
            panning = true
            
            
            if (abs(maxL.x) < 300) {
 
 */
            worldNode.run(moveWorld)
//          cam.run(movecam)
            originNode.run(moveNode)
            bg.run(moveBackGround)
            water.run(moveWater)
/*          } else {
                print("too far")
                
                originNode.run(moveNode2)
                cam.run(movecam)
                worldNode.run(moveWorld2)
                
            }
 
        }
        
        */
        
    }
    
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        if ( self.isPaused == false) {
        
            playerChar.update()
            
            playerCurrentPos = playerChar.position
//            origin = worldNode.convert(originNode.position, from: originNode)
            offset = CGPoint.init(x: originNode.position.x - playerChar.position.x, y: originNode.position.y - playerChar.position.y)
//            if (stationaryPane.frame.contains(playerCurrentPos)) {
//
//            } else {
//                print(offset)
//                print("origin: ", origin)
//                print("playerpos: ", playerCurrentPos)
//                print("worldpos: ", worldNode.position)
//                print("campos: ", cam.position)
//                print(playerChar.playerSpeedX)
//                print(playerChar.playerSpeedY)
//
//
//
//                print("panepos: ", stationaryPane.position)
//
//
//            }
            self.moveWorld()
            
 
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
