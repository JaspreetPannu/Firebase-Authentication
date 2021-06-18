//
//  SignUpViewController.swift
//  Login
//
//  Created by Jaspreet Pannu on 2021-06-09.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameTextField: UITextField!
    
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

    }
    
    func setUpElements() {
        ErrorLabel.alpha = 0
        
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    func validateFields() -> String? {
        
        //check all fields are filled
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all the fields."
        }
        
        //check password is secure
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 character, contain a special character and a number."
        }
        
        
        return nil
    }
    
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        //validate the fields
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            
            let FirstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let LastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            // create user
            Auth.auth().createUser(withEmail: Email, password: Password) {(result, err) in
                //check for error
                if err != nil  {
                    self.showError("Error creating user")
                }
                
                else{
                    
                    let db = Firestore.firestore()
                    
                    db.collection("Users").addDocument(data: ["FirstName": FirstName, "LastName": LastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("Error saving user data")
                        }
                        
                    }
                    
                    //transition to the home screen
                    self.transitionToHome()
                }
                
                
            }
        }
    }
    
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }

    func transitionToHome() {
        let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
