//
//  LoginViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UserDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let user = User.shared
    
    //この関数を実装しないといけない（デリゲートのルール）
    func didCreate(error: Error?) {
        if let error = error{
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    
    func didLogin(error: Error?) {
        if let error = error{
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.delegate = self
        
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
        
        user.create(email: email, password: password)
        
    }
    
    func presentTaskList(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
