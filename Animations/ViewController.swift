//
//  ViewController.swift
//  Animations
//
//  Created by Alessandro Marzoli on 25/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let cv = CircleView(frame: CGRect(origin: .zero, size: CGSize(width: 350, height: 350)))
    view.addSubview(cv)
  }
}

final class CircleView: UIView {
  let fps = FPS(fps: 60)

  lazy var displayLink: CADisplayLink = {
    let displayLink = CADisplayLink(target: self, selector: #selector(update(link:)))
    displayLink.preferredFramesPerSecond = 60
    return displayLink
  }()
  
  let drawDuration: TimeInterval = 10.0
  var initialDrawTime: CFTimeInterval = 0.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    fps.start()
    setup()
  }
  
  var lastTime = 0.0
  var firstTime = 0.0
  @objc func update(link: CADisplayLink) {
    setNeedsDisplay()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    displayLink.add(to: .main, forMode: .common)
  }
  
  override func draw(_ rect: CGRect) {
    if initialDrawTime == 0 {
      initialDrawTime = CACurrentMediaTime()
    }
    
    let context = UIGraphicsGetCurrentContext()!
    context.setFillColor(UIColor.blue.cgColor)
    
    let elapsedTime = max(displayLink.timestamp - initialDrawTime, 0)
    let radians = (((2 * Double.pi) * elapsedTime) / drawDuration)
    
    context.move(to: CGPoint(x: center.x, y: center.y))
    context.addLine(to: CGPoint(x: center.x + 150, y: center.y))
    context.addArc(center: center, radius: 150, startAngle: 0, endAngle: CGFloat(radians), clockwise: false)
    context.closePath()
    context.fillPath()
    
    if radians > 2 * .pi {
      displayLink.invalidate()
      fps.pause()
    }
  }
}
