//
//  ViewController4.swift
//  Animations
//
//  Created by Alessandro Marzoli on 26/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
  let movableView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
  
  lazy var displayLink: CADisplayLink = {
    let displayLink = CADisplayLink(target: self, selector: #selector(update(link:)))
    displayLink.preferredFramesPerSecond = 60
    displayLink.add(to: .main, forMode: .common)
    return displayLink
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movableView.backgroundColor = .red
    print(movableView.center)
    view.addSubview(movableView)
    _ = displayLink
  }
  
  @objc func update(link: CADisplayLink) {
    var increment = 1
    guard view.frame.intersects(movableView.frame) else {
      displayLink.isPaused = true
      print("end")
      return
    }
    movableView.center.x += 1
  }
}
