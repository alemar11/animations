//
//  ViewController2.swift
//  Animations
//
//  Created by Alessandro Marzoli on 26/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

final class AnimationView: UIView {
  var alayer: AnimationLayer!
  
  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)
    translatesAutoresizingMaskIntoConstraints = false
    self.alayer = AnimationLayer()
    layer.addSublayer(alayer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    alayer.frame = bounds
  }
}

final class AnimationLayer: CALayer {
  var displaylink: CADisplayLink!
  var x: CGFloat = 0
  var firstColor = UIColor.red.cgColor
  var secondColor = UIColor.yellow.cgColor
  let fps = FPS(fps: 60)
  
  override init() {
    super.init()
    fps.start()
    setup()
  }
  
  override init(layer: Any) {
    super.init(layer: layer)
    setup()
  }
  
  func setup() {
    // Setting a CADisplayLink on a run loop of a background thread
    DispatchQueue.global().async {
      self.displaylink = CADisplayLink(target: self, selector: #selector(self.linkTriggered))
      self.displaylink.add(to: .current, forMode: .default)
      // run the loop - this never returns
      RunLoop.current.run()
      fatalError("this never returns")
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(in ctx: CGContext) {
    ctx.setFillColor(firstColor)
    let rect1 = CGRect(x: 0, y: 0, width: x, height: bounds.size.height)
    ctx.fill(rect1)
    ctx.stroke(rect1)
    
    ctx.setFillColor(secondColor)
    let rect2 = CGRect(x: x, y: 0, width: bounds.size.width - x, height: bounds.size.height)
    ctx.fill(rect2)
    ctx.stroke(rect2)
  }
  
  @objc func linkTriggered(displaylink: CADisplayLink) {
    //print(Thread.isMainThread)
    x += 1
    if x >= bounds.size.width {
      x = 0
      let col = secondColor
      secondColor = firstColor
      firstColor = col
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.setNeedsDisplay()
    }
  }
}

final class ViewController2: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  private func setupViews() {
    let animationView = AnimationView()
    view.addSubview(animationView)
    animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    animationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    animationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}


