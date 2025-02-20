//
//  ImageLoader.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI


protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader {
    weak var delegate: ImageLoaderDelegate?
    var completionHandler: ((UIImage?) -> Void)?

    func loadImage(url: URL) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            let size = CGSize(width: 100, height: 100)
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            UIColor.green.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async { [weak self] in
                if let image = image, let self = self {
                    self.delegate?.imageLoader(self, didLoad: image)
                    self.completionHandler?(image)
                } else {
                    let error = NSError(domain: "ImageLoaderError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
                    if let self = self {
                        self.delegate?.imageLoader(self, didFailWith: error)
                    }
                    self?.completionHandler?(nil)
                }
            }
        }
    }
}
