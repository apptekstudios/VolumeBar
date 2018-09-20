//
//  VolumeBarViewController.swift
//  VolumeBarSample
//
//  Created by Toby Brennan on 20/9/18.
//  Copyright © 2018 Sachin Patel. All rights reserved.
//

import Foundation
import UIKit

class VolumeBarViewController: UIViewController {
  let volumeBarView = VolumeBarView()

  var style: VolumeBarStyle = VolumeBarStyle() {
    didSet {
      volumeBarView.style = style
      configureFrames()
    }
  }

  override func viewDidLoad() {
    view.addSubview(volumeBarView)
  }

  private func configureFrames() {
    // Get system edge insets
    var systemEdgeInsets = UIEdgeInsets.zero
    var defaultHeight: CGFloat
    if #available(iOS 11.0, *) {
      defaultHeight = (view.safeAreaLayoutGuide.layoutFrame.origin.y - style.edgeInsets.top) //Status bar height
      if defaultHeight == 0 {
        defaultHeight = 20
      }
      if style.respectsSafeAreaInsets {
        systemEdgeInsets = view.safeAreaInsets
      }
    } else {
      defaultHeight = 25
    }
    let insetLeft = systemEdgeInsets.left + style.edgeInsets.left
    let insetRight = systemEdgeInsets.right + style.edgeInsets.right

    // Set view frame
    let viewX = abs(insetLeft)
    let viewY = abs(style.edgeInsets.top)
    let viewWidth = abs(view.bounds.width - viewX - insetRight)
    let viewHeight = abs(style.height ?? defaultHeight)
    volumeBarView.frame = CGRect(x: viewX, y: viewY, width: viewWidth, height: viewHeight)
  }

  override func viewDidLayoutSubviews() {
    configureFrames()
    super.viewDidLayoutSubviews()
  }
}
extension VolumeBarViewController: SystemVolumeObserver {
  func volumeChanged(to volume: Float) {
    volumeBarView.volumeChanged(to: volume)
  }
}
