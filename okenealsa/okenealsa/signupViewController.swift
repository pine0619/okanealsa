//
//  signupViewController.swift
//  okenealsa
//
//  Created by 島尻龍之介 on 2019/12/09.
//  Copyright © 2019 松岡　隆斗. All rights reserved.
//

import UIKit
import RealmSwift

class Signup: Object {
    @objc dynamic var username = ""
    @objc dynamic var password = ""
}

class signupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameToSignup: UITextField!
    var userNameToSignup:String = ""
    
    @IBOutlet weak var passwordToSignup: UITextField!
    var passWordToSignup:String = ""
    
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
        let signupid = Signup()
        userNameToSignup = usernameToSignup.text!
        passWordToSignup = passwordToSignup.text!
        let userid = try! Realm()
        
        if (userNameToSignup == "" || passWordToSignup == ""){
            alert(title: "入力ミス", message: "ユーザー名,パスワードを入力してください")
        }
        else{
            signupid.username = userNameToSignup
            signupid.password = passWordToSignup
            
            try! userid.write {
                userid.add(signupid)
            }
            self.performSegue(withIdentifier: "completesignup", sender: nil)
            
            print(userid.objects(Signup.self))
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
