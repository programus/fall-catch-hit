//
//  Board.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/7.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

class Board : SKNode {
  static let height = Double(Const.ScreenSize.height / 40.0)
  static let minWidth = Double(Board.height * 2.0)
  static let maxWidth = Double(Const.ScreenSize.width * 0.8)
  static let edgeWidth = 10.1
  
  let body:SKShapeNode!
  let edges:[SKShapeNode]
  let width:Double
  
  override convenience init() {
    // generate a random width
    let width = drand48() * (Board.maxWidth - Board.minWidth) + Board.minWidth
    self.init(width: width)
  }
  
  init(width:Double) {
    self.width = width
    // need a main body
    body = SKShapeNode(rect: CGRect(x: -width / 2, y: -Board.height / 2, width: width, height: Board.height))
    // and two edge
    let ledge = SKShapeNode(rect: CGRect(x: -Board.edgeWidth / 2, y: -Board.height / 2 + 3, width: Board.edgeWidth, height: Board.height - 6))
    ledge.position.x = CGFloat(-width + Board.edgeWidth) / 2
    let redge = SKShapeNode(rect: CGRect(x: -Board.edgeWidth / 2, y: -Board.height / 2 + 3, width: Board.edgeWidth, height: Board.height - 6))
    redge.position.x = CGFloat(width - Board.edgeWidth) / 2
    edges = [ledge, redge]
    super.init()
    
    addChild(body)
    for edge in edges {
      self.addChild(edge)
      edge.strokeColor = UIColor.clearColor()
      edge.fillColor = UIColor.redColor()
    }
    
    body.strokeColor = UIColor.clearColor()
    body.fillColor = UIColor.blackColor()
    
    setupPhysicsBodies()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupPhysicsBodies() {
    body.physicsBody = SKPhysicsBody(rectangleOfSize: self.body.frame.size)
    body.physicsBody?.affectedByGravity = false
    body.physicsBody?.categoryBitMask = PhysicsCategory.BoardBody.rawValue
    body.physicsBody?.dynamic = false
    body.physicsBody?.restitution = 0
    
    for edge in edges {
      edge.physicsBody = SKPhysicsBody(rectangleOfSize: edge.frame.size)
      edge.physicsBody?.affectedByGravity = false
      edge.physicsBody?.categoryBitMask = PhysicsCategory.BoardEdge.rawValue
      edge.physicsBody?.dynamic = false
      edge.physicsBody?.restitution = 1
    }
  }
}
