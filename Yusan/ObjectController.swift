//
//  ObjectController.swift
//  Yusan
//
//  Created by RajKieran Basu on 4/9/17.
//  Copyright © 2017 Pace CS 389 2017 Team 5. All rights reserved.
//

import Foundation
import SpriteKit



class ObjectController: SKNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    //INITIALIZE
    
    init(theDict:Dictionary<String, String>) {
        super.init()
    
        
    //LOG THE FORMAT OF DICT
        
        print(theDict)
        let location: CGPoint = CGPointFromString(theDict["Location"]!)
        
        self.position = location
        
        let amount: Int! = Int(theDict["PlaceMultiplesOnX"]!)
//        let spacing: Int! = Int(theDict["Spacing"]!)
        let randomSpacing: Int! = Int(theDict["Spacing"]!)
        var spacing: CGFloat = 1
        
        
      //  var toPlayer:CGVector!
        
     //   let distanceTo: CGFloat!
        
        
        
        
        
        


//        let randomHeight: CGFloat = CGFloat(arc4random_uniform(4))
        
    //CREATE CHILD OBJECTS OF TYPE SPECIFIED IN DICT
        
        for i in stride(from: 0, to: amount, by: 1){
            
            if (randomSpacing == 1) {
               spacing = CGFloat(arc4random_uniform(2)) + 1
                print (spacing)
            }
            
            //GROUND
            
            let groundSprite: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.black, size: CGSize.init(width: 160, height: 900))
            groundSprite.alpha = 0.7
            groundSprite.position = CGPoint.init(x: groundSprite.size.width * CGFloat(i) * spacing, y: -groundSprite.size.height/2 + 150*spacing)
            
            //PLATFORM
            
            
            let objectSprite: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.black, size: CGSize.init(width: 160, height: 40))
            objectSprite.alpha = 0.7
            objectSprite.position = CGPoint.init(x: objectSprite.size.width * CGFloat(i) * spacing, y: 150*spacing)
           
            //DEAD
            let deadSprite: SKSpriteNode = SKSpriteNode(texture: nil, color: SKColor.blue, size: CGSize.init(width: 500, height: 50))
            deadSprite.position = CGPoint.init(x: deadSprite.size.width * CGFloat(i) * spacing, y: -deadSprite.size.height/2 + 150*spacing)
            
            //POLICE
            
            let policeSprite = SKSpriteNode.init(imageNamed: "Police_Entity")
            policeSprite.setScale(0.05)
            policeSprite.xScale = -0.05
            policeSprite.zPosition = -6

               // SKSpriteNode = SKSpriteNode.init(texture: nil, color: SKColor.blue, size: CGSize.init(width: 60, height: 120))
        //    policeSprite.alpha = 1.0
            
            
            
            
            
            
            //NPC
            
            
            let npcSprite: SKSpriteNode = SKSpriteNode.init(texture: nil, color: SKColor.green, size: CGSize.init(width: 80, height: 160))
            npcSprite.alpha = 0.7
            npcSprite.position = CGPoint.init(x: npcSprite.size.width * CGFloat(i) * spacing, y: 150)
            
            
            //BUILDING
            
            let buildingSprite: SKSpriteNode = SKSpriteNode.init(texture: nil, color: SKColor.init(red: 255, green: 237, blue: 0, alpha: 1.0), size: CGSize.init(width: 250, height: 700))
      //      buildingSprite.alpha = 0.7
            buildingSprite.position = CGPoint.init(x: buildingSprite.size.width * CGFloat(i) * spacing, y: 200)

            
            
            
            
            if (theDict["BodyType"] == "ground") {
                
                self.addChild(groundSprite)

                groundSprite.physicsBody = SKPhysicsBody(rectangleOf: groundSprite.size)
                
                groundSprite.physicsBody!.isDynamic = false
//                objectSprite.physicsBody!.collisionBitMask = 1
                groundSprite.physicsBody!.categoryBitMask = BodyType.ground.rawValue
                groundSprite.physicsBody!.restitution = 0
                
                print(randomSpacing)
            }
            
            if (theDict["BodyType"] == "platform") {
                
                
                
                self.addChild(objectSprite)

                    objectSprite.physicsBody = SKPhysicsBody(rectangleOf: objectSprite.size)
                    
                    objectSprite.physicsBody!.isDynamic = false
                    objectSprite.physicsBody!.categoryBitMask = BodyType.platform.rawValue
 //                   objectSprite.physicsBody!.collisionBitMask = 1
                    objectSprite.physicsBody!.restitution = 0
                
            
                
                var policeMan = CGFloat(arc4random_uniform(20))
                
                print("police: ", policeMan)
                
                if (policeMan > 14) {
                    policeSprite.position = CGPoint.init(x: 0, y: 70)
                    policeSprite.physicsBody = SKPhysicsBody(rectangleOf: policeSprite.size)
                    policeSprite.physicsBody!.collisionBitMask = 0
                    policeSprite.physicsBody!.isDynamic = false
                    policeSprite.physicsBody!.categoryBitMask = BodyType.police.rawValue
                    objectSprite.addChild(policeSprite)

                }

                
                
                
                

                
                }
            
            
            /*
            if (theDict["BodyType"] == "dead") {
                
                self.addChild(deadSprite)
                deadSprite.physicsBody = SKPhysicsBody(rectangleOf: deadSprite.size)
                deadSprite.physicsBody?.collisionBitMask = 1
                deadSprite.physicsBody!.isDynamic = false
                deadSprite.physicsBody!.categoryBitMask = BodyType.gameOver.rawValue
                //            npcSprite.physicsBody!.restitution = 0
                
                
            }
 
             */
            
            
            
            
            
            if (theDict["BodyType"] == "npc") {
                
                self.addChild(npcSprite)
                npcSprite.physicsBody = SKPhysicsBody(rectangleOf: npcSprite.size)
                npcSprite.physicsBody!.collisionBitMask = 0
                npcSprite.physicsBody!.isDynamic = false
                npcSprite.physicsBody!.categoryBitMask = BodyType.npc.rawValue
                //            npcSprite.physicsBody!.restitution = 0
                
                
            
            
        }
            
            
            
            if (theDict["BodyType"] == "building") {
                
   //             buildingSprite.anchorPoint = CGPoint.init(x:0, y:0)
                self.addChild(buildingSprite)
                buildingSprite.physicsBody = SKPhysicsBody(rectangleOf: buildingSprite.size)
              //  buildingSprite.physicsBody?.collisionBitMask = 0
                buildingSprite.physicsBody!.isDynamic = false
                buildingSprite.physicsBody!.categoryBitMask = BodyType.platform.rawValue
                //            npcSprite.physicsBody!.restitution = 0
                
                
            }
            
            
           /*
            if (theDict["BodyType"] == "police") {
                
                self.addChild(policeSprite)
                policeSprite.physicsBody = SKPhysicsBody(rectangleOf: policeSprite.size)
//                policeSprite.physicsBody?.collisionBitMask = 1
                policeSprite.physicsBody!.isDynamic = true
                policeSprite.physicsBody!.categoryBitMask = BodyType.police.rawValue
                //            npcSprite.physicsBody!.restitution = 0
                
                
                
                
                var weapon:SKSpriteNode = SKSpriteNode.init(texture: nil, color: SKColor.black, size: CGSize.init(width: 20, height: 20))
                weapon.physicsBody = SKPhysicsBody(rectangleOf: weapon.size)
                weapon.physicsBody?.isDynamic = true
                
                
//                let thrown:SKAction = SKAction.applyForce(<#T##force: CGVector##CGVector#>, duration: <#T##TimeInterval#>)
                let throwWeapon:SKAction = SKAction.run {
                    
                    self.addChild(weapon)
                    weapon.run(SKAction.applyImpulse(toPlayer, duration: 0.1))
                    weapon.run(SKAction.wait(forDuration: 2))
                    weapon.run(SKAction.removeFromParent())
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
        
    
        
        */
            
            
            
        }

    }
    // END INIT
    
    

    
    
    
    
    
}
