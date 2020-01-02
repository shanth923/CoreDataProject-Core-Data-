//
//  SecondViewController.swift
//  CoreDataProject
//
//  Created by R Shantha Kumar on 12/20/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class SecondViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate{
    
    
       var managedObject:NSManagedObjectContext!
       var appDelegate:AppDelegate!
       var personalDetails:NSEntityDescription!
    var imageData:NSData!
    
    
    var imagePicker = UIImagePickerController()
    
    
    var name:HoshiTextField!
    var age:HoshiTextField!
    var email:HoshiTextField!
    
    
    var imageButton:UIButton!
    
    var submitButton:UIButton!
    
   
    
    @IBOutlet weak var contentView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      uiDiplayPath()
        
       appDelegate = UIApplication.shared.delegate as? AppDelegate
                     
        managedObject = appDelegate.persistentContainer.viewContext
        
        name.delegate = self
        age.delegate = self
        email.delegate = self
        // Do any additional setup after loading the view.
    }
    
   
 
    
    func uiDiplayPath(){
        
        imageButton = UIButton()
        imageButton.frame = CGRect(x: 110, y: 50, width: 200, height: 200)
        imageButton.setBackgroundImage(UIImage(named: "defaultProfile"), for: UIControl.State.normal)
        imageButton.layer.cornerRadius = imageButton.frame.size.width/2
        imageButton.clipsToBounds = true
        imageButton.addTarget(self, action: #selector(imageButtonActionc(object:)), for: UIControl.Event.touchUpInside)
        contentView.addSubview(imageButton)
        
        
        
        
           name = HoshiTextField()
           name.frame = CGRect(x: 100, y: 320, width: 200, height: 50)
           name.placeholder = "Name"
           name.borderInactiveColor = .white
           name.placeholderColor = .white
           name.textColor = .white
           name.borderActiveColor = .white
           contentView.addSubview(name)
           
           age = HoshiTextField()
           age.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
           age.borderActiveColor = .white
           age.borderInactiveColor = .white
           age.placeholder = "Age"
           age.textColor = .white
           age.placeholderColor = .white
           contentView.addSubview(age)
           
           email = HoshiTextField()
           email.frame = CGRect(x: 100, y: 480, width: 200, height: 50)
           email.borderInactiveColor = .white
           email.borderActiveColor = .white
           email.placeholderColor = .white
           email.textColor = .white
           email.placeholder = "Email"
           contentView.addSubview(email)
           
           
           submitButton = UIButton()
           submitButton.frame = CGRect(x: 140, y: 570, width: 100, height: 50)
           submitButton.backgroundColor = .systemBlue
           submitButton.setTitle("SUBMIT", for: UIControl.State.normal)
           submitButton.layer.cornerRadius = submitButton.frame.size.width/6
           submitButton.clipsToBounds = true
           submitButton.addTarget(self, action: #selector(saveButton), for: UIControl.Event.touchUpInside)
           contentView.addSubview(submitButton)
        
           
           
           }
    
//    alerts
    
    
    var msg:String!
    
    func alerts(){
        
        var alert = UIAlertController.init(title: "WARNING", message: "\(msg!)", preferredStyle: UIAlertController.Style.alert)
            var alertACtion = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.default) { (cacel) in
                
                 
                
                
            }
                 alert.addAction(alertACtion)
            
            present(alert, animated: true, completion: nil)
            
        }
    
    
// validations
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if(textField == name){
            return true
           
        }
        
        if(textField == age){
            
            if(name.text!.count >= 1){
                
                return true
            }else{
                
                msg = "fill one by one"
                alerts()
                return false
                
            }
            
        }
            
            
        if(textField == email){
            
            if(name.text!.count >= 1 && Int(age.text!)! < 120 && Int(age.text!)! > 0){
                
                return true
            }else{
                msg = "give age properlty"
                alerts()
                return false
            }
   
  
    }
         return true
}

     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if(textField == name){

            let allowCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")

            if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                return true
            }else
            {
                msg = "invalid keyword"
                
                alerts()
                return false
            }
        }
            if(textField == email){

            let allowCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.@-1234567890 ")

            if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                return true
            }else
            {
                msg = "invalid keyword"
                
                alerts()
                return false
            }


        }
            
            if(textField == age){

                let allowCharacters = CharacterSet(charactersIn:"1234567890")

                if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                    return true
                }else
                {
                    msg = "invalid keyword"
                    
                    alerts()
                    return false
                }


            }
       
        
    
     return true
    }
    
//    imageButton action
           @objc func imageButtonActionc(object:Any){
        
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)){
        
             imagePicker.delegate = self
             imagePicker.sourceType = .savedPhotosAlbum
             imagePicker.allowsEditing = true
        
        
            self.present(imagePicker, animated: true, completion: nil)
           
          
          }
           
       }
    
//    picker view method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {

        if  let pickedImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage{

            imageButton.setImage(pickedImage, for: UIControl.State.normal)

            imageData = (pickedImage.pngData() as! NSData)


           

        }

        dismiss(animated: true, completion: nil)

    }
     
    
    
    
    
       
        
        
//   saving data in core data
     

    
    @objc func saveButton(){
        
        
        personalDetails = NSEntityDescription.entity(forEntityName: "Contacts", in: managedObject)
        
        let personMO = NSManagedObject(entity: personalDetails, insertInto: managedObject)
        
        print(personMO)
       personMO.setValue(name.text!, forKey: "name")
        
        
        let ageP = Int(age.text!)
        
        
        
        personMO.setValue(ageP, forKey: "age")
        
        
        
        
        personMO.setValue(email.text!, forKey: "email")
        
        
        
        personMO.setValue(imageData, forKey: "imageData") 
        
        
       
        
        do
        {
            try managedObject.save()
            print("saved")
        }
        catch
        {
            print("Catch Erroe : Failed To ave")
        }
        
        navigationController?.popViewController(animated: true)
        
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
