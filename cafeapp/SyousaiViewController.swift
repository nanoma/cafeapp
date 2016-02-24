//
//  SyousaiViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/23.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit

class SyousaiViewController: UIViewController {

    @IBOutlet weak var cafeImageView: UIImageView!
    var selectedImg: UIImage!
    
    var imgArray: [AnyObject] = []
    var nameArray: [AnyObject] = []
    var locationArray: [AnyObject] = []
    var memoArray: [AnyObject] = []
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var memoTextField: UILabel!
    
    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         //画像を取り出す
        cafeImageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        cafeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        */
        
        //TorokuViewの配列を保持して取り出す
        
        nameArray.append(nameLabel.text!) //配列の指定 !はnilを避けるためにある
        imgArray.append(cafeImageView.image!)
        locationArray.append(locationLabel.text!)
        
        saveData.stringForKey("name") //nameのキーから呼び出し
        saveData.stringForKey("location")
        saveData.stringForKey("memo")
        saveData.stringForKey("imageview")
    

        // Do any additional setup after loading the view.
    }
    
    //StringをUIImageに変換する
    func StringImage(imageString:String) -> UIImage?{
        
        //空白を+に変換する
        var base64String = imageString.stringByReplacingOccurrencesOfString(" ", withString:"+",options: nil, range:nil)
        
        //BASE64の文字列をデコードしてNSDataを生成
        let decodeBase64:NSData? =
        NSData(base64EncodedString:base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        //NSDataの生成が成功していたら
        if let decodeSuccess = decodeBase64 {
            
            //NSDataからUIImageを生成
            let img = UIImage(data: decodeSuccess)
            
            //結果を返却
            return img
        }
        
        return nil
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
