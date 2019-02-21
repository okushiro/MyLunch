//
//  ViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/09.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import CoreML
import Vision
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate, FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    let user = User.shared
    let userDefaults = UserDefaults.standard
    var model = try! VNCoreMLModel(for: MobileNet().model)

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
        var image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //画像向きの補正
        let size = image.size
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let pngImageData: Data? = image.pngData()
        userDefaults.set(pngImageData, forKey: "image")
            
        //クローズ
        dismiss(animated:true, completion:nil)
        predict(image)
        self.performSegue(withIdentifier: "toComment", sender: nil)
        
    }
    
    //リストボタン
    @IBAction func didTouchListButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    //画像認識
    func predict(_ image: UIImage) {
        DispatchQueue.global(qos: .default).async {
            //リクエストの生成
            let request = VNCoreMLRequest(model: self.model) {
                request, error in
                //エラー処理
                if error != nil {
                    self.alert("エラー", "", nil)
                    return
                }
                
                //検出結果の取得
                let observations = request.results as! [VNClassificationObservation]
                let label = observations[0].identifier
                self.userDefaults.setValue(label, forKey: "aiLabel")
//                let commentViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
//                commentViewController.aiLabel = label
            }
            
            //入力画像のリサイズ指定
            request.imageCropAndScaleOption = .centerCrop
            
            //UIImageをCIImageに変換
            let ciImage = CIImage(image: image)!
            
            //画像の向きの取得
            let orientation = CGImagePropertyOrientation(
                rawValue: UInt32(image.imageOrientation.rawValue))!
            
            //ハンドラの生成と実行
            let handler = VNImageRequestHandler(
                ciImage: ciImage, orientation: orientation)
            guard (try? handler.perform([request])) != nil else {return}
        }
    }
}

