//
//  Extra.swift
//  Molecule
//
//  Created by localuser on 26.07.22.
//

import Foundation
//let BitmaskCollision        = Int(1 << 2)
//let BitmaskCollectable      = Int(1 << 3)
//let BitmaskCatagory         = Int(1 << 4)
//let BitmaskLine           = Int(1 << 5)
//let BitmaskPie            = Int(1 << 6)

//sphereNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: sphereGeometry, options:nil))
//        sphereNode.physicsBody?.categoryBitMask = BitmaskPie
//        sphereNode.physicsBody?.contactTestBitMask = BitmaskCatagory
//        sphereNode.physicsBody?.collisionBitMask = BitmaskCollision
//        sphereNode.physicsBody?.isAffectedByGravity = false

//        let sphereGeometry = SCNSphere(radius: 0.125)
//        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
//
//        let sphereNode = SCNNode(geometry: sphereGeometry)
//        sphereNode.name = "red"
//
//
//
//        let cubeGeometry = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0.01)
//        cubeGeometry.firstMaterial?.diffuse.contents = UIColor.blue
//        let cubeNode = SCNNode(geometry: cubeGeometry)
//
//        let coneGeometry = SCNCone(topRadius: 0.12, bottomRadius: 0, height: 0.25)
//        coneGeometry.firstMaterial?.diffuse.contents = UIColor.orange
//        let coneNode = SCNNode(geometry: coneGeometry)
//
//        let pyramidGeometry = SCNPyramid(width: 0.25, height: 0.25, length: 0.25)
//        pyramidGeometry.firstMaterial?.diffuse.contents = UIColor.green
//        let pyramidNode = SCNNode(geometry: pyramidGeometry)

//        let constraint = SCNLookAtConstraint(target: sphereNode)
//        constraint.isGimbalLockEnabled = true
//        view.pointOfView!.constraints = [constraint]
        
        

//        scene.rootNode.addChildNode(sphereNode)
//        scene.rootNode.addChildNode(cubeNode)
//        scene.rootNode.addChildNode(coneNode)
//        scene.rootNode.addChildNode(pyramidNode)
        
//        scene.physicsWorld.contactDelegate = context.coordinator
//        scene.rootNode.rendererDelegate = context.coordinator

//        for i in 0..<3 {
//            for k in 0..<3 {
//                let nextGeometry = SCNSphere(radius: 0.1)
//                let nextNode = SCNNode(geometry: nextGeometry)
//                nextNode.position = SCNVector3(x: Float(i), y: Float(k), z: 0)
//                nextNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: nextGeometry, options:nil))
//                nextNode.physicsBody?.categoryBitMask = BitmaskLine
//                nextNode.physicsBody?.contactTestBitMask = BitmaskCatagory
//                nextNode.physicsBody?.collisionBitMask = BitmaskCollision
//                nextNode.physicsBody?.isAffectedByGravity = false
//                nextNode.name = "grid"
//                scene.rootNode.addChildNode(nextNode)
//            }
//        }


//        let globalPanRecognizer = UIPanGestureRecognizer(target: context.coordinator,
//                                                         action:#selector(context.coordinator.dragObject(_:)))
//        view.addGestureRecognizer(globalPanRecognizer)

//        let game = GameController()
//        view.scene?.physicsWorld.contactDelegate = context.coordinator

//func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//            print("render")
//        }

//        func CGPointToSCNVector3(view: SCNView, depth: Float, point: CGPoint) -> SCNVector3 {
//            let projectedOrigin = view.projectPoint(SCNVector3Make(0, 0, depth))
//            let locationWithz   = SCNVector3Make(Float(point.x), Float(point.y), projectedOrigin.z)
////            let locationWithz   = SCNVector3Make(Float(point.x), Float(point.y), 0)
//            return view.unprojectPoint(locationWithz)
//        }
//
//        @objc func dragObject(_ sender: UIPanGestureRecognizer){
//            print("pan")
//            let p = sender.location(in: self.view)
//            let t = sender.translation(in: self.view)
//            let hitResults = view.hitTest(p, options: [:])
//            if hitResults.count > 0 {
//                if(movingNow){
//                    let result = hitResults[0]
//                    result.node.position = CGPointToSCNVector3(view: view, depth: 0, point: p)
//                    print("result ",result.node.position)
//                } else {
//                    movingNow = true
//                }
//            }
//
//            if(sender.state == UIGestureRecognizer.State.ended) {
//                print("ended")
//                movingNow = false
////                var count = 0
////                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
////                    if node.name == "grid" {
////                        if let node2D = nodeNow {
////                            if node.boundingBoxContains(point: node2D.position) {
////                                print("hit ",node2D.name,count)
////                            }
////                        }
////                    }
////                    count += 1
////                }
////                nodeNow = nil
//            }
//        }
        
        
       
    
//extension Coordinator: SCNPhysicsContactDelegate {
//    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
//        // Collision happened between contact.nodeA and contact.nodeB
//        print("contact ",contact.nodeA,contact.nodeB)
//
//    }
//}
    


//extension SCNNode {
//func boundingBoxContains(point: SCNVector3, in node: SCNNode) -> Bool {
//    let localPoint = self.convertPosition(point, from: node)
//    return boundingBoxContains(point: localPoint)
//}
//
//func boundingBoxContains(point: SCNVector3) -> Bool {
//    return BoundingBox(self.boundingBox).contains(point)
//}
//
//struct BoundingBox {
//
//    let min: SCNVector3;
//    let max: SCNVector3;
//
//    init(_ boundTuple: (min: SCNVector3, max: SCNVector3)) {
//        min = boundTuple.min
//        max = boundTuple.max
//    }
//
//    func contains(_ point: SCNVector3) -> Bool {
//        let contains =
//            min.x <= point.x &&
//                min.y <= point.y &&
//                min.z <= point.z &&
//
//                max.x > point.x &&
//                max.y > point.y &&
//                max.z > point.z
//
//        return contains
//    }
//}
//}

//let winner1 = [Optional(SIMD3<Int>(0, 3, 0)),
//  Optional(SIMD3<Int>(0, 3, 1)),
//  Optional(SIMD3<Int>(0, 3, 2)),
//  Optional(SIMD3<Int>(0, 3, 3))]
//              
//let winner2 = [Optional(SIMD3<Int>(1, 3, 0)),
//  Optional(SIMD3<Int>(1, 3, 1)),
//  Optional(SIMD3<Int>(1, 3, 2)),
//  Optional(SIMD3<Int>(1, 3, 3))]
//              
//let winner3 = [Optional(SIMD3<Int>(2, 3, 0)),
//  Optional(SIMD3<Int>(2, 3, 1)),
//  Optional(SIMD3<Int>(2, 3, 2)),
//  Optional(SIMD3<Int>(2, 3, 3))]
//              
//let winner4 = [Optional(SIMD3<Int>(3, 3, 0)),
//  Optional(SIMD3<Int>(3, 3, 1)),
//  Optional(SIMD3<Int>(3, 3, 2)),
//  Optional(SIMD3<Int>(3, 3, 3))]
//
//let winner5 = [Optional(SIMD3<Int>(0, 3, 0)),
//    Optional(SIMD3<Int>(0, 2, 0)),
//    Optional(SIMD3<Int>(0, 1, 0)),
//    Optional(SIMD3<Int>(0, 0, 0))]
//
//let winner6 = [Optional(SIMD3<Int>(1, 3, 0)),
//    Optional(SIMD3<Int>(1, 2, 0)),
//    Optional(SIMD3<Int>(1, 1, 0)),
//    Optional(SIMD3<Int>(1, 0, 0))]
//
//let winner7 = [Optional(SIMD3<Int>(2, 3, 0)),
//    Optional(SIMD3<Int>(2, 2, 0)),
//    Optional(SIMD3<Int>(2, 1, 0)),
//    Optional(SIMD3<Int>(2, 0, 0))]
//
//let winner8 = [Optional(SIMD3<Int>(3, 3, 0)),
//    Optional(SIMD3<Int>(3, 2, 0)),
//    Optional(SIMD3<Int>(3, 1, 0)),
//    Optional(SIMD3<Int>(3, 0, 0))]
//
//let winner9 = [Optional(SIMD3<Int>(0, 0, 0)),
//   Optional(SIMD3<Int>(1, 1, 0)),
//   Optional(SIMD3<Int>(2, 2, 0)),
//   Optional(SIMD3<Int>(3, 3, 0))]
//
//let winner10 = [Optional(SIMD3<Int>(0, 3, 1)),
//    Optional(SIMD3<Int>(0, 2, 1)),
//    Optional(SIMD3<Int>(0, 1, 1)),
//    Optional(SIMD3<Int>(0, 0, 1))]
//
//let winner11 = [Optional(SIMD3<Int>(0, 3, 2)),
//    Optional(SIMD3<Int>(0, 2, 2)),
//    Optional(SIMD3<Int>(0, 1, 2)),
//    Optional(SIMD3<Int>(0, 0, 2))]
//
//let winner12 = [Optional(SIMD3<Int>(0, 3, 3)),
//    Optional(SIMD3<Int>(0, 2, 3)),
//    Optional(SIMD3<Int>(0, 1, 3)),
//    Optional(SIMD3<Int>(0, 0, 3))]
//
//let winner13 = [Optional(SIMD3<Int>(0, 3, 0)),
//    Optional(SIMD3<Int>(1, 2, 0)),
//    Optional(SIMD3<Int>(2, 1, 0)),
//    Optional(SIMD3<Int>(3, 0, 0))]
//
//let winner14 = [Optional(SIMD3<Int>(0, 3, 0)),
//    Optional(SIMD3<Int>(1, 3, 1)),
//    Optional(SIMD3<Int>(2, 3, 2)),
//    Optional(SIMD3<Int>(3, 3, 3))]
//
//let winner15 = [Optional(SIMD3<Int>(0, 3, 3)),
//    Optional(SIMD3<Int>(1, 3, 2)),
//    Optional(SIMD3<Int>(2, 3, 1)),
//    Optional(SIMD3<Int>(3, 3, 0))]
//
//let winner16 = [Optional(SIMD3<Int>(3, 0, 0)),
//    Optional(SIMD3<Int>(3, 1, 1)),
//    Optional(SIMD3<Int>(3, 2, 2)),
//    Optional(SIMD3<Int>(3, 3, 3))]
//
//let winner17 = [Optional(SIMD3<Int>(3, 3, 0)),
//    Optional(SIMD3<Int>(3, 2, 1)),
//    Optional(SIMD3<Int>(3, 1, 2)),
//    Optional(SIMD3<Int>(3, 0, 3))]
//
//if winners.isEmpty {
//    winners.append(winner1)
//    winners.append(winner2)
//    winners.append(winner3)
//    winners.append(winner4)
//    winners.append(winner5)
//    winners.append(winner6)
//    winners.append(winner7)
//    winners.append(winner8)
//    winners.append(winner9)
//    winners.append(winner10)
//    winners.append(winner11)
//    winners.append(winner12)
//    winners.append(winner13)
//    winners.append(winner14)
//    winners.append(winner15)
//    winners.append(winner16)
//    winners.append(winner17)
//}

//for winner in winnerA {
//    // front left-to-right
//    DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z, delay: 0.3, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z, delay: 0.4, win: &win)
//                        self.winners.append(win)
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.36 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 1, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 1, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 1, delay: 0.3, win: &win)
//                        self.winners.append(win)
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.40 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 2, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 2, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 2, delay: 0.3, win: &win)
//                        self.winners.append(win)
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.44 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 3, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 3, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 3, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//    }

// base

//DispatchQueue.main.asyncAfter(deadline: .now() + 0.48 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//}

//DispatchQueue.main.asyncAfter(deadline: .now() + 0.52 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//}

//DispatchQueue.main.asyncAfter(deadline: .now() + 0.56 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//}

//DispatchQueue.main.asyncAfter(deadline: .now() + 0.60 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//}

//                    // diagonal front-bottom-to-top
//}

//                    for winner in winnerA {
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.64 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                        
//                    // diagonal front-top-to-bottom
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.68 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
//                }

//                for winner in winnerB {
//                    diagonal front-bottom-to-top
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.24 ) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y - 1, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y - 2, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y - 3, z: winner.z, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                   // diagonal front-top-to-bottom
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
//                       var win:[SIMD3<Int>] = []
//                       postLine(x: winner.x + 3, y: winner.y, z: winner.z, delay: 0, win: &win)
//                       postLine(x: winner.x + 2, y: winner.y - 1, z: winner.z, delay: 0.1, win: &win)
//                       postLine(x: winner.x + 1, y: winner.y - 2, z: winner.z, delay: 0.2, win: &win)
//                       postLine(x: winner.x, y: winner.y - 3, z: winner.z, delay: 0.3, win: &win)
//                       self.winners.append(win)
//                   }
//                }

//                for winner in winnerC {
                    // diagonal right front-to-back
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [self] in
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x, y: winner.y - 1, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x, y: winner.y - 2, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x, y: winner.y - 3, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                    // diagonal left front-to-back
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y - 3, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x, y: winner.y - 2, z: winner.z + 1, delay: 0.1, win: &win)
//                        postLine(x: winner.x, y: winner.y - 1, z: winner.z + 2, delay: 0.2, win: &win)
//                        postLine(x: winner.x, y: winner.y, z: winner.z + 3, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
//                }

//                for winner in winnerB {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    // front right-to-left
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y, z: winner.z, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y - 1, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y - 1, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y - 1, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y - 1, z: winner.z, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y - 2, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y - 2, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y - 2, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y - 2, z: winner.z, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
//                        var win:[SIMD3<Int>] = []
//                        postLine(x: winner.x, y: winner.y - 3, z: winner.z, delay: 0, win: &win)
//                        postLine(x: winner.x + 1, y: winner.y - 3, z: winner.z, delay: 0.1, win: &win)
//                        postLine(x: winner.x + 2, y: winner.y - 3, z: winner.z, delay: 0.2, win: &win)
//                        postLine(x: winner.x + 3, y: winner.y - 3, z: winner.z, delay: 0.3, win: &win)
//                        self.winners.append(win)
//                    }
//                }

//                func postLine(x: Int, y:Int, z:Int, delay: TimeInterval, win: inout [SIMD3<Int>]) {
//                    win.append(SIMD3(x: x, y: y, z: z))
//                    self.winners.append(win)
//                    print("posted x,y,z",x,y,z)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                        changeling.send(SIMD3(x: x, y: y, z: z))
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                resetting.send(SIMD3(x: x, y: y, z: z))
//                            }
//                    }
//                }
