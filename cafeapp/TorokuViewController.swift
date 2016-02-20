//
//  TorokuViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/20.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit
import Social

class TorokuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var cafeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
