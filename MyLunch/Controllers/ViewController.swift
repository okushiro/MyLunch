//
//  ViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/09.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate {
    
    let user = User.shared
    let userDefaults = UserDefaults.standard
    var pictureImage : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //ログアウトボタン
    @IBAction func didTouchLogoutButton(_ sender: Any) {
        user.logout()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    //撮影ボタン
    @IBAction func didTouchPictureButton(_ sender: Any) {
        //カメラ呼び出し
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
        
    }
    
    //撮影終了後
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //イメージの取得
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            pictureImage = image
            let pngImageData: Data? = image.pngData()
            userDefaults.set(pngImageData, forKey: "image")
            
            //クローズ
            dismiss(animated:true, completion:nil)
            self.performSegue(withIdentifier: "toComment", sender: nil)
        }
    }
    
    //リストボタン
    @IBAction func didTouchListButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
}

