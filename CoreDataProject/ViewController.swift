//
//  ViewController.swift
//  CoreDataProject
//
//  Created by R Shantha Kumar on 12/19/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
        static var buttonTapped:String!
    
       var managedObject:NSManagedObjectContext!
       var appDelegate:AppDelegate!
       var perosonDetailsEntity:NSEntityDescription!
    
    var buttonTApped:Int!
    var buttonTAppedForDElete:Int!

    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
//    var text = [Any]()
    @IBOutlet weak var stackView3: UIStackView!
    
    var imageVie:UIImageView!
    
    
    var detailButton = [UIButton]()
    var delete = [UIButton]()
    var imageVie3 = [UIImageView]()
    
    
    var name1 = [String]()
    var age = [Int64]()
    var email = [String]()
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataCreate()
       
//      fethData()
        
    }

    
//    aall data deleting
    
    @IBAction func deleteDAta(_ sender: Any) {
        
        let fetchingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
                      if let result = try? managedObject.fetch(fetchingRequest) {
                          for object in result {
                           
                           
                              managedObject.delete(object as! NSManagedObject)
                            print("deleted")
                          }
                      }
        do{
            
            try! managedObject.save()
            
        }catch{
            print("erroer")
        }
        
        
    }
    

    
//    creating entity,context
    
    func coreDataCreate(){
       
       appDelegate = (UIApplication.shared.delegate as! AppDelegate)
              
       managedObject = appDelegate.persistentContainer.viewContext
       
       perosonDetailsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedObject)
       
    
    }
    
//    add button
    
    @IBAction func addButton(_ sender: Any) {
        
              for i in detailButton{
                   
                   i.removeFromSuperview()
               }
               for i in delete{
                   
                   i.removeFromSuperview()
               }
               
        for i in imageVie3{

            i.removeFromSuperview()
        }
        
        detailButton = [UIButton]()
        delete = [UIButton]()
        imageVie3 = [UIImageView]()
       
        
               name1 = [String]()
               age = [Int64]()
               email = [String]()
               images = [UIImage]()
               
        
        let target = storyboard?.instantiateViewController(identifier: "second") as! SecondViewController
               
               navigationController?.pushViewController(target, animated: true)
               
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        name1 = [String]()
        age = [Int64]()
        email = [String]()
        images = [UIImage]()
        
        
        
        stackView1.spacing = 30
        stackView2.spacing = 30
        stackView3.spacing = 30
        
//      +
        
//
//        ViewController.buttonTapped = "A"
        
        let fetchingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        let fetchRe = NSFetchRequest<NSFetchRequestResult>(entityName: "jghfgh")
//        var _:String!
     
        
//        fetching DAta
        do{
            
            let fetchManagedObject = try managedObject.fetch(fetchingRequest)
            
            var text:String!
            
            for i in 0..<fetchManagedObject.count          {
                
                
                print(fetchManagedObject)
                
                
                
                
                
                let currentMO = fetchManagedObject[i] as! NSManagedObject
                
                let imagef = UIImageView()
                
                let defaultImage = UIImage(named: "defaultProfile")
                
                
               
                let imageData = (defaultImage!.pngData() as! NSData)
                

                let imaged = currentMO.value(forKey: "imageData") as? NSData ??  imageData
                
                let uiimage = UIImage(data:(imaged as? Data)!)


                if let c = uiimage
                {
                     images.append(c)
                }
                
                

                
                
                
                let name = currentMO.value(forKey: "name") as? String ?? "empty"
                print(name)
                name1.append(name)
                text = name
                
                let aged = currentMO.value(forKey: "age") as? Int64 ?? 0
                //print(aged)
                age.append(aged)
                
                text += "\n" + "\(aged)"
                
                
                let emails = currentMO.value(forKey: "email") as? String ?? "empty"
                //print(emails)
                 text += "\n" + emails
                email.append(emails)
                
              
                
                
                
                
              imageVie  = UIImageView()
             imageVie.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
             imageVie.image = images[i]
             imageVie.layer.cornerRadius = imageVie.frame.size.width/2
             imageVie.clipsToBounds = true
             imageVie.transform = CGAffineTransform(rotationAngle: imageVie.frame.size.width/13)
             imageVie.heightAnchor.constraint(equalToConstant: 80).isActive = true
             imageVie3.append(imageVie)
             stackView1.addArrangedSubview(imageVie)
               


               

            
                let  button = UIButton()
//                button.backgroundColor = .systemBlue
                button.titleLabel!.numberOfLines = 0
                button.tag = i
                detailButton.append(button)
                button.heightAnchor.constraint(equalToConstant: 80).isActive = true
                button.setTitle(text, for: UIControl.State.normal)
                stackView2.addArrangedSubview(button)
                
              let deleteButton = UIButton()
                deleteButton.tag = i
                deleteButton.setBackgroundImage(UIImage(named: "delete"), for: UIControl.State.normal
                )
                delete.append(deleteButton)
                deleteButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
                deleteButton.addTarget(self, action: #selector(deleteButtonTarget(obj:)), for: UIControl.Event.touchUpInside)
                stackView3.addArrangedSubview(deleteButton)
                
                
               
            }
    }
        catch{
            
            print("unable to data")
            
        }
        
//        for i in 0...<fe>
        
        
        
        
        
        
    }
    
//    deleting individual row data
    
    @objc func deleteButtonTarget(obj:UIButton){
        
        buttonTApped = obj.tag
        
        
        print("#########################",name1[buttonTApped])
        
        let fetchingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        fetchingRequest.predicate = NSPredicate.init(format: "age==\(age[buttonTApped])")
        
                let result = try? managedObject.fetch(fetchingRequest)
        for object in result! {
                   
                       managedObject.delete(object as! NSManagedObject)
                         
                
        
                
        do{
            
           try managedObject.save()
            
        }catch
        {
            print("error")
        }
        
        
        }
        
    }
    
//    func deleteProfile(withID: Int) {
//        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
//        fetchRequest.predicate = Predicate.init(format: "profileID==\(withID)")
//        let object = try! context.fetch(fetchRequest)
//        context.delete(object)
//    }

}

