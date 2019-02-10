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
    
    var pictureImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //ログアウトボタン
    @IBAction func didTouchLogoutButton(_ sender: Any) {
    }
    
    //撮影ボタン
    @IBAction func didTouchPictureButton(_ sender: Any) {
        //カメラ呼び出し
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
        //撮影終了後
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //イメージの取得
            pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //クローズ
            dismiss(animated:true, completion:nil);
        }
        
        performSegue(withIdentifier: "toComment", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? CommentViewController
        let _ = next?.view
        next?.pictureImage.image = pictureImage.image
    }
    
    //リストボタン
    @IBAction func didTouchListButton(_ sender: Any) {
    }
}

