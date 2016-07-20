//
//  Constants.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/13.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory : OptionSetType {
  let rawValue: UInt32
  
  static let None       = PhysicsCategory(rawValue: 0)
  static let Ball       = PhysicsCategory(rawValue: 1 << 0)
  static let BoardBody  = PhysicsCategory(rawValue: 1 << 1)
  static let BoardEdge  = PhysicsCategory(rawValue: 1 << 2)
}

struct Const {
  static let ScreenSize = UIScreen.mainScreen().bounds.size
  static let BallRadius = Const.ScreenSize.width * 0.03
}