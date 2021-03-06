//
//  TorokuViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/20.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit

class TorokuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var cafeImageView: UIImageView!
    
    //配列の中身は空ですよ
    var imgArray: [AnyObject] = []
    var nameArray: [AnyObject] = []
    var locationArray: [AnyObject] = []
    var memoArray: [AnyObject] = []
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    // name,location,memoに記入される文字列
    var name: String = ""
    var location: String = ""
    var memo: String = ""
    

    var cafe = Cafe()

    
    var selectedImage: UIImage?
    
    
    let saveData = NSUserDefaults.standardUserDefaults() //画像・テキストを保存するため


    override func viewDidLoad() {
        super.viewDidLoad()


        
         /*データを保存
        var cafeList = NSUserDefaults.standardUserDefaults().objectForKey("cafeList")
        
       
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
        
        //前回保存したものを呼び出し（リストに追加で表示できるようにする）
        if saveData.arrayForKey("name") != nil{
            nameArray = saveData.arrayForKey("name")!
            print("\(nameArray.count)")
        }
        
        if saveData.arrayForKey("location") != nil{
            locationArray = saveData.arrayForKey("location")!
            print("\(locationArray.count)")
            
        }
        
        if saveData.arrayForKey("memo") != nil{
            memoArray = saveData.arrayForKey("memo")!
            print("\(memoArray.count)")
        }
        
        if saveData.arrayForKey("imageview") != nil{
            imgArray = saveData.arrayForKey("imageview")!
            print("\(imgArray.count)")
        }
        
        //navigationvarの色指定
        let naviColor = UIColor(red: 101/255, green: 186/255, blue: 164/255, alpha: 1.0)
        
        // 背景の色を変える
        self.navigationController?.navigationBar.barTintColor = naviColor
        
        // itemボタン色指定
        let textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        // ボタンの色を変える
        self.navigationController?.navigationBar.tintColor = textColor
        
        //textFiel の情報を受け取るための delegate を設定
        nameTextField.delegate = self
        locationTextField.delegate = self
        memoTextField.delegate = self
        
        
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
    
     //UIImageをNSDataに変換
    
    func ImageString(image:UIImage) -> NSData {
    
        let data:NSData = UIImagePNGRepresentation(image)!

    return data
    
    }
    
    func simpleAlert(titleString: String){
        let alertController = UIAlertController(title: titleString, message: nil, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    //配列の保存
    @IBAction func savePage(){
        
        //画像が配置されていませんアラート
        guard let selectedPhoto = cafeImageView.image else {
            simpleAlert("画像を選択してください")
            return
        }
        
        nameArray.append(nameTextField.text!) //配列の指定 !はnilを避けるため
        imgArray.append(self.ImageString(cafeImageView.image!))
        locationArray.append(locationTextField.text!)
        memoArray.append(memoTextField.text!)
        
        saveData.setObject(nameArray, forKey: "name") //nameのキーにnameを保存（nameのキーに入っている一語のみを取り出している）
        saveData.setObject(locationArray, forKey: "location")
        saveData.setObject(memoArray, forKey: "memo")
        saveData.setObject(imgArray, forKey: "imageview")
        
        
        self.ImageString(cafeImageView.image!)
        
        saveData.synchronize()
        
        self.performSegueWithIdentifier("toListView", sender: nil) //登録一覧へ遷移 
        
      
        }
    //textFieldを終了させる
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    //textfieldを入力するときにキーボードと重ならないようにする
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "keyboardWillBeShown:",
//            name: UIKeyboardWillShowNotification,
//            object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "keyboardWillBeHidden:",
//            name: UIKeyboardWillHideNotification,
//            object: nil)
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        NSNotificationCenter.defaultCenter().removeObserver(self,
//            name: UIKeyboardWillShowNotification,
//            object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self,
//            name: UIKeyboardWillHideNotification,
//            object: nil)
//    }
//    
//    func keyboardWillBeShown(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
//                restoreScrollViewSize()
//                
//                let convertedKeyboardFrame = scrollView.convertRect(keyboardFrame, fromView: nil)
//                let offsetY: CGFloat = CGRectGetMaxY(textField.frame) - CGRectGetMinY(convertedKeyboardFrame)
//                if offsetY < 0 { return }
//                updateScrollViewSize(offsetY, duration: animationDuration)
//            }
//        }
//    }
//    
//    func keyboardWillBeHidden(notification: NSNotification) {
//        
//        restoreScrollViewSize()
//    }
//    
//    // MARK: - UITextFieldDelegate
//    
//    func locationTextFieldShouldReturn(textField: UITextField) -> Bool {
//        locationTextField.resignFirstResponder()
//        return true
//    }
//    
//    func memoTextFieldShouldReturn(textField: UITextField) -> Bool {
//        memoTextField.resignFirstResponder()
//        return true
//    }
//    
//    func updateScrollViewSize(moveSize: CGFloat, duration: NSTimeInterval) {
//        UIView.beginAnimations("ResizeForKeyboard", context: nil)
//        UIView.setAnimationDuration(duration)
//        
//        let contentInsets = UIEdgeInsetsMake(0, 0, moveSize, 0)
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//        scrollView.contentOffset = CGPointMake(0, moveSize)
//        
//        UIView.commitAnimations()
//    }
//
    
    

    

    
    
    /* Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toListView") {
            let listView: ListTableViewController = (segue.destinationViewController as? ListTableViewController)!
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
