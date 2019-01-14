//
//  ColorPickerViewController.swift
//  ImageToMusic
//
//  Created by Iris on 2019/1/14.
//  Copyright © 2019 HuangXinyi. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    var userImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.image = userImage
    }

    
    
}
