//
//  ViewController.swift
//  panButton
//
//  Created by will on 2021/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gifButton: UIButton!
    
    ///按鈕位置
    var buttonPoint: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPanButton()
    }
    
    func setPanButton() {
        
        // 拖曳手勢
        let pan = UIPanGestureRecognizer(
            target:self,
            action:#selector(ViewController.pan(recognizer:)))
        
        // 最少可以用幾指拖曳
        pan.minimumNumberOfTouches = 1
        
        // 最多可以用幾指拖曳
        pan.maximumNumberOfTouches = 1
        
        // 為這個可移動的 Button 加上監聽手勢
        gifButton.addGestureRecognizer(pan)
    }
    
    // 觸發拖曳手勢後 執行的動作
    @objc func pan(recognizer:UIPanGestureRecognizer) {
        
        // 拖移手勢的狀態
        switch recognizer.state {
            
        case .began:
            //開始移動，加入按鈕中心位置
            buttonPoint = gifButton.center
        case .changed:
            //拖移狀態在螢幕上的位置
            let translation = recognizer.translation(in: view)
            //設定要移動按鈕的位置 ＝ 按鈕位置＋目前在畫面上的位置
            gifButton.center = CGPoint(x: buttonPoint.x + translation.x, y: buttonPoint.y + translation.y)
            
        case .ended:
            //畫面的寬度
            guard let viewSize = self.view.superview?.bounds.size.width else {
                print("auotPan Get viewSize Fail")
                return
            }
            
            //如果按鈕結束位置 大於螢幕一半。 決定按鈕要吸附在左邊還是右邊
            if gifButton.center.x >= viewSize / 2 {
                gifButton.frame = CGRect(x: viewSize - gifButton.frame.width, y: gifButton.frame.origin.y, width: gifButton.frame.width, height: gifButton.frame.height)
                
            } else {
                gifButton.frame = CGRect(x: CGFloat(0.0), y: gifButton.frame.origin.y, width: gifButton.frame.width, height: gifButton.frame.height)
            }
        default:
            break
        }
        
    }
}

