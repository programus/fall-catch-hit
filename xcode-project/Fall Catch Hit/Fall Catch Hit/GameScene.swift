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
  let moveUp = "MoveUp"
  let panel = BackPanel()
  
  var balls = [Ball]()
  var motionManager:CMMotionManager!
  var g:CGFloat!
  var initSpeed = CGFloat(1.0)
  var startTime: CFTimeInterval = 0
  var lastUpdateTime: CFTimeInterval = 0
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    g = abs(physicsWorld.gravity.dy)
    self.addChild(panel)
    panel.position = CGPoint(x: 0, y: 0)
//    panel.fillBoard()
    panel.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVectorMake(0, CGFloat(Board.height)), duration: 1)), withKey: moveUp)
    panel.speed = initSpeed
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
    updateSpeed(deltaTime(currentTime))
    panel.update()
    for ball in balls {
      ball.update()
    }
  }
  
  func deltaTime(currentTime: CFTimeInterval) -> CFTimeInterval {
    var delta: CFTimeInterval
    if startTime == 0 {
      delta = 0
      startTime = currentTime
      lastUpdateTime = currentTime
    } else {
      delta = currentTime - startTime
      lastUpdateTime = currentTime
    }
    return delta
  }
  
  func updateSpeed(delta: CFTimeInterval) {
    if let action = panel.actionForKey(moveUp) {
      action.speed = self.initSpeed + Const.BoardMaxSpeed - Const.BoardMaxSpeed * pow(2, CGFloat(delta) / -Const.BoardHalfAccTime)
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
