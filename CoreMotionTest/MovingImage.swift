//
//  spirekit.swift
//  CoreMotionTest
//
//  Created by EricM on 2/19/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import CoreMotion
import SpriteKit
import UIKit
import GameplayKit

class MovingImage: UIViewController {
    
    let motionManager = CMMotionManager()
    var scene = GameScene()
    
    lazy var instructions: UILabel = {
        let text = UILabel()
        text.text = "Tilt and Find Me!"
        text.numberOfLines = 3
        text.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        text.alpha = 0
        return text
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.isHidden = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6798086851, green: 0.9229053351, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("You Found Me", for: .normal)
        button.addTarget(self, action: #selector (nextVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var falseButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.isHidden = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6798086851, green: 0.9229053351, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("Try Me", for: .normal)
        button.addTarget(self, action: #selector (nextVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var fakeButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.isHidden = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6798086851, green: 0.9229053351, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("Ka-Boom", for: .normal)
        button.addTarget(self, action: #selector (nextVC), for: .touchUpInside)
        
        return button
    }()
    
    @objc func nextVC(){
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func setupConstraints(){
        instructions.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        fakeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructions)
        view.addSubview(button)
        view.addSubview(falseButton)
        view.addSubview(fakeButton)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            
            instructions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructions.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            falseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            fakeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func startingAnimation(){
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.calculationModePaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 2.5, animations: {
                self.instructions.alpha = 1
                self.instructions.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
            UIView.addKeyframe(withRelativeStartTime: 2.5, relativeDuration: 2.5, animations: {
                self.instructions.alpha = 0
                //                self.instructions.transform = CGAffineTransform(scaleX: 0, y: 0)
            })
        }) { (Bool) in
            //            self.presentScene()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        presentScene()
        setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startingAnimation()
    }
    
    //MARK: - Private Funcs
    private func presentScene() {
        scene = GameScene(size: view.frame.size)
        self.view = SKView(frame: view.frame)
        let skView = view as! SKView
        skView.showsNodeCount = true
        skView.showsFPS = true
        skView.showsPhysics = false
        scene.buttonDelegate = self
        skView.presentScene(scene)
    }
}


extension MovingImage: ButtonStatus {
    func delegate(onOrOff: Bool) {
        button.isHidden = onOrOff
    }
}
