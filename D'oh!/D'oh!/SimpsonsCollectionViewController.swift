//
//  SimpsonsCollectionViewController.swift
//  D'oh!
//
//  Created by notRoderick on 12/12/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class SimpsonsCollectionViewController: UIViewController {

    let cellIdentifier = "SimpsonsCollectionViewCell"
    
    lazy var manager = JSONManager()
    var simpson = [Simpsons]()
    
   
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadSimpson()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView!.dataSource = self
        self.collectionView.delegate = self
        
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "SimpsonsCollectionViewCell", bundle: nil)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    func downloadSimpson() {
        let completion = { [unowned self] (newSimpson: Simpsons) in
            // print("Did receive image data to show")
            DispatchQueue.main.async { [unowned self] in
                self.simpson.append(newSimpson)
                self.collectionView.reloadData()
                print("did set image data")
            }
            print("Dispatched work to the main thread")
        }
        self.manager.downloadSimpsons(completion: completion)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}
    // MARK: UICollectionViewDataSource
    
    extension SimpsonsCollectionViewController:UICollectionViewDataSource {

//     func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return self.simpson.count
        return simpson.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SimpsonsCollectionViewCell
    
        // Configure the cell

        let data = Data(referencing: self.simpson[indexPath.row].characterImage!)
//        cell.contentView = simpson[indexPath.row].characterImage as UIImage
         cell.imageView.image = UIImage(data: data)
        
        return cell
    }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let simpsonSelected = simpson[indexPath.item]
            print("Yo!")
            performSegue(withIdentifier: "DetailVC", sender: simpsonSelected)
        }
        
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailVC" {
                
                print("preparing for DetailVC segue")
            if let character = sender as? Simpsons {
                
                print("passing over data")
                
                let vc = segue.destination as! SimpsonsDetailViewController
                if let nameData = character.name {
                    vc.nameLabel = nameData
                }
                if let bioData = character.bio {
                    vc.bioLabel = bioData
                }
                if let imageData = character.characterImage {
                    vc.imageLabel = UIImage(data: imageData as Data)
                }
//                vc.nameLabel = simpson[indexPath.item].name
                
                }
            }
            //            if segue.identifier == "DetailVC" {
            //                print("First step accomplished!")
            //                let vc = segue.destination as! SimpsonsDetailViewController
            //                if let selectedItemIndex = self.collectionView.indexPathsForSelectedItems {
            //                    if let nameData = simpson.selectedItemIndex.name {
            //                        vc.nameLabel = nameData
            //                        print("Data has been passed!")
            //                    }
            //                    if let bioData = simpson[selectedItemIndex].bio {
            //                        vc.bioLabel = bioData
            //                        print("Bio has been passed!")
            //                    }
            //                    if let imageData = simpson[selectedItemIndex].characterImage {
            //                        vc.imageLabel = UIImage(data: imageData as Data)
            //                    }
            
        }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
        

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension SimpsonsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.collectionView.frame.size.width
        // let screenHeight = self.collectionView.frame.size.height
        
        return CGSize(width: screenWidth/4.0,
                      height: screenWidth/4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
