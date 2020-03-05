//
//  ViewController.swift
//  CoreMotionTest
//
//  Created by EricM on 2/5/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    
    lazy var message: UILabel = {
        let text = UILabel()
        text.text = "Core Motion test"
        text.numberOfLines = 3 
        return text
    }()
    
    lazy var nextVC: UIButton = {
        let button = UIButton()
        button.setTitle("Next VC", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeView), for: .touchDragInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constraints()
        //startDeviceMotion()
        
    }
    
    func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: .main) {
                [weak self] (data, error) in

                guard let data = data, error == nil else {
                    return
                }

                let rotation = atan2(data.gravity.x,
                                     data.gravity.y) - .pi
                self?.message.transform =
                    CGAffineTransform(rotationAngle: CGFloat(rotation))
            }
        }
    }

    
    @objc func changeView(){
        let acelerateVC = AceleratingLeft()
        acelerateVC.modalPresentationStyle = .fullScreen
        present(acelerateVC, animated: true, completion: nil)
    }
    
    func degrees(_ radians:Double) -> Double {
        return 180 / .pi * radians
    }
    
    
    private func constraints(){
        message.translatesAutoresizingMaskIntoConstraints = false
        nextVC.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(message)
        view.addSubview(nextVC)
        
        NSLayoutConstraint.activate([
            message.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            nextVC.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 100),
            nextVC.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextVC.heightAnchor.constraint(equalToConstant: 50),
            nextVC.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
}

