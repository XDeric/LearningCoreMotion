//
//  AcceleratingLeft.swift
//  CoreMotionTest
//
//  Created by EricM on 2/7/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit
import CoreMotion


class AceleratingLeft: UIViewController {

    let motion = CMMotionManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .red
        goBack()
    }
    
    func goBack (){
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 0.01
            motion.startDeviceMotionUpdates(to: .main) {
                [weak self] (data, error) in
        
                guard let data = data, error == nil else {
                    return
                }
                if data.userAcceleration.x < -2.5 {
                    let vc = ViewController()
                    vc.self.modalPresentationStyle = .fullScreen
                    self!.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
