//
//  ViewController.swift
//  AR Dice
//
//  Created by Jia Chen Yee on 8/7/22.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        boxAnchor.actions.throwDice.onAction = { entity in
            let dice = entity as! HasPhysics
            
            dice.physicsBody?.mode = .kinematic
            
            dice.physicsMotion?.angularVelocity = [
                Float.random(in: 0 ..< 4 * .pi),
                Float.random(in: 0 ..< 4 * .pi),
                Float.random(in: 0 ..< 4 * .pi)
            ]
            
            dice.physicsMotion?.linearVelocity = [0, 1, 0]
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                dice.physicsBody? .mode = . dynamic
                dice.physicsMotion?.angularVelocity = [0, 0, 0]
                
                dice.physicsMotion?.linearVelocity = [0, 0, 0]
            }
        }
    }
}
