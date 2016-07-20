//
//  BackPanel.swift
//  Fall Catch Hit
//
//  Created by Programus on 16/7/12.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation
import SpriteKit

class BackPanel : SKNode {
  static var gap:CGFloat {
    get {
     return CGFloat(Board.height * (2.5 + drand48() * 4))
    }
  }
  static let top = Const.ScreenSize.height
  static let bottom = -BackPanel.top
  static let width = Const.ScreenSize.width
  
  func fillBoard() {
    while self.children.count <= 0 || self.children[self.children.count - 1].position.y + self.position.y > BackPanel.bottom {
      self.update()
    }
  }
  
  func update() {
    if self.children.count > 1 {
      let first = self.children[0]
      if first.position.y + self.position.y > BackPanel.top {
        first.removeFromParent()
      }
      let last = self.children[self.children.count - 1]
      if last.position.y + self.position.y > BackPanel.bottom {
        self.spawnBoardBelow(last.position.y)
      }
    } else if self.children.count > 0 {
      self.spawnBoardBelow(self.children[0].position.y)
    } else {
      self.spawnBoardBelow(BackPanel.top)
    }
  }
  
  func spawnBoardBelow(y:CGFloat) {
    let line = SKNode()
    line.position.x = 0
    
    let board = Board()
    line.position.y = y - BackPanel.gap
    board.position.y = 0
    board.position.x = CGFloat(drand48() - 0.5) * BackPanel.width
    line.addChild(board)
    if board.position.x - CGFloat(board.width) < BackPanel.width / -2.0 {
      let twin = Board(width: board.width)
      twin.position.x = board.position.x + BackPanel.width
      twin.position.y = 0
      line.addChild(twin)
    } else if board.position.x + CGFloat(board.width) > BackPanel.width / 2.0 {
      let twin = Board(width: board.width)
      twin.position.x = board.position.x - BackPanel.width
      twin.position.y = 0
      line.addChild(twin)
    }
    self.addChild(line)
  }
}