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
        button.frame = CGRect(x: 100, y: 500, width: 75, height: 75)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        presentScene()
        view.addSubview(button)
    }
    
    //MARK: - Private Funcs
    private func presentScene() {
        scene = GameScene(size: view.frame.size)
        self.view = SKView(frame: view.frame)
        let skView = view as! SKView
        skView.showsNodeCount = true
        skView.showsFPS = true
        skView.showsPhysics = false
        skView.presentScene(scene)
    }
}


