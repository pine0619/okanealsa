//
//  LoginViewController.swift
//  okenealsa
//
//  Created by 島尻龍之介 on 2019/11/22.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var username: UITextField!
    var username_data:String = ""
    
    @IBOutlet weak var password: UITextField!
    var password_data:String = ""
    
    var alertController: UIAlertController!
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func signup(_ sender: Any) {
        username_data = username.text!
        password_data = password.text!
        
        if (username_data == "" || password_data == "") {
            alert(title: "入力漏れ",message: "username,passwordを入力してください")
        }
        else{
            self.performSegue(withIdentifier: "Login", sender:nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
