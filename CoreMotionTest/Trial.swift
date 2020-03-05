//
//  Trial.swift
//  CoreMotionTest
//
//  Created by EricM on 2/6/20.
//  Copyright © 2020 EricM. All rights reserved.
//
//
//import Foundation
//import CoreMotion
//
//class ViewController: UIViewController {
//
//    let motionManager = CMMotionManager()
//
//    lazy var message: UILabel = {
//        let text = UILabel()
//        text.text = "Core Motion test"
//        text.numberOfLines = 3
//
//        return text
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        constraints()
//        // Do any additional setup after loading the view.
//        handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion)
//    }
//
//    func testMotion(){
//        if motionManager.isDeviceMotionAvailable {
//            //do something interesting
//            motionManager.deviceMotionUpdateInterval = 0.1 //changes time interval
//            var data = motionManager.deviceMotion
//            motionManager.startDeviceMotionUpdates(
//                to: OperationQueue.current!, withHandler: {
//                (deviceMotion, error) -> Void in
//
//                if(error == nil) {
//                    print(error!)
//                } else {
//                    //handle the error
//                }
//            })
//        }
//        //motionManager.stopDeviceMotionUpdates() //stops it
//    }
//
//    func degrees(_ radians:Double) -> Double {
//        return 180 / .pi * radians
//    }
//
//    func handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion) {
//        var attitude = deviceMotion.attitude
//        var roll = degrees(attitude.roll)
//        var pitch = degrees(attitude.pitch)
//        var yaw = degrees(attitude.yaw)
//        message.text = "Roll: \(roll), Pitch: \(pitch), Yaw: \(yaw)"
//        print("Roll: \(roll), Pitch: \(pitch), Yaw: \(yaw)")
//    }
//
//    private func constraints(){
//        message.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(message)
//
//        NSLayoutConstraint.activate([
//            message.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            message.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
//        ])
//
//    }
//
//}
//
