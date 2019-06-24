//
//  AddTableViewController.swift
//  firestore
//
//  Created by 李浩綸 on 2019/5/6.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import Firebase

//靜態TableView不能實作
class AddTableViewController: UITableViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var urlField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addUser(_ sender:UIBarButtonItem){
        var message = ""
        
        
        //因為預設為空字串所以敢!
        switch (nameField.text!, urlField.text!) {
        case ("",""):
            
            message = "不能是空的"
            
        case (_,""):
            
            message = "url不能是空的"
            
        case ("",_):
            
            message = "name不能是空的"
            
            //val building
        //使用return就不會跳出來了
        case let(name,url):
            saveToFireStore(userData: [
                "name":name,
                "url":url,
                "time":Date().timeIntervalSince1970
                ])
            return
        }
        
        
        //!=不等於
        //做出一個跳出視窗 
        if message != ""{
            let alertContrller = UIAlertController(title: "警告", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertContrller.addAction(alertAction)
            
            //presend
            present(alertContrller, animated: true, completion: nil)
        }
        
        
        
    }
    //自行建立的
    func saveToFireStore(userData users:[String:Any]){
        let _ = Firestore.firestore().collection("presidents").addDocument(data: users) { (error:Error?) in
            if let error = error{
                print("error:\(error)")
            }else{
                print("新增成功")
                //用let _是為了增加可讀性
                //讓他跳回原本的頁面
                let _ = self.navigationController!.popViewController(animated: true)
            }
        }
    }
    
}
