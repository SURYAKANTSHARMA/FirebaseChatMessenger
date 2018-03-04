//
//  LoginController.swift
//  FirebaseChatMessenger
//
//  Created by SuryaKant Sharma on 18/02/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit
import LBTAComponents
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return view
    }()
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email"
        return textField
    }()
    
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    
    let loginRegisterButton: UIButton = {
       let button = UIButton()
       button.setTitle("Register", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       button.addTarget(self, action: #selector(LoginController.handleLoginRegister), for: .touchUpInside)
       return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "placeholderIcon")
        return imageView
    }()
    
    let loginSignUpSegmentControl: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["Login", "SignUp"])
       //sc.backgroundColor = .black
       sc.tintColor = .white
       sc.selectedSegmentIndex = 1
       sc.addTarget(self, action: #selector(handleLoginSignUpSegmentChange), for: .valueChanged)
       
       return sc
    }()
    @objc func handleLoginSignUpSegmentChange() {
       let title = loginSignUpSegmentControl.titleForSegment(at: loginSignUpSegmentControl.selectedSegmentIndex)
       loginRegisterButton.setTitle(title, for: .normal)
        switch loginSignUpSegmentControl.selectedSegmentIndex {
        case 0:
            heightConstraint?.constant = 100
            nameHeightConstraint?.constant = 0
        case 1:
           heightConstraint?.constant = 150
           nameHeightConstraint?.constant = 50
        default:
            break
        }
       
    }
    
    fileprivate func addSubViews() {
        
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginSignUpSegmentControl)
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeperatorView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeperatorView)
        inputContainerView.addSubview(passwordTextField)

        
    }
    
    var heightConstraint: NSLayoutConstraint?
    var nameHeightConstraint: NSLayoutConstraint?
    fileprivate func addConstraintsToViews() {
        inputContainerView.anchorCenterYToSuperview()
        
        inputContainerView.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor , bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        heightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        heightConstraint?.isActive = true
        loginRegisterButton.anchor(inputContainerView.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 50)
        nameTextField.anchor(inputContainerView.topAnchor, left: inputContainerView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: inputContainerView.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        nameHeightConstraint = nameTextField.heightAnchor.constraint(equalToConstant: 50)
        nameHeightConstraint?.isActive = true
        
        nameSeperatorView.anchor(nameTextField.safeAreaLayoutGuide.bottomAnchor, left: inputContainerView.leftAnchor, bottom: nil, right: inputContainerView.rightAnchor,  topConstant:0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 2)
        
        emailTextField.anchor(nameTextField.safeAreaLayoutGuide.bottomAnchor, left: inputContainerView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: inputContainerView.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 49)
        
        emailSeperatorView.anchor(emailTextField.safeAreaLayoutGuide.bottomAnchor, left: inputContainerView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: inputContainerView.safeAreaLayoutGuide.rightAnchor,  topConstant:0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 2)
        
        passwordTextField.anchor(emailTextField.safeAreaLayoutGuide.bottomAnchor, left: inputContainerView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: inputContainerView.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 49)
      
        
        profileImageView.anchorCenterXToSuperview()
        profileImageView.anchor(nil, left: nil, bottom: loginSignUpSegmentControl.safeAreaLayoutGuide.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        setUpLoginRegisterSetUpControl()
    }
    fileprivate func setUpLoginRegisterSetUpControl() {
        loginSignUpSegmentControl.anchor(nil, left: inputContainerView.leftAnchor, bottom: inputContainerView.topAnchor , right: inputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: inputContainerView.frame.width, heightConstant: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        addSubViews()
        addConstraintsToViews()
        
        
        
    }
    
    @objc func handleLoginRegister() {
        loginSignUpSegmentControl.selectedSegmentIndex == 0 ? handleLogin(): handleRegister()
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //successfully login user
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // save in dataBase to persist
            let ref = Database.database().reference().child("users").child(user!.uid)
            let values = ["name": name, "email": email]
            ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                print("User successfully saved in database")
                self.dismiss(animated: true, completion: nil)
            })
        }

    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
