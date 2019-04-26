//
//  ViewController3.swift
//  Animations
//
//  Created by Alessandro Marzoli on 26/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
  private let secondLayer = CAShapeLayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    let frame = view.frame
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: frame.midX, y: frame.midY),
                radius: frame.width / 2.0 - 20.0,
                startAngle: -(CGFloat.pi / 2),
                endAngle: CGFloat.pi + CGFloat.pi / 2,
                clockwise: true)
    secondLayer.path = path.cgPath
    secondLayer.strokeColor = UIColor.black.cgColor
    secondLayer.fillColor = UIColor.clear.cgColor
    secondLayer.speed = 0.0
    view.layer.addSublayer(secondLayer)
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0.0
    animation.toValue = 1.0
    animation.duration = 60.0
    secondLayer.add(animation, forKey: "strokeCircle")
    
    let displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
    displayLink.preferredFramesPerSecond = 60
    displayLink.add(to: RunLoop.current, forMode: .common)
  }
  
  @objc func update(_ displayLink: CADisplayLink) {
    let time = Date().timeIntervalSince1970
    let seconds = floor(time).truncatingRemainder(dividingBy: 60)
    let milliseconds = time - floor(time)
    secondLayer.timeOffset = seconds + milliseconds
  }
}
