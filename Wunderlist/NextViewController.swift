//
//  NextViewController.swift
//  Wunderlist
//
//  Created by Kiyoto Ryuman on 2019/05/04.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UITextViewDelegate {
    var selectedNumber: Int = 0
    @IBOutlet weak var textView: UITextView!
    
    var screenShotImage: UIImage = UIImage()
    var titleArray: Array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "Array") != nil {
            titleArray = UserDefaults.standard.object(forKey: "Array") as! [String]
            textView.text = titleArray[selectedNumber]
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder{
            
            textView.resignFirstResponder()
        }
    }
    
    func takeScreenShot(){
        
        // キャプチャしたい枠を決める
        
        let rect = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.width, height: textView.frame.height)
        
        
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        textView.drawHierarchy(in: rect, afterScreenUpdates: true)
        
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func shareLine(_ sender: Any) {
        takeScreenShot()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            
            
            let pastBoard: UIPasteboard = UIPasteboard.general
            
            
            
            pastBoard.setData(self.screenShotImage.jpegData(compressionQuality: 0.75)!, forPasteboardType: "public.png")
            
            
            
            let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
            
            
            
            UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
            
            
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
