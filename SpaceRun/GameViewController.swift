//
//  GameViewController.swift
//  SpaceRun
//
//  Created by Matthew Sargeant on 5/1/17.
//  Copyright © 2017 assignment3 Matthew Sargeant. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      // Configure the view typecasting the main iOS view to be an SKView object
      let skView = self.view as! SKView
      
      let scene = GameScene(size: skView.bounds.size)
      
      scene.backgroundColor = SKColor.black
      // Set the scale mode to scale to fit the window
      
      scene.scaleMode = .aspectFill
      
    

      
      // Present the scene
      skView.presentScene(scene)
      
            
      skView.ignoresSiblingOrder = true
            
      skView.showsFPS = true
      skView.showsNodeCount = true
  
          
  }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
