//
//  GameScene.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/7.
//  Copyright (c) 2016 programus. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
  let panel = BackPanel()
  var balls = [Ball]()
  var motionManager:CMMotionManager!
  var g:CGFloat!
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    g = abs(physicsWorld.gravity.dy)
    self.addChild(panel)
    panel.position = CGPoint(x: 0, y: 0)
//    panel.fillBoard()
    panel.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVectorMake(0, CGFloat(Board.height)), duration: 1)))
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    for touch in touches {
      let ball = Ball(radius: Const.BallRadius)
      balls.append(ball)
      self.addChild(ball)
      ball.position = touch.locationInNode(self)
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    updateGravity()
    panel.update()
    for ball in balls {
      ball.update()
    }
  }
  
  func updateGravity() {
    if motionManager == nil {
      motionManager = CMMotionManager()
      motionManager.deviceMotionUpdateInterval = 0.0125
      motionManager.startDeviceMotionUpdates()
    }
    
    if let deviceMotion = motionManager.deviceMotion {
      let gravity = deviceMotion.gravity
      let userAcceleration = deviceMotion.userAcceleration
      physicsWorld.gravity = CGVectorMake(CGFloat(gravity.x + userAcceleration.x) * g, CGFloat(gravity.y + userAcceleration.y) * g)
    }
  }
  
  deinit {
    if let m = motionManager {
      m.stopDeviceMotionUpdates()
    }
  }
}
