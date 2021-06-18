//
//  LoginViewController.swift
//  Login
//
//  Created by Jaspreet Pannu on 2021-06-09.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    
    func validateFields() -> String? {
        
        //check all fields are filled
        if
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all the fields."
        }
        return nil
    }

    

    func setUpElements() {
        ErrorLabel.alpha = 0
        
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(LoginButton)
    }
    
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        //todo validate textfields
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            
            let Email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
    
        
        //create cleaned versions of text field
//        let Email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //signing in the user
        Auth.auth().signIn(withEmail: Email, password: Password) { (result, error) in
            if error != nil{
                //cpuldnot signin
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha = 1
            }
            else {
                
                let homeViewController =  self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
}
     

}
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
}
