//
//  VolumeBarWindow.swift
//
//  Copyright (c) 2016-Present Sachin Patel (http://gizmosachin.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import MediaPlayer

internal final class VolumeBarWindow: UIWindow {
	fileprivate static let hiddenWindowLevel = UIWindow.Level.normal
	fileprivate static let visibleWindowLevel = UIWindow.Level.statusBar + 1
	
	internal let viewController: VolumeBarViewController
	
	/// A standard iOS `MPVolumeView` that never appears but is necessary to hide the system volume HUD.
	private let systemVolumeView: MPVolumeView
	
	internal required init(viewController: VolumeBarViewController) {
		self.viewController = viewController
		
		// Add a non-hidden MPVolumeView with a zero frame to prevent the system volume HUD from showing
		systemVolumeView = MPVolumeView(frame: .zero)
		systemVolumeView.isHidden = false
		systemVolumeView.clipsToBounds = true
		systemVolumeView.showsRouteButton = false
		systemVolumeView.alpha = 0.0001
		
		super.init(frame: UIScreen.main.bounds)
		
		isUserInteractionEnabled = false
		isHidden = false
		windowLevel = VolumeBarWindow.hiddenWindowLevel
		
		// Add view controller
		viewController.view.isHidden = true
		rootViewController = viewController
		addSubview(systemVolumeView)
	}
	
	required internal init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    // Don't swallow any touches
    return nil
  }
}

internal extension VolumeBarWindow {
	internal func show(withAnimation animation: VolumeBarAnimation) {
		// Unhide the view so we can animate it
		guard let view = viewController.view, view.isHidden else { return }
		view.isHidden = false
		
		// Show window
		windowLevel = VolumeBarWindow.visibleWindowLevel
		
		// Perform show animation
		let completionHandler: VolumeBarAnimation.CompletionHandler? = { done in }
		animation.animationBlock(self, completionHandler)
	}
	
	internal func hide(withAnimation animation: VolumeBarAnimation) {
		// Hide the view and reset the window level once the hide animation completes
		let completionHandler: VolumeBarAnimation.CompletionHandler? = { done in
			self.viewController.view.isHidden = true
			self.windowLevel = VolumeBarWindow.hiddenWindowLevel
		}
		
		// Perform hide animation
		animation.animationBlock(self, completionHandler)
	}
}
