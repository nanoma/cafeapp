//
//  ListTableViewController.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/21.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //画像・店舗名等配列の宣言
    
    var imgArray: [AnyObject] = []
    var nameArray: [AnyObject] = []
    var locationArray: [AnyObject] = []
    var memoArray: [AnyObject] = []
    
    
    var name: String = ""
    var location: String = ""
    var memo: String = ""
    
    var selectedImage: UIImage?
    var selectedLabel1: String!
    var selectedLabel2: String!
    var selectedLabel3: String!
    
    var nameIndex: Int = 0
    
    
    let saveData = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        //TableCellを使えるようにする
        tableView.registerNib(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    //保存したらNSUserDefaultsからリストに読み込む
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        
        tableView.reloadData()
    }
    
    //NSDataをUIImageに変換する
    func StringImage(imageString:NSData) -> UIImage?{
        
        //NSDataからUIImageを生成？？
        let img = UIImage(data: imageString)
        
        //結果を返却
        return img
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source   簡単に戻ってこられる！
    
    //セクションの数を指定
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの個数を指定
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //セルの中身の表示を設定
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListTableViewCell
        
//        let nowIndexPathDictionaly: (AnyObject) = nameArray[indexPath.row]
        
        //nameArrayの配列をnameラベルに表示
        cell.nameLabel.text = nameArray[indexPath.row] as? String
        return cell //戻り値
        
    }
    
    
//    
//    // Cell が選択された場合
//    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
//        
//        // [indexPath.row] から画像名を探し、UImage を設定
//        
//        selectedImage =  UIImage (named:"\(imgArray[indexPath.row])")
//        
//        //[indexPath.row] からnameを探し、UILabel を設定
//        
//        selectedLabel1 = nameArray[indexPath.row] as! String
//        
//        
//        //[indexPath.row] からlocationを探し、UILabel を設定
//        
//        selectedLabel2 = locationArray[indexPath.row] as! String
//
//        
//        //[indexPath.row] からmemoを探し、UILabel を設定
//        
//        selectedLabel2 = locationArray[indexPath.row] as! String
//        
//        /*
//        selectedLabel = UILabel(named:"\(memoArray[indexPath.row])")
//        */
//        
//        if selectedImage != nil {
//            // SyousaiViewController へ遷移するために Segue を呼び出す
//            performSegueWithIdentifier("toSyousaiView",sender: nil)
//        }
//        
//        if selectedLabel1 != nil {
//            // SyousaiViewController へ遷移するために Segue を呼び出す
//            performSegueWithIdentifier("toSyousaiView",sender: nil)
//        }
//        
//        if selectedLabel2 != nil {
//            // SyousaiViewController へ遷移するために Segue を呼び出す
//            performSegueWithIdentifier("toSyousaiView",sender: nil)
//        }
//        
//        if selectedLabel3 != nil {
//            // SyousaiViewController へ遷移するために Segue を呼び出す
//            performSegueWithIdentifier("toSyousaiView",sender: nil)
//        }
//        
//    }
//    
       override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
            nameIndex = indexPath.row //代入　indexPath.rowがセルについてる数字（何番目の配列か）
            self.performSegueWithIdentifier("toSyousaiView", sender: nil)
        
        
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toSyousaiView") {
            
            
            let subVC: SyousaiViewController = (segue.destinationViewController as? SyousaiViewController)!
            // SyousaiViewController のselectedImgに選択された画像を設定する
            subVC.selectedImg = nameIndex  //何番目の配列を取り出すかがselectedImg
            
            
        }
    }



    /* override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    
    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
