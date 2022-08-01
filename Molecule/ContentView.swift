//
//  ContentView.swift
//  Molecule
//
//  Created by localuser on 24.07.22.
//

import SwiftUI
import SceneKit
import GameplayKit
import Combine

var debugX:AnyCancellable!
let debugging = PassthroughSubject<(UIColor,SIMD3<Int>),Never>()

var changer:AnyCancellable!
let changeling = PassthroughSubject<SIMD3<Int>,Never>()

var reseter:AnyCancellable!
let resetting = PassthroughSubject<SIMD3<Int>,Never>()

var spinner: AnyCancellable!

//let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
let timer = PassthroughSubject<Void,Never>()

let gameSetAndMatch = PassthroughSubject<UIColor,Never>()
var gameReset:AnyCancellable!

struct ContentView: View {
    @State var gameOver: String = ""
    @State var colors = false
    var scene = SCNScene(named: "SceneKitScene.scn")
    var body: some View {
        ZStack {
            SceneView(
                scene: scene!,
                options: []
            )
        
        VStack {
           Text(gameOver)
                .font(Fonts.neutonRegular(size: 128))
                .foregroundColor(colors ? .blue : .red)
                .onReceive(gameSetAndMatch) { color in
                    if color == .blue {
                        gameOver = "Blue Wins"
                        colors = true
                    }
                    if color == .red {
                        gameOver = "Red Wins"
                        colors = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        gameOver = ""
                    }
                }.onTapGesture {
                    gameOver = ""
                }
        }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SceneView: UIViewRepresentable {
    
    var scene: SCNScene
    var options: [Any]
    
    var view = SCNView()
    var coreNode = SCNNode()
    
    
    func makeUIView(context: Context) -> SCNView {
        
        view.scene = scene
        view.pointOfView = scene.rootNode.childNode(withName: "camera", recursively: true)
        view.allowsCameraControl = true
        
        let seed = 0.5
        let step = 0.3
        
        coreNode.name = "coreNode"
        scene.rootNode.addChildNode(coreNode)
        
        var rIntdex = 0
        for r in stride(from: -seed, through: seed, by: step) {
            var kIntdex = 0
            for k in stride(from: -seed, through: seed, by: step) {
                var iIntdex = 0
                for i in stride(from: -seed, through: seed, by: step) {
                    let nextGeometry = SCNSphere(radius: 0.05)
                    nextGeometry.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.8)
                    let nextIndex = SIMD3(x: rIntdex, y: kIntdex, z: iIntdex)
                    let nextNode = NewNode(proxy: nextIndex, geometry: nextGeometry)
                    nextNode.position = SCNVector3(x: Float(i), y: Float(r), z: Float(k))
                    nextNode.name = "grid\(i)\(k)"
                    coreNode.addChildNode(nextNode)
                    iIntdex += 1
                }
                kIntdex += 1
            }
            rIntdex += 1
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
        return view
    }
    
    func updateUIView(_ view: SCNView, context: Context) {
       
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(view)
    }
    
    class Coordinator: NSObject {
        private let view: SCNView
        private var coreNode: SCNNode!
        private var player = false
        private var winners:[[SIMD3<Int>?]] = []
        
        struct MetaMatrix {
            var redCount: Int = 0
            var blueCount: Int = 0
        }
        private var shared:[Int:MetaMatrix] = [:]
        
        private var winningBlueDict:[String:[SIMD3<Int>?]] = [:]
        private var winningRedDict:[String:[SIMD3<Int>?]] = [:]
        private var winningJointDict:[String:[SIMD3<Int>?]] = [:]
        
        private var board: [[[NewNode?]]] = .init(repeating: .init(repeating: .init(repeating: nil, count: 4), count: 4), count: 4)
        
        init(_ view: SCNView) {
            self.view = view
            super.init()
            
            extractedFunc1()
            
            gameReset = gameSetAndMatch.sink(receiveValue: { [self] choosen in
                board.removeAll()
                board = .init(repeating: .init(repeating: .init(repeating: nil, count: 4), count: 4), count: 4)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.extractedFunc1()
                }
            })
            
            spinner = timer.sink(receiveValue: { [self] choosen in
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    if node.name == "coreNode" {
                        coreNode = node
                    }
                }
                let quaternion = simd_quatf(angle: GLKMathDegreesToRadians(1), axis: simd_float3(1,1,1))
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                coreNode.simdOrientation = quaternion * coreNode.simdOrientation
                SCNTransaction.commit()
            })
            
            debugX = debugging.sink(receiveValue: { [self] choosen in
                let (color, selectNode) = choosen
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    let decoded = node as? NewNode
                    if decoded?.proxy == selectNode && decoded?.name == "grid" && player {
                        decoded?.geometry?.firstMaterial?.diffuse.contents = color.withAlphaComponent(0.5)
                    }
                    if decoded?.proxy == selectNode && decoded?.name == "grid" && !player {
                        decoded?.geometry?.firstMaterial?.diffuse.contents = color.withAlphaComponent(0.5)
                    }
                }
            })
                
            
            changer = changeling.sink(receiveValue: { [self] choosen in
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    if node.name == "coreNode" {
                        coreNode = node
                    }
                }
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    let decoded = node as? NewNode
                    if decoded?.proxy == choosen {
                            let dIndex = decoded?.proxy
                            let dPosition = decoded?.simdPosition
//                            decoded!.removeFromParentNode()
                            
                            let nextGeometry = SCNSphere(radius: 0.05)
                            nextGeometry.firstMaterial?.diffuse.contents = UIColor.yellow
                            let nextNode = NewNode(proxy: dIndex!, geometry: nextGeometry)
                            nextNode.simdPosition = dPosition!
                            nextNode.name = "grid"
                        
                            SCNTransaction.begin()
                            SCNTransaction.animationDuration = 0.9
                            decoded!.removeFromParentNode()
                            SCNTransaction.completionBlock = {
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = 0.9
//                                view.scene?.rootNode.addChildNode(nextNode)
                                self.coreNode.addChildNode(nextNode)
                                SCNTransaction.commit()
                            }
                            SCNTransaction.commit()
                    }
                }
            })
            
            reseter = resetting.sink(receiveValue: { [self] choosen in
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    if node.name == "coreNode" {
                        coreNode = node
                    }
                }
                view.scene?.rootNode.enumerateChildNodes { (node, stop) in
                    let decoded = node as? NewNode
                    if decoded?.proxy == choosen {
                        let dIndex = decoded?.proxy
                        let dPosition = decoded?.simdPosition
//                        decoded!.removeFromParentNode()
                        
                        let nextGeometry = SCNSphere(radius: 0.05)
                        nextGeometry.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.8)
                        let nextNode = NewNode(proxy: dIndex!, geometry: nextGeometry)
                        nextNode.simdPosition = dPosition!
                        nextNode.name = "grid"
//                        view.scene?.rootNode.addChildNode(nextNode)
                        SCNTransaction.begin()
                        SCNTransaction.animationDuration = 0.9
                        decoded!.removeFromParentNode()
                        SCNTransaction.completionBlock = {
                            SCNTransaction.begin()
                            SCNTransaction.animationDuration = 0.9
//                            view.scene?.rootNode.addChildNode(nextNode)
                            self.coreNode.addChildNode(nextNode)
                            SCNTransaction.commit()
                        }
                        SCNTransaction.commit()
                    }
                }
            })
            
        }
        
        fileprivate func extractedFunc(_ postLineV: ([SIMD3<Int>], Int, Int, Int, TimeInterval) -> ()) {
            
            let winnerT = [SIMD3<Int>(3, 3, 3),
            SIMD3<Int>(3, 2, 2),
            SIMD3<Int>(3, 1, 1),
            SIMD3<Int>(3, 0, 0)]
            
            let winnerS = [SIMD3<Int>(0, 0, 0),
            SIMD3<Int>(0, 1, 1),
            SIMD3<Int>(0, 2, 2),
            SIMD3<Int>(0, 3, 3)]
            
            let winnerQ = [SIMD3<Int>(3, 3, 0),
            SIMD3<Int>(3, 2, 1),
            SIMD3<Int>(3, 1, 2),
            SIMD3<Int>(3, 0, 3)]
            
            let winnerP = [SIMD3<Int>(0, 3, 0),
            SIMD3<Int>(0, 2, 1),
            SIMD3<Int>(0, 1, 2),
            SIMD3<Int>(0, 0, 3)]
            
            let winnerO = [SIMD3<Int>(3, 0, 0),
            SIMD3<Int>(2, 1, 1),
            SIMD3<Int>(1, 2, 2),
            SIMD3<Int>(0, 3, 3)]
            
            let winnerN = [SIMD3<Int>(3, 3, 0),
            SIMD3<Int>(2, 2, 1),
            SIMD3<Int>(1, 1, 2),
            SIMD3<Int>(0, 0, 3)]
            
            let winnerM = [SIMD3<Int>(0, 3, 0),
            SIMD3<Int>(1, 2, 1),
            SIMD3<Int>(2, 1, 2),
            SIMD3<Int>(3, 0, 3)]
            
            let winnerL = [SIMD3<Int>(0, 0, 0),
            SIMD3<Int>(1, 1, 1),
            SIMD3<Int>(2, 2, 2),
            SIMD3<Int>(3, 3, 3)]
            
            
            let winnerK = [SIMD3<Int>(0, 0, 3),
                SIMD3<Int>(1, 0, 2),
                SIMD3<Int>(2, 0, 1),
                SIMD3<Int>(3, 0, 0)]
            
            let winnerJ = [SIMD3<Int>(0, 0, 0),
                SIMD3<Int>(1, 0, 1),
                SIMD3<Int>(2, 0, 2),
                SIMD3<Int>(3, 0, 3)]
            
            let winnerI = [SIMD3<Int>(0, 3, 3),
                SIMD3<Int>(1, 2, 3),
                SIMD3<Int>(2, 1, 3),
                SIMD3<Int>(3, 0, 3)]
            
            let winnerH = [SIMD3<Int>(3, 3, 3),
                SIMD3<Int>(2, 2, 3),
                SIMD3<Int>(1, 1, 3),
                SIMD3<Int>(0, 0, 3)]
            
            let winnerG = [SIMD3<Int>(0, 3, 0),
                SIMD3<Int>(1, 2, 0),
                SIMD3<Int>(2, 1, 0),
                SIMD3<Int>(3, 0, 0)]
            
            let winnerF = [SIMD3<Int>(0, 0, 0),
                SIMD3<Int>(1, 1, 0),
                SIMD3<Int>(2, 2, 0),
                SIMD3<Int>(3, 3, 0)]
            
            let winnerE = [SIMD3<Int>(0, 3, 3),
                SIMD3<Int>(1, 3, 2),
                SIMD3<Int>(2, 3, 1),
                SIMD3<Int>(3, 3, 0)]
            
            let winnerD = [SIMD3<Int>(0, 3, 0),
                SIMD3<Int>(1, 3, 1),
                SIMD3<Int>(2, 3, 2),
                SIMD3<Int>(3, 3, 3)]
            
            let winnerA = [SIMD3<Int>(0, 3, 0),
                           SIMD3<Int>(0, 2, 0),
                           SIMD3<Int>(0, 1, 0),
                           SIMD3<Int>(0, 0, 0)]
            
            let winnerB = [SIMD3<Int>(0, 3, 0),
                           SIMD3<Int>(0, 3, 1),
                           SIMD3<Int>(0, 3, 2),
                           SIMD3<Int>(0, 3, 3)]
            
            let winnerC = [SIMD3<Int>(0, 3, 0),
                           SIMD3<Int>(1, 3, 0),
                           SIMD3<Int>(2, 3, 0),
                           SIMD3<Int>(3, 3, 0)]
            
            postLineV(winnerA, 0, 0, 0, 0)
            postLineV(winnerA, 1, 0, 0, 0.1)
            postLineV(winnerA, 2, 0, 0, 0.2)
            postLineV(winnerA, 3, 0, 0, 0.3)
            //
            postLineV(winnerA, 0, 0, 1, 0.4)
            postLineV(winnerA, 1, 0, 1, 0.5)
            postLineV(winnerA, 2, 0, 1, 0.6)
            postLineV(winnerA, 3, 0, 1, 0.7)
            
            postLineV(winnerA, 0, 0, 2, 0.9)
            postLineV(winnerA, 1, 0, 2, 1.0)
            postLineV(winnerA, 2, 0, 2, 1.1)
            postLineV(winnerA, 3, 0, 2, 1.2)
            
            postLineV(winnerA, 0, 0, 3, 1.3)
            postLineV(winnerA, 1, 0, 3, 1.4)
            postLineV(winnerA, 2, 0, 3, 1.5)
            postLineV(winnerA, 3, 0, 3, 1.6)
            //
            postLineV(winnerA, 0, 0, 0, 2.0)
            postLineV(winnerA, 0, 0, 1, 2.1)
            postLineV(winnerA, 0, 0, 2, 2.2)
            postLineV(winnerA, 0, 0, 3, 2.3)
            //
            postLineV(winnerA, 1, 0, 0, 2.4)
            postLineV(winnerA, 1, 0, 1, 2.5)
            postLineV(winnerA, 1, 0, 2, 2.6)
            postLineV(winnerA, 1, 0, 3, 2.7)
            
            postLineV(winnerA, 2, 0, 0, 2.8)
            postLineV(winnerA, 2, 0, 1, 2.9)
            postLineV(winnerA, 2, 0, 2, 3.0)
            postLineV(winnerA, 2, 0, 3, 3.1)
            
            postLineV(winnerA, 3, 0, 0, 3.2)
            postLineV(winnerA, 3, 0, 1, 3.3)
            postLineV(winnerA, 3, 0, 2, 3.4)
            postLineV(winnerA, 3, 0, 3, 3.5)
            
            postLineV(winnerA, 0, 0, 0, 4.0)
            postLineV(winnerA, 1, 0, 1, 4.1)
            postLineV(winnerA, 2, 0, 2, 4.2)
            postLineV(winnerA, 3, 0, 3, 4.3)
            
            postLineV(winnerA, 3, 0, 0, 4.4)
            postLineV(winnerA, 2, 0, 1, 4.5)
            postLineV(winnerA, 1, 0, 2, 4.6)
            postLineV(winnerA, 0, 0, 3, 4.7)
            //
            postLineV(winnerB, 0, 0, 0, 4.8)
            postLineV(winnerB, 1, -1, 0, 4.9)
            postLineV(winnerB, 2, -2, 0, 5.0)
            postLineV(winnerB, 3, -3, 0, 5.1)
            //
            postLineV(winnerB, 3, 0, 0, 5.2)
            postLineV(winnerB, 2, -1, 0, 5.3)
            postLineV(winnerB, 1, -2, 0, 5.4)
            postLineV(winnerB, 0, -3, 0, 5.5)
            
            postLineV(winnerC, 0, 0, 0, 5.6)
            postLineV(winnerC, 0, -1, 1, 5.7)
            postLineV(winnerC, 0, -2, 2, 5.8)
            postLineV(winnerC, 0, -3, 3, 5.9)
            
            postLineV(winnerC, 0, -3, 0, 6.0)
            postLineV(winnerC, 0, -2, 1, 6.1)
            postLineV(winnerC, 0, -1, 2, 6.2)
            postLineV(winnerC, 0, 0, 3, 6.3)
            //
            postLineV(winnerB, 0, 0, 0, 6.4)
            postLineV(winnerB, 1, 0, 0, 6.5)
            postLineV(winnerB, 2, 0, 0, 6.6)
            postLineV(winnerB, 3, 0, 0, 6.7)
            
            postLineV(winnerB, 0, -1, 0, 6.8)
            postLineV(winnerB, 1, -1, 0, 6.9)
            postLineV(winnerB, 2, -1, 0, 7.0)
            postLineV(winnerB, 3, -1, 0, 7.1)
            
            postLineV(winnerB, 0, -2, 0, 7.2)
            postLineV(winnerB, 1, -2, 0, 7.3)
            postLineV(winnerB, 2, -2, 0, 7.4)
            postLineV(winnerB, 3, -2, 0, 7.5)
            
            postLineV(winnerB, 0, -3, 0, 7.6)
            postLineV(winnerB, 1, -3, 0, 7.7)
            postLineV(winnerB, 2, -3, 0, 7.8)
            postLineV(winnerB, 3, -3, 0, 7.9)
            //
            postLineV(winnerB, 0, 0, 0, 8.0)
            postLineV(winnerB, 1, -1, 0, 8.1)
            postLineV(winnerB, 2, -2, 0, 8.2)
            postLineV(winnerB, 3, -3, 0, 8.3)
            //
            postLineV(winnerB, 0, -3, 0, 8.4)
            postLineV(winnerB, 1, -2, 0, 8.5)
            postLineV(winnerB, 2, -1, 0, 8.5)
            postLineV(winnerB, 3, 0, 0, 8.7)
            
            postLineV(winnerC, 0, -1, 3, 8.8)
            postLineV(winnerC, 0, -2, 3, 8.9)
            
            postLineV(winnerC, 0, 0, 1, 9.0)
            postLineV(winnerC, 0, 0, 2, 9.1)
           
            postLineV(winnerC, 0, -1, 0, 9.2)
            postLineV(winnerC, 0, -2, 0, 9.3)
            
            postLineV(winnerC, 0, -3, 1, 9.4)
            postLineV(winnerC, 0, -3, 2, 9.5)
            
            postLineV(winnerD, 0, 0, 0, 9.6)
            postLineV(winnerE, 0, 0, 0, 9.65)
            postLineV(winnerG, 0, 0, 0, 9.7)
            postLineV(winnerF, 0, 0, 0, 9.75)
            postLineV(winnerI, 0, 0, 0, 9.8)
            postLineV(winnerH, 0, 0, 0, 9.85)
            postLineV(winnerJ, 0, 0, 0, 9.9)
            postLineV(winnerK, 0, 0, 0, 9.95)
            
            postLineV(winnerL, 0, 0, 0, 10)
            postLineV(winnerM, 0, 0, 0, 10.1)
            postLineV(winnerN, 0, 0, 0, 10.2)
            postLineV(winnerO, 0, 0, 0, 10.3)
            
            postLineV(winnerP, 0, 0, 0, 10.4)
            postLineV(winnerQ, 0, 0, 0, 10.5)
            postLineV(winnerS, 0, 0, 0, 10.6)
            postLineV(winnerT, 0, 0, 0, 10.6)
            
            print("lines ",self.winners.count)
            
        }
        
        fileprivate func extractedFunc1() {
            self.winners.removeAll()
            
//            Optional(SIMD3<Int>(0, 2, 3))
//            Optional(SIMD3<Int>(1, 2, 3))
//            Optional(SIMD3<Int>(2, 2, 3))
//            Optional(SIMD3<Int>(3, 2, 3))
            
//            Optional(SIMD3<Int>(0, 1, 3))
//            Optional(SIMD3<Int>(1, 1, 3))
//            Optional(SIMD3<Int>(2, 1, 3))
//            Optional(SIMD3<Int>(3, 1, 3))
            
//            Optional(SIMD3<Int>(0, 3, 1))
//            Optional(SIMD3<Int>(1, 3, 1))
//            Optional(SIMD3<Int>(2, 3, 1))
//            Optional(SIMD3<Int>(3, 3, 1))
            
//            Optional(SIMD3<Int>(0, 3, 2))
//            Optional(SIMD3<Int>(1, 3, 2))
//            Optional(SIMD3<Int>(2, 3, 2))
//            Optional(SIMD3<Int>(3, 3, 2))
            
//            Optional(SIMD3<Int>(0, 2, 0))
//            Optional(SIMD3<Int>(1, 2, 0))
//            Optional(SIMD3<Int>(2, 2, 0))
//            Optional(SIMD3<Int>(3, 2, 0))
//
//            Optional(SIMD3<Int>(0, 1, 0))
//            Optional(SIMD3<Int>(1, 1, 0))
//            Optional(SIMD3<Int>(2, 1, 0))
//            Optional(SIMD3<Int>(3, 1, 0))
            
//            Optional(SIMD3<Int>(0, 0, 1))
//            Optional(SIMD3<Int>(1, 0, 1))
//            Optional(SIMD3<Int>(2, 0, 1))
//            Optional(SIMD3<Int>(3, 0, 1))
//
//            Optional(SIMD3<Int>(0, 0, 2))
//            Optional(SIMD3<Int>(1, 0, 2))
//            Optional(SIMD3<Int>(2, 0, 2))
//            Optional(SIMD3<Int>(3, 0, 2))
            
//            Optional(SIMD3<Int>(0, 3, 0))
//            Optional(SIMD3<Int>(1, 3, 1))
//            Optional(SIMD3<Int>(2, 3, 2))
//            Optional(SIMD3<Int>(3, 3, 3))
            
            
            
            func postLineV(winningLine:[SIMD3<Int>], adjX:Int, adjY:Int, adjZ:Int, delay: TimeInterval) {
                
                var newNodes:[SIMD3<Int>] = []
                for node in winningLine {
                    let newNodeX = node.x + adjX
                    let newNodeY = node.y + adjY
                    let newNodeZ = node.z + adjZ
                    let newNode = SIMD3(x: newNodeX, y: newNodeY, z: newNodeZ)
                    
                    newNodes.append(newNode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        changeling.send(newNode)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            resetting.send(newNode)
                        }
                    }
                }
                print("newNodes ",newNodes)
                self.winners.append(newNodes)
            }
            
            extractedFunc(postLineV)
        }
        
        
        
        @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            // check what nodes are tapped
            let p = gestureRecognize.location(in: view)
            //            print("p ",p.x,p.y)
            let hitResults = view.hitTest(p, options: [:])
            
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                
                // retrieved the first clicked object
                let result = hitResults[0].node as? NewNode
                
                let node2R = board[(result?.proxy?.x)!][(result?.proxy?.y)!][(result?.proxy?.z)!]
                if (node2R != nil) {
                    
                    node2R!.removeFromParentNode()
                }
                
                if player {
                    print(result?.proxy)
                    let sphereGeometry = SCNSphere(radius: 0.05)
                    sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
                    
                    //                    let sphereNode = SCNNode(geometry: sphereGeometry)
                    let sphereNode = NewNode(proxy: (result?.proxy)!, geometry: sphereGeometry)
                    sphereNode.name = "red"
                    sphereNode.position = result!.position
                    
                    view.scene?.rootNode.addChildNode(sphereNode)
                    //                    tree.add(sphereNode, at: result.node.simdPosition)
                    board[(result?.proxy?.x)!][(result?.proxy?.y)!][(result?.proxy?.z)!] = sphereNode
                    player = false
                } else {
                    print(result?.proxy)
                    let cubeGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
                    cubeGeometry.firstMaterial?.diffuse.contents = UIColor.blue
                    //                    let cubeNode = SCNNode(geometry: cubeGeometry)
                    let cubeNode = NewNode(proxy: (result?.proxy)!, geometry: cubeGeometry)
                    cubeNode.name = "blue"
                    cubeNode.position = result!.position
                    
                    view.scene?.rootNode.addChildNode(cubeNode)
                    //                    tree.add(cubeNode, at: result.node.simdPosition)
                    
                    
                    board[(result?.proxy?.x)!][(result?.proxy?.y)!][(result?.proxy?.z)!] = cubeNode
                    player = true
                }
                
                var dix = 0
                //                for i in winners {
                //                    print("vtap ",i)
                //                }
                
                var color:UIColor? = nil
                if player {
                    color = .blue
                    //                    print("blue")
                } else {
                    color = .red
                    //                    print("red")
                }
                
                
                
                for winner in winners {
                    var winning = 0
                    for win in winner {
                        if (board[win!.x][win!.y][win!.z]) != nil {
                            if board[win!.x][win!.y][win!.z]?.geometry?.firstMaterial?.diffuse.contents as? UIColor == color {
                                winning += 1
                                print("dix \(dix) \(shared)")

                                if shared[dix] == nil {
                                    shared[dix] = MetaMatrix(redCount: 0, blueCount: 0)
                                }
                                if player {
                                    winningBlueDict["\(win!.x)\(win!.y)\(win!.z)"] = winner
                                    shared[dix]?.blueCount += 1
                                } else {
                                    winningRedDict["\(win!.x)\(win!.y)\(win!.z)"] = winner
                                    shared[dix]?.redCount += 1
                                }
                                
                                if shared[dix]!.blueCount > 0 && shared[dix]!.redCount > 0 {
                                    winningJointDict["\(win!.x)\(win!.y)\(win!.z)"] = winner
                                }
                            }
                        }
                    }
                    dix += 1
                    if winning > 0 {
                        if player {
                            for lines in winningBlueDict.values {
                                for node in lines {
                                    debugging.send((UIColor.blue,node!))
                                }
                            }
                        } else {
                            for lines in winningRedDict.values {
                                for node in lines {
                                    debugging.send((UIColor.green,node!))
                                }
                            }
                        }
                        for lines in winningJointDict.values {
                                for node in lines {
                                    debugging.send((UIColor.red,node!))
                                }
                        }
                        
                    }
                    
//                    print("fuckedII ",winningRedDict.count,winningBlueDict.count,winningJointDict.count)
                    
                    
                    
                    if winning == 4 {
                        print("won ",color.debugDescription)
                        gameSetAndMatch.send(color!)
                    }
                    
                }
//                print("fuckedIII ",winningRedDict.count,winningBlueDict.count,winningJointDict.count)
            } else {
                //                extractedFunc1()
                
            }
        }
    }
}
    
class NewNode:SCNNode {
    var proxy: SIMD3<Int>?
    
    init(proxy: SIMD3<Int>, geometry: SCNGeometry) {
        super.init()
        self.geometry = geometry
        self.proxy = proxy
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
        
        
        
