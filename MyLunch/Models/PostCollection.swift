//
//  PostCollection.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import Foundation

protocol PostCollectionDelegate:class {
    func saved()
}

class PostCollection {
    static var shared = PostCollection()
    
    let userDefaults = UserDefaults.standard
    private var posts: [Post] = []
    
    weak var delegate: PostCollectionDelegate?
    
    private init() {
        self.load()
    }
    
    func getPost (at: Int) -> Post{
        return posts[at]
    }
    
    func postCount () -> Int{
        return posts.count
    }
    
    // タスクの追加
    func addPost (_ post: Post) {
        posts.append(post)
        self.save()
    }
    
    // タスクの削除
    func removePost (at: Int) {
        posts.remove(at: at)
        self.save()
    }
    
    func save () {
        // シリアル化
        let data = try! PropertyListEncoder().encode(posts)
        // UserDefaultsにtasksという名前で保存
        userDefaults.set(data, forKey: "posts")
        // デリゲートを使ってフックを作っている。保存したら実行
        delegate?.saved()
    }
    
    func load() {
        if let data = userDefaults.data(forKey: "posts") {
            let posts = try! PropertyListDecoder().decode([Post].self, from: data)
            self.posts = posts
        }
    }
}

