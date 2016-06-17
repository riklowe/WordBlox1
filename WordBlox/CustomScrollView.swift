
//  Created by Dominik on 9/01/2016.

//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

//    v1.1
//    https://github.com/crashoverride777/Swift2-SpriteKit-UIScrollView-Helper

import SpriteKit

/*============================================================*/
/*============================================================*/
/*============================================================*/

/// Nodes touched
var nodesTouched: [AnyObject] = [] // global

/*============================================================*/
/*============================================================*/
/*============================================================*/

/// Scroll direction
enum ScrollDirection: Int {
    case none = 0
    case vertical
    case horizontal
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties
    
    /// Touches allowed
    static var disabledTouches = false
    
    /// Scroll view
    private static var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    /// Current scene
    private weak var currentScene: SKScene?
    
    /// Current view
    private weak var currentView: UIView?
    
    /// Moveable node
    private var moveableNode: SKNode?
    
    /// Scroll direction
    private var scrollDirection = ScrollDirection.none
    
    // MARK: - Init
    init(frame: CGRect, scene: SKScene, moveableNode: SKNode, scrollDirection: ScrollDirection, view: UIView) {
        
        print("Scroll View init")
        super.init(frame: frame)
        
        CustomScrollView.scrollView = self
        self.scrollDirection = scrollDirection
        self.currentScene = scene
        self.moveableNode = moveableNode
        self.frame = frame
        indicatorStyle = .white
        isScrollEnabled = true
        
        //directionalLockEnabled = true

        let boxPath5 = UIBezierPath(rect: self.frame)
        let box5 = SKShapeNode(path: boxPath5.cgPath)
        box5.strokeColor = SKColor.black()
        box5.lineWidth = 5.0
        scene.addChild(box5)
        
        print ("CustomScrollView scene: \(scene.frame)")
        print ("CustomScrollView view: \(view.frame)")

        isPagingEnabled = true
        bounces = false

        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        minimumZoomScale = 1
        maximumZoomScale = 10
        //zoomScale = 1.0
        
        canCancelContentTouches = false
        isUserInteractionEnabled = true
        
        zoomScale = 5.0
        
        delegate = self
        
        // flip for spritekit (only needed for horizontal)
        if self.scrollDirection == .horizontal {
            let flip = CGAffineTransform(scaleX: -1,y: -1)
            self.transform = flip
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

// MARK: - Touches
extension CustomScrollView {
    
    /// began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch began scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesBegan(touches, with: event)
    }
    
    /// moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch moved scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesMoved(touches, with: event)
    }
    
    /// ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch ended scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesEnded(touches, with: event)
    }
    
    /// cancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch cancelled scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesCancelled(touches, with: event)
    }
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

// MARK: - Touch Controls
extension CustomScrollView {
    
    /// Disable
    class func disable() {
        print("Disabled scroll view")
        CustomScrollView.scrollView?.isUserInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
    /// Enable
    class func enable() {
        print("Enabled scroll view")
        CustomScrollView.scrollView?.isUserInteractionEnabled = true
        CustomScrollView.disabledTouches = false
    }
}

/*============================================================*/
/*============================================================*/
/*============================================================*/

// MARK: - Delegates
extension CustomScrollView: UIScrollViewDelegate {
    
    /// did scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("Scroll view did scroll")
        
        if scrollDirection == .horizontal {
            moveableNode?.position.x = scrollView.contentOffset.x
        } else {
            moveableNode?.position.y = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
            print ("scrollViewDidZoom")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print ("viewForZoomingInScrollView")
        return self.currentView
    }
    
}

//required init(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//}

