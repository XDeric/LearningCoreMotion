//
//  TempSkScene.swift
//  CoreMotionTest
//
//  Created by EricM on 2/27/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion
import UIKit

class GameScene: SKScene {
    let motionManager = CMMotionManager()
    
    lazy var gundam: SKSpriteNode = {
        let g = SKSpriteNode(imageNamed: "freedom")
        g.position = CGPoint(x: 200 , y: 400)
        g.zPosition = 1
        g.scale(to: CGSize(width: 100, height: 100))
        g.physicsBody?.allowsRotation = false
        g.physicsBody?.linearDamping = 0.5
        //g.physicsBody?.restitution = 0.5
        g.physicsBody?.affectedByGravity = true
        g.isUserInteractionEnabled = true
        g.physicsBody = SKPhysicsBody(circleOfRadius: g.size.width / 2)
        return g
    }()
    
    var onOrOff: Bool = false {
        didSet {
            button.isHidden = onOrOff
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 500, width: 75, height: 75)
        
        return button
    }()
    
    func movePlayer(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 8, dy: accelerometerData.acceleration.y * 8)
            contains(CGPoint(x: 100, y: 500))
            
        }
    }
    override func contains(_ p: CGPoint) -> Bool {
        var xPoint = p.x
        var yPoint = p.y
        var rect = CGRect(x: gundam.position.x, y: gundam.position.y, width: 100, height: 100)
        if rect.contains(p) {
            print("reached location")
            motionManager.stopAccelerometerUpdates()
            gundam.physicsBody?.affectedByGravity = false
            gundam.isPaused = false
//            gundam.position = gundam.position
            onOrOff = false
            return false
        }
        else {
            onOrOff = true
            return true}
    }
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        addChild(gundam)
        physicsWorld.gravity = .zero
    }
    
}

//motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
//    self.physicsWorld.gravity = CGVector(dx: (data?.acceleration.x)! * -50, dy: (data?.acceleration.y)! * 50)
//}
