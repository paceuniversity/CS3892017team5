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
        
    //CREATE CHILD OBJECTS OF TYPE SPECIFIED IN DICT
        
        for i in stride(from: 0, to: amount, by: 1){
            
            let objectSprite: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.black, size: CGSize.init(width: 160, height: 40))
            self.addChild(objectSprite)
            objectSprite.position = CGPoint.init(x: objectSprite.size.width * CGFloat(i), y: 0)
            
            if (theDict["BodyType"] == "square") {
                objectSprite.physicsBody = SKPhysicsBody(rectangleOf: objectSprite.size)
                
                objectSprite.physicsBody!.isDynamic = false
                objectSprite.physicsBody!.categoryBitMask = BodyType.ground.rawValue
                objectSprite.physicsBody!.restitution = 0
                
            }
        }
    }
}
