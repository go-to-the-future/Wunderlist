//
//  SettingViewController.swift
//  Wunderlist
//
//  Created by Kiyoto Ryuman on 2019/05/04.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var sv: UIScrollView!
     var vc = UIView()
    @IBOutlet weak var backImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        vc.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        for i in 0..<10{
            
            let button: UIButton = UIButton()
            button.tag = i
            button.frame = CGRect(x: i*80, y: 0, width: 80, height: 80)
            let buttonImage:UIImage = UIImage(named: String(i) + ".jpg")!
            button.setImage(buttonImage, for: .normal)
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
            vc.addSubview(button)
        }
        
        sv.addSubview(vc)
        sv.contentSize = vc.bounds.size
    }
    
    @objc func selectImage(sender: UIButton){
        backImageView.image = UIImage(named: String(sender.tag) + ".jpg")
        
        UserDefaults.standard.set(String(sender.tag), forKey: "Image")
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
