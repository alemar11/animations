//
//  DisplayLink.swift
//  Animations
//
//  Created by Alessandro Marzoli on 26/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

protocol DisplayUpdateReceiver: class {
  func displayWillUpdate(deltaTime: CFTimeInterval)
}

class DisplayUpdateNotifier {
  weak var listener: DisplayUpdateReceiver?
  internal var displayLink: CADisplayLink? = nil
  internal var lastTime: CFTimeInterval = 0.0 /// Tracks the timestamp from the previous displayLink call
  
  init(listener: DisplayUpdateReceiver) {
    self.listener = listener
    startDisplayLink()
  }
  
  deinit {
    stopDisplayLink()
  }
  
  private func startDisplayLink() {
    guard displayLink == nil else { return }
    
    displayLink = CADisplayLink(target: self, selector: #selector(linkUpdate))
    displayLink?.add(to: .main, forMode: .common)
    lastTime = 0.0
  }
  
  /// Invalidates and destroys the current display link. Resets timestamp var to zero
  private func stopDisplayLink() {
    displayLink?.invalidate()
    displayLink = nil
    lastTime = 0.0
  }
  
  /// Notifier function called by display link. Calculates the delta time and passes it in the delegate call.
  @objc private func linkUpdate() {
    guard let displayLink = displayLink else { return }
    
    let currentTime = displayLink.timestamp
    let delta: CFTimeInterval = currentTime - lastTime
    lastTime = currentTime
    listener?.displayWillUpdate(deltaTime: delta)
  }
}
