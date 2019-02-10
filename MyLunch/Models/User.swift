//
//  User.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import Foundation
import Firebase

protocol UserDelegate: class{
    func didCreate(error: Error?)
    func didLogin(error: Error?)
    func dontLogin()
}

class User {
    //シングルトン実装
    static let shared = User()
    
    weak var delegate: UserDelegate?
    
    private init(){}
    
    var user: FirebaseAuth.User?{
        get{
            return Auth.auth().currentUser
        }
    }
    
    func create(email:String, password:String){
        Auth.auth().createUser(withEmail: email, password: password){(result, error) in
            if let error = error{
                print("❌" + error.localizedDescription)
            }else{
                print("ログイン成功")
                self.delegate?.didCreate(error: error)
                
            }
        }
    }
    
    func login(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password){(result, error) in
            if let error = error{
                print("❌" + error.localizedDescription)
                self.delegate?.dontLogin()
                
            }else{
                print("ログイン成功")
                self.delegate?.didLogin(error: error)
                
            }
        }
    }
    
    func logout(){
        try! Auth.auth().signOut()
    }
    
    func isLogin() -> Bool {
        if user != nil{
            return true
        }
        return false
    }
}
