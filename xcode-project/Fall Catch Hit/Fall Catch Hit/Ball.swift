//
//  Ball.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/13.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKNode {
  var body: SKShapeNode
  
  init(radius: CGFloat) {
    body = SKShapeNode(circleOfRadius: radius)
    super.init()
    body.position = CGPoint(x: 0, y: 0)
    body.fillColor = UIColor.blueColor()
    body.strokeColor = UIColor.clearColor()
    setupPhysicsBody()
    addChild(body)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupPhysicsBody() {
    self.physicsBody = SKPhysicsBody(circleOfRadius: body.frame.size.width / 2)
    self.physicsBody?.affectedByGravity = true
    self.physicsBody?.usesPreciseCollisionDetection = true
    self.physicsBody?.dynamic = true
    self.physicsBody?.restitution = 0
    self.physicsBody?.categoryBitMask = PhysicsCategory.Ball.rawValue
    self.physicsBody?.collisionBitMask = PhysicsCategory.BoardEdge.rawValue | PhysicsCategory.BoardBody.rawValue
    self.physicsBody?.contactTestBitMask = PhysicsCategory.BoardEdge.rawValue | PhysicsCategory.BoardBody.rawValue 
  }
  
  func update() {
    if abs(self.position.y) > UIScreen.mainScreen().bounds.height {
      self.removeFromParent()
    }
    
    if self.position.x * 2 + body.frame.size.width < -Const.ScreenSize.width {
      self.position.x = (Const.ScreenSize.width + body.frame.size.width) / 2.0
    } else if self.position.x * 2 - body.frame.size.width > Const.ScreenSize.width {
      self.position.x = (Const.ScreenSize.width + body.frame.size.width) / -2.0
    }
  }
}