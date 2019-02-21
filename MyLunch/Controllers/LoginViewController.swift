//
//  LoginViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UserDelegate, FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error")
            return
        }
        presentTitle()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var FBLoginBtn: FBSDKLoginButton!
    
    var window: UIWindow?
    let user = User.shared
    
    
    func didCreate(error: Error?) {
        if let error = error{
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTitle()
    }
    
    func didLogin(error: Error?) {
        if let error = error{
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTitle()
    }
    
    func dontLogin() {
        alert("エラー", "メールアドレスまたはパスワードが間違っています", nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    //FB
    override func viewDidAppear(_ animated: Bool) {
        // ログイン済みかチェック
        if let token = FBSDKAccessToken.current() {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    // ...
                    return
                }
                // ログイン時の処理
//                self.presentTitle()
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let initialviewController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
//                self.window?.rootViewController = initialviewController
            }
            return
        }
        // ログインボタン設置
//        let fbLoginBtn = FBSDKLoginButton()
        FBLoginBtn.readPermissions = ["public_profile", "email"]
//        fbLoginBtn.center = self.view.center
        FBLoginBtn.delegate = self
//        self.view.addSubview(fbLoginBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    @IBAction func logoutButton(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func didTouchNewButton(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if(email.isEmpty){
            alert("エラー", "メールアドレスを入力して下さい", nil)
            return
        }
        if(password.isEmpty){
            alert("エラー", "パスワードを入力して下さい", nil)
            return
        }
        
        user.create(email: email, password: password)
        
    }
    
    
    @IBAction func didTouchLoginButton(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if(email.isEmpty){
            alert("エラー", "メールアドレスを入力して下さい", nil)
            return
        }
        if(password.isEmpty){
            alert("エラー", "パスワードを入力して下さい", nil)
            return
        }
        
        user.login(email: email, password: password)
        
    }
    
    func presentTitle(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
