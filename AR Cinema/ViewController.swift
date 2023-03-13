//
//  ViewController.swift
//  AR Cinema
//
//  Created by Pavel Yakovenko on 11.03.2023.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let videoPlane = SCNPlane(width: 1.0, height: 0.75)
        let videoNode = SCNNode(geometry: videoPlane)
        videoNode.position = SCNVector3(x: 0, y: 0, z: -2)
        
        let videoURL = Bundle.main.url(forResource: "CityHD", withExtension: "mp4")!
        let videoPlayer = AVPlayer(url: videoURL)
        videoPlane.firstMaterial?.diffuse.contents = videoPlayer
        videoPlayer.play()
        
        scene.rootNode.addChildNode(videoNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}
