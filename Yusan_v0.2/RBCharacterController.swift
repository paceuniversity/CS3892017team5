//
//  RBCharacterController.swift
//  Yusan_v0.2
//
//  Created by RajKieran Basu on 4/2/17.
//  Copyright © 2017 RajKieran Basu. All rights reserved.
//

import Foundation
import SpriteKit

class RBCharacterController: SKSpriteNode {
    
    let MOVE_SPEED = 20.0
    var currentMoveSpeed: Double!
    let JUMP_YCOMPONENT = 10.0
    
//    init() {
//        super.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 32, height: 45))
//        
//    }
//    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//
//    func charJump() {
//        let jump = SKAction.applyForce(CGVector(dx: currentMoveSpeed, dy: JUMP_YCOMPONENT), duration: 1.0)
//        run(jump)
//        
//    }
}
