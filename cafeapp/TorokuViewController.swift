//
//  TorokuViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/20.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit
import Social

class TorokuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var cafeImageView: UIImageView!
    
    var imgArray: [AnyObject] = []
    var nameArray: [AnyObject] = []
    var locationArray: [AnyObject] = []
    var memoArray: [AnyObject] = []
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var name: String = ""
    var location: String = ""
    var memo: String = ""
    
    
    var cafe = Cafe()

    
    var selectedImage: UIImage?
    
    
    let saveData = NSUserDefaults.standardUserDefaults() //画像・テキストを保存するため


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cafeList = NSUserDefaults.standardUserDefaults().objectForKey("cafeList")
        
        /*データを保存
        if let cafeListData = NSUserDefaults.standardUserDefaults().objectForKey("cafeList") as? NSData {
            print("success")
            if let cafeList = NSKeyedUnarchiver.unarchiveObjectWithData(cafeListData) as? [Cafe] {
                print(cafeList)
                
                let cafe3 = Cafe()
                cafe3.location = "location Sapporo"
                
                cafeList.append(cafe3)
                
                let cafeListData = NSKeyedArchiver.archivedDataWithRootObject(cafeList)
                
                NSUserDefaults.standardUserDefaults().setObject(cafeListData, forKey: "cafeList")

            }
        }else{
            print("error")
        }
        
        let cafe1 = Cafe()
        cafe1.location = "location"
        
        let cafe2 = Cafe()
        cafe2.memo = "memo"
        
        let cafeList2 = [cafe1,cafe2]
        let cafeListData = NSKeyedArchiver.archivedDataWithRootObject(cafeList2)
        
        NSUserDefaults.standardUserDefaults().setObject(cafeListData, forKey: "cafeList")
        
        
        if let cafeList = NSUserDefaults.standardUserDefaults().objectForKey("cafeList") as? [Cafe] {
            print("success2")
        }
        
        */
        // Do any additional setup after loading the view. 
    }
    
    //カメラ・アルバム呼び出しメソッド
    func precentPickerController(sourceType: UIImagePickerControllerSourceType){
        //ライブラリが使用できるか確認
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //画像を出力
        cafeImageView.image = image

    }
    
    //カメラ呼び出しボタン
    @IBAction func selctButtonTapped(sender: UIButton){
        
        //選択肢の上に表示するタイトル
        let alertController = UIAlertController(title: "カバー画像", message: nil, preferredStyle: .ActionSheet)
        
        //選択肢の名前と処理を1つずつ設定
        let firstAction = UIAlertAction(title: "カメラで撮影する", style: .Default){
            action in
            self.precentPickerController(.Camera)
        }
        
        let secondAction = UIAlertAction(title: "アルバムから選ぶ", style: .Default){
            action in
            self.precentPickerController(.PhotoLibrary)
        }
        
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler:nil)
        
        //設定したアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //アラートを表示
        presentViewController(alertController, animated: true, completion: nil)

    }
    
    //SNSへの投稿
    func postToSNS(serviceType: String){
        let myComposeView = SLComposeViewController(forServiceType: serviceType)
        myComposeView.setInitialText("cafememoからの投稿")
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
    
    
    //配列の保存？
    @IBAction func savePage(){
        nameArray.append(nameTextField.text!) //配列の指定 !はnilを避けるためにある
        imgArray.append(cafeImageView.image!)
        locationArray.append(locationTextField.text!)
        
        saveData.setObject(name, forKey: "name") //nameのキーにnameを保存
        saveData.setObject(location, forKey: "location")
        saveData.setObject(memo, forKey: "memo")
        saveData.setObject(cafeImageView.image, forKey: "imageview") //NS型に変換という説もあり？
        
        }
    


    
    /*戻る
    @IBAction func exitTo(segue: UIStoryboardSegue) {
        if (segue.identifier == "back") {
        }
        
    }
    */

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
