//
//  GameViewController.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/7.
//  Copyright (c) 2016 programus. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    if let scene = GameScene(fileNamed:"GameScene") {
      // Configure the view.
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      scene.size = Const.ScreenSize
      scene.scaleMode = .AspectFill
      scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      
      skView.presentScene(scene)
    }
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return .AllButUpsideDown
    } else {
      return .All
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
