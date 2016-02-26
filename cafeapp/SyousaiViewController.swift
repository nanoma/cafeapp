//
//  SyousaiViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/23.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit
import Social

class SyousaiViewController: UIViewController {

    @IBOutlet var cafeImageView: UIImageView!
    var selectedImg: Int = 0
    
    var imgArray: [AnyObject] = []
    var nameArray: [AnyObject] = []
    var locationArray: [AnyObject] = []
    var memoArray: [AnyObject] = []
    

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    
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
        /*
        nameArray.append(nameLabel.text!) //配列の指定 !はnilを避けるためにある
        imgArray.append(cafeImageView.image!)
        locationArray.append(locationLabel.text!)
        memoArray.append(memoLabel.text!)
        */
        /*
        saveData.stringForKey("name") //nameのキーから呼び出し
        saveData.stringForKey("location")
        saveData.stringForKey("memo")
        saveData.stringForKey("imageview")
        */
    
        nameLabel.text = String(saveData.arrayForKey("name"))
        locationLabel.text = String(saveData.arrayForKey("location")) //String型として表示？ （）の中始めは変数で、NSUseDefaultsから呼び出し
        
        memoLabel.text = String(saveData.arrayForKey("memo"))
        print(saveData.dataForKey("imageview"))
        cafeImageView.image = UIImage(data: saveData.dataForKey("imageview")!)
    

        // Do any additional setup after loading the view.
    }
    
    
    //NSDataをUIImageに変換する
    func StringImage(imageString:NSData) -> UIImage?{
        
        //NSDataからUIImageを生成？？
        let img = UIImage(data: imageString)
        
        //結果を返却
        return img
    }
    
    
    //SNSへの投稿
    func postToSNS(serviceType: String){
        let myComposeView = SLComposeViewController(forServiceType: serviceType)
        myComposeView.setInitialText("#カフェめも")
        //投稿する画像を指定
        
        //投稿するコメントを指定
        myComposeView.addImage(cafeImageView.image)
        
        //myComposeViewの画面遷移
        self.presentViewController(myComposeView, animated: true, completion: nil)
        
    }
    
    //任意のメッセージとOKボタンを持つアラートのメソッド
    func simpleAlert(titleString: String){
        
        let alertController = UIAlertController(title: titleString, message: nil, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    //アップロード時に呼ばれるメソッド
    @IBAction func upLoadButtonTapped(sender: UIButton){
        
        /*guard let selectedPhoto = cafeImageView.image else{
        simpleAlert("画像がありません")
        return
        }
        */
        
        
        let alertController = UIAlertController(title: "アップロード先を選択", message: nil, preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "Facebookに投稿", style: .Default){
            action in
            self.postToSNS(SLServiceTypeFacebook)
        }
        let secondAction = UIAlertAction(title: "twitterに投稿", style: .Default){
            action in
            self.postToSNS(SLServiceTypeTwitter)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        
        //設定したアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //アラートを表示
        presentViewController(alertController, animated: true, completion: nil)
        
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
