//
//  Extensions.swift
//  Space App
//
//  Created by Kacper Cichosz on 11/11/2022.
//

import UIKit

extension UIImageView {
	func blurCorners(radius: CGFloat) {
		let maskLayer = CAGradientLayer()
		maskLayer.frame = self.bounds
		maskLayer.shadowRadius = radius
		maskLayer.shadowPath = CGPath(roundedRect: self.bounds.insetBy(dx: radius, dy: radius), cornerWidth: 10, cornerHeight: 10, transform: nil)
		maskLayer.shadowOpacity = 1
		maskLayer.shadowOffset = CGSize.zero
		maskLayer.shadowColor = UIColor.white.cgColor
		self.layer.mask = maskLayer
	}
}

extension UIImage {
	var averageColor: UIColor? {
		guard let inputImage = CIImage(image: self) else { return nil }
		let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
		
		guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
		guard let outputImage = filter.outputImage else { return nil }
		
		var bitmap = [UInt8](repeating: 0, count: 4)
		let context = CIContext(options: [.workingColorSpace: kCFNull])
		context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
		
		return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
	}
}

public extension Thread {
	/// A method to ensure execution of the provided block on the main thread
	/// - Parameter block: The block to execute on the main thread
	class func runOnMain(block: () -> Void) {
		if Thread.isMainThread {
			block()
			return
		}
		DispatchQueue.main.sync {
			block()
		}
	}
}

extension UITableView {
	func reloadOnMainThread() {
		Thread.runOnMain {
			self.reloadData()
		}
	}
}
