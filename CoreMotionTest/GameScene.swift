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

protocol ButtonStatus {
    func delegate(onOrOff: Bool)
    func delegate1(onOrOff1: Bool)
    func delegate2(onOrOff2: Bool)
}

class GameScene: SKScene {
    
    var buttonDelegate: ButtonStatus?
    let motionManager = CMMotionManager()
    var onOrOff: Bool = true{
        didSet{
            buttonDelegate?.delegate(onOrOff: onOrOff)
        }
    }
    var onOrOff1: Bool = true{
        didSet{
            buttonDelegate?.delegate1(onOrOff1: onOrOff1)
        }
    }
    var onOrOff2: Bool = true{
        didSet{
            buttonDelegate?.delegate2(onOrOff2: onOrOff2)
        }
    }
    
    
    lazy var gundam: SKSpriteNode = {
        let g = SKSpriteNode(imageNamed: "whiteLight")
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
    
    override func update(_ currentTime: TimeInterval) {
        if onOrOff == true {
            if let accelerometerData = motionManager.accelerometerData {
                physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 5, dy: accelerometerData.acceleration.y * 6)
                var position = CGRect(x: gundam.position.x, y: gundam.position.y, width: 100, height: 100)
                foundWhichButton(rect: position)
            }
        }
    }
    
    func foundWhichButton(rect: CGRect){
        if rect.contains(CGPoint(x: 100, y: 750)) {
            gundam.physicsBody?.affectedByGravity = false
            gundam.isHidden = true
            onOrOff = false
        }
        else if rect.contains(CGPoint(x: 350, y: 500)) {
            onOrOff1 = false
        }
        else if rect.contains(CGPoint(x: 200, y: 800)) {
            onOrOff2 = false
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        addChild(gundam)
        physicsWorld.gravity = .zero
    }
    
}

