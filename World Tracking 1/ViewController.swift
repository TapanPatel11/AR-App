//
//  ViewController.swift
//  World Tracking 1
//
//  Created by Tapan Patel on 05/01/20.
//  Copyright © 2020 Tapan Patel. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sceneView: ARSCNView!
    let configurations = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sceneView.debugOptions = [.showFeaturePoints,.showWorldOrigin]
        sceneView.session.run(configurations)
        self.sceneView.autoenablesDefaultLighting = true

    }

    @IBAction func add(_ sender: UIButton) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetConfigurations()
    }
    
    func resetConfigurations()
    {
        sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{ (node,_) in
            node.removeFromParentNode()
        }
        sceneView.session.run(configurations, options: [.resetTracking,.removeExistingAnchors])
    }
    
    func randomNumbers(firstNum : CGFloat, secondNum : CGFloat) -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum,secondNum)
    }
    
}

