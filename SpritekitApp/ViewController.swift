//
//  ViewController.swift
//  SpritekitApp
//
//  Created by Umer Farooq on 08/01/2025.
//
import UIKit
import SpriteKit

class ViewController: UIViewController {
    private var skView: SKView!
        private var skScene: SKScene!
        private var touchParticle: SKEmitterNode?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Setup SpriteKit view
            skView = SKView(frame: view.bounds)
            view.addSubview(skView)

            // Setup SpriteKit scene
            skScene = SKScene(size: view.bounds.size)
            skScene.backgroundColor = .black
            skScene.scaleMode = .resizeFill
            skView.presentScene(skScene)

            // Load particle file
            if let particle = SKEmitterNode(fileNamed: "MyParticle.sks") {
                touchParticle = particle
            }
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                createParticle(at: touch.location(in: skScene))
            }
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                createParticle(at: touch.location(in: skScene))
            }
        }

        private func createParticle(at position: CGPoint) {
            guard let particle = touchParticle?.copy() as? SKEmitterNode else { return }
            particle.position = position
            skScene.addChild(particle)

            // Set particle lifetime and remove node after it finishes emitting
            let duration = particle.particleLifetime + particle.particleLifetimeRange+3
            particle.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(duration)), // Wait for particle lifespan
                SKAction.removeFromParent()          // Remove from scene
            ]))
        }
}
