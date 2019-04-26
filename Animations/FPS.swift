//
//  FPS.swift
//  Animations
//
//  Created by Alessandro Marzoli on 26/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import Foundation
import UIKit

final class FPS {
  let refreshRate: Double
  let fps: Int
  private var firstTime = 0.0
  private var lastTime = 0.0
  
  lazy var displayLink: CADisplayLink = {
    let displayLink = CADisplayLink(target: self, selector: #selector(update(link:)))
    displayLink.preferredFramesPerSecond = self.fps
    displayLink.isPaused = true
    displayLink.add(to: .main, forMode: .common)
    return displayLink
  }()
  
  init(fps: Int = UIScreen.main.maximumFramesPerSecond) {
    self.fps = fps
    self.refreshRate = (Double(1) / Double(fps) * 10_000).rounded(.up) / 10
  }
  
  deinit {
    displayLink.invalidate()
  }
  
  func start() {
    guard displayLink.isPaused else { return }
    displayLink.isPaused = false
  }
  
  func pause() {
    guard !displayLink.isPaused else { return }
    displayLink.isPaused = true
    firstTime = 0.0
    lastTime = 0.0
  }
  
  @objc private func update(link: CADisplayLink) {
    if lastTime == 0.0 {
      firstTime = link.timestamp
      lastTime = link.timestamp
    }
    
    let currentTime = link.timestamp
    let elapsedTime = ((currentTime - lastTime) * 10_000).rounded(.up) / 10
    let totalElapsedTime = currentTime - firstTime
    
    if elapsedTime > refreshRate {
      print("Frame was dropped with elapsed time of \(elapsedTime) as \(totalElapsedTime)")
    }
    lastTime = link.timestamp
  }
}
