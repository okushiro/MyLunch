//
//  PostViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    let postCollection = PostCollection.shared
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedPost = self.selectedPost else{return}
        self.titleTextLabel.text = selectedPost.title
        self.commentTextLabel.text = selectedPost.note
        self.tagLabel.text = selectedPost.label
        let stringImage = selectedPost.image
        if let data = Data(base64Encoded: stringImage) {
            image.image = UIImage(data: data)
        } else {
            image.image = nil
        }

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

}
