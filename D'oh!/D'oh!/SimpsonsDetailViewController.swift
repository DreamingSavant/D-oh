//
//  SimpsonsDetailViewController.swift
//  D'oh!
//
//  Created by notRoderick on 12/13/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

class SimpsonsDetailViewController: UIViewController {
    
    var simpson : Simpsons?
    var imageLabel: UIImage!
    var nameLabel: String!
    var bioLabel: String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var characterNameLbl: UILabel!
    
    @IBOutlet weak var characterBioLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
//        characterNameLbl.text = simpson?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupUI() {
        characterNameLbl.text = nameLabel
        characterBioLbl.text = bioLabel
        imageView.image = imageLabel
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
    }

    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
