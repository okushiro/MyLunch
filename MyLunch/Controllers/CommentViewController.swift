//
//  CommentViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var pictureImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //カメラ呼び出し
//        let picker = UIImagePickerController()
//        picker.sourceType = .camera
//        picker.delegate = self
//        self.present(picker, animated: true, completion: nil)
//
//        //撮影終了後
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            //イメージの取得
//            pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            //クローズ
//            dismiss(animated:true, completion:nil);
//
//        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func didTouchSaveButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
