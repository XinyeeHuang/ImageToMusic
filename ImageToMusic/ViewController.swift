//
//  ViewController.swift
//  ImageToMusic
//
//  Created by Iris on 2019/1/11.
//  Copyright © 2019 HuangXinyi. All rights reserved.
//  

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        selectAlbum()
    }
    
    //MARK: 上传图片
    //选取相册
    func selectAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        } else {
            print("无法读取相册")
        }
    }
    
    //设置代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info)
        let image: UIImage!
        image = info[.originalImage] as? UIImage
        imageView.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

