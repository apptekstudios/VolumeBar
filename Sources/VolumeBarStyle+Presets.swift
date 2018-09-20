//
//  VolumeBarStyle+Presets.swift
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

public extension VolumeBarStyle {

	// MARK: Presets

	/// A volume bar style like Snapchat, where the bar is a segmented progress view
	/// that displays under the notch and status bar on iPhone X (respecting the device's
	/// safe area insets) and covers the iOS status bar on all other iOS devices.
	public static let fullWidthSegmented: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.edgeInsets = UIEdgeInsets.zero
		style.segmentSpacing = 2
		style.segmentCount = 8
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = .white
		return style
	}()
	
	/// A volume bar style that displays a continuous progress view and has minimal insets.
	public static let fullWidthContinuous: VolumeBarStyle = {
		var style = VolumeBarStyle()
		style.edgeInsets = UIEdgeInsets.zero
		
		style.progressTintColor = #colorLiteral(red: 0.2558486164, green: 0.2558816075, blue: 0.2558295727, alpha: 1)
		style.trackTintColor = #colorLiteral(red: 0.8537222743, green: 0.8538187146, blue: 0.8536666036, alpha: 1)
		return style
	}()
}

/// :nodoc:
/*public extension UIDevice {
	public var volumeBar_hasNotch: Bool {
		#if arch(i386) || arch(x86_64)
			// We're running on the simulator, so use that to get the simulated model identifier.
			let identifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]
		#else
			// From https://github.com/dennisweissmann/DeviceKit/blob/master/Source/Device.generated.swift
			var systemInfo = utsname()
			uname(&systemInfo)
			let mirror = Mirror(reflecting: systemInfo.machine)
			let identifier = mirror.children.reduce("") { identifier, element in
				guard let value = element.value as? Int8, value != 0 else { return identifier }
				return identifier + String(UnicodeScalar(UInt8(value)))
			}
		#endif
    if let modelNumber = identifier.components(separatedBy: CharacterSet.decimalDigits.inverted).compactMap({ string -> (Int?) in
      if string == "" {return nil} else {return Int(string)}
    }).first
    {
      if modelNumber >= 11 {
        //iPhone XS,XR
        return true
      }
    }
    //If iPhone X
		return identifier == "iPhone10,3" || identifier == "iPhone10,6"
	}
}
*/
