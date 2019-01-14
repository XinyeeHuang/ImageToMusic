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
    var image: UIImage!
    //图片是否加载成功，页面可以跳转
    var canTurn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        selectImage()
    }
    
    //MARK: 上传图片
    //选取相册
    func selectImage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: nil)
        } else {
            print("无法读取相册")
        }
    }
    
    //选取图片完成
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info)
        image = info[.originalImage] as? UIImage
        //将图片显示在视图中
        imageView.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
        canTurn = true
    }
    //取消选择
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("已取消")
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: 页面跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        if let colorPickerVC = destinationVC as? ColorPickerViewController, segue.identifier == "didUpload", canTurn == true {
            colorPickerVC.userImage = image
        }
    }
}

