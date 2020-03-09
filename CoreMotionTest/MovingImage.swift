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
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.isHidden = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6798086851, green: 0.9229053351, blue: 0.9803921569, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("You Found Me", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        return button
    }()
    
    @objc func nextVC(){
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func setupConstraints(){
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
        ])
    }
    
    func startingAnimation(){
        UIImageView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState, animations:  {
            
        }) { (Bool) in
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        presentScene()
        setupConstraints()
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
