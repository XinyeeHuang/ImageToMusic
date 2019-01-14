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
    
    @IBOutlet weak var bgImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //显示用户选取的图片
        userImageView.image = userImage
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            // 获取用户点击位置在图像上的相对位置
            let point = touch.location(in: userImageView)
            // 将点击位置转换为像素索引
            let pixelIndex = userImageView.pixelIndex(for: point) ?? 0
            // 根据图像大小提取图像像素
            let pixels = userImageView.pixels ?? []
            // 获取目标像素,设置 view 的背景颜色
            bgImageView.backgroundColor = userImageView.extraColor(for: pixels[pixelIndex])
            // 播放目标像素对应的音调
            
        } else {
            return
        }
    }
    
}


//扩展UIImage,获取图片所有像素
public extension UIImage {
    
    //坑：UIImageView显示图像时，图像会根据显示大小进行缩放。获取某一点的像素，需要根据当前显示大小进行处理
    
    // 根据图片大小提取像素
    //size: 图片大小
    //return: 像素数组
    public func extraPixels(in size: CGSize) -> [UInt32]? {
        if let cgImage = cgImage{
            let width = Int(size.width)
            let height = Int(size.height)
            
            // 颜色空间为RGB
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            // 设置位图颜色分布为 RGBA
            let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
            
            // 一个像素 4 个字节，则一行共 4 * width 个字节
            let bytesPerRow = 4 * width
            // 每个字节有 8 位（bit）
            let bitsPerComponent = 8
            
            //用repeatElement来创建含有相同元素的数组
            var pixelsData = [UInt32](repeatElement(0, count: width * height))
            
            if let content = CGContext(data: &pixelsData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo){
                
                content.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                return pixelsData
                
            } else {
                return nil
            }
            
        } else {
            return nil
        }
        
    }
}



public extension UIImageView {
    
    // 图像像素
    public var pixels: [UInt32]? {
        return image?.extraPixels(in: bounds.size)
    }
    
    // 将位置转换为像素索引
    // point: 位置
    // return: 像素索引
    public func pixelIndex(for point: CGPoint) -> Int? {
        let size = bounds.size
        if point.x > 0 && point.x <= size.width
            && point.y > 0 && point.y <= size.height {
            return (Int(point.y) * Int(size.width) + Int(point.x))
        } else {
            return nil
        }
        
    }
    
    // 将像素值转换为颜色
    // pixel: 像素值
    // return: 颜色
    public func extraColor(for pixel: UInt32) -> UIColor {
        // “&”与+移位——滤码，获得rgb数据
        //【具体数值貌似有点问题，还需要再找一下转化为rgb的方法】
        let r = Int((pixel >> 16) & 0xff)
        let g = Int((pixel >> 8) & 0xff)
        let b = Int((pixel >> 0) & 0xff)
        print("r: \(CGFloat(r)), g: \(CGFloat(g)), b: \(CGFloat(b))")
        //坑：滤码得到的范围是 0～255，swift 中 UIColor 的 rbg 值范围是 0.0 ～1.0
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
}
