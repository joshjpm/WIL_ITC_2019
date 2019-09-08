//
//  HomeViewController.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 27/08/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DeviceTabController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
//    var id_list = [String]()
//    var name_list = [String]()
//    var user_list = [String]()
    
//    var refresh = 1
//    //sample data
//    var id_list = ["1","2","3","1","2","3","1","2","3"]
//    var name_list = ["dog","cat","cow","1","2","3","1","2","3"]
//    var user_list = ["richard", "john", "Ian","1","2","3","1","2","3"]
    
    @IBOutlet weak var myview: UICollectionView!
    var db : Firestore!
    var devicelist = [Device]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        db = Firestore.firestore()
        loadData()
        
        
        // Do any additional setup after loading the view.
    }
    func loadData(){
        db.collection("Devices").getDocuments(){
            querySnapshot, error in
            if let error = error{
                print("\(error.localizedDescription)")
            }else{
                self.devicelist = querySnapshot!.documents.compactMap({Device(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.myview.reloadData()
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Devices"
        loadData()

    }
    
    @IBAction func refreshButtonTouch(_ sender: Any) {
//        db.collection("Devices").whereField("timeStamp", isGreaterThan: Date())
//            .addSnapshotListener{
//                querysnapshot, error in
//                guard let snapshot = querysnapshot else {return}
//                snapshot.documentChanges.forEach{
//                    diff in
//
//                    if diff.type == .added {
//                        self.devicelist.append(Device(dictionary: diff.document.data())!)
//                        DispatchQueue.main.async {
//                            self.myview.reloadData()
//                        }
//                    }
//                }
//        }
        loadData()
    }
    
    @IBAction func addDevice(_ sender: Any) {
        print ("yes")
        let addWindow = UIAlertController(title: "Add new device", message: "Enter device id and name",preferredStyle: .alert)
        
        addWindow.addTextField{(textField:UITextField)in
            textField.placeholder = "Device ID"
        }
        addWindow.addTextField{(textField:UITextField)in
            textField.placeholder = "Device name"
        }
        self.present(addWindow, animated: true)
        
        addWindow.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        addWindow.addAction(UIAlertAction(title:"Add", style: .default, handler:
            { (action:UIAlertAction)in
                if let id = addWindow.textFields?.first?.text, let name = addWindow.textFields?.last?.text{
                    
                    let newDevice = Device(id : id, name: name,timeStamp: Timestamp(),used: false)
                    var ref:DocumentReference? = nil
                    ref = self.db.collection("Devices").addDocument(data: newDevice.dictionary){
                        error in
                        
                        if let error = error {
                            print("Error occurs: \(error.localizedDescription)")
                        }else{
                            print("Document added sucessfully with ID: \(ref!.documentID)")
                        }
                    }
                }
        }))
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.navigationItem.setHidesBackButton(true, animated:true);
        return devicelist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! CollectionViewCell
        let device = devicelist[indexPath.row]
        cell.id.text = device.id
        cell.name.text = device.name
        cell.user.text = "Device is created at \(device.timeStamp)"
        
        print(device.timeStamp)
        
        
        // MARK: - Cell Styling
        
        //if want image "cell.xx.image = xx[indexPath.row]
//        cell.contentView.layer.cornerRadius = 10
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = cell.contentView.layer.cornerRadius
        
        
        return cell
    }
    
    @IBAction func logOutButtonTouch(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
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
