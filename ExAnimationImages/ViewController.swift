//
//  ViewController.swift
//  ExAnimationImages
//
//  Created by 김종권 on 2024/02/27.
//

import UIKit

class ViewController: UIViewController {
    private let gifImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        guard
            let gifURL = Bundle.main.url(forResource: "sample", withExtension: "gif"),
            let gifData = try? Data(contentsOf: gifURL),
            let source = CGImageSourceCreateWithData(gifData as CFData, nil)
        else { return }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        
        (0..<frameCount)
            .compactMap { CGImageSourceCreateImageAtIndex(source, $0, nil) }
            .forEach { images.append(UIImage(cgImage: $0)) }
        
        gifImageView.animationImages = images
        gifImageView.animationDuration = TimeInterval(frameCount) * 0.05 // 0.05는 임의의 값
        gifImageView.animationRepeatCount = 0
        gifImageView.startAnimating()
    }
}
