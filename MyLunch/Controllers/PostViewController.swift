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
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedPost = self.selectedPost{
            self.titleTextLabel.text = selectedPost.title
            self.commentTextLabel.text = selectedPost.note
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
