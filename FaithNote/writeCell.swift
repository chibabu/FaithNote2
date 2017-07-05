//
//  writeCell.swift
//  FaithNote
//
//  Created by 차종훈 on 2017. 6. 20..
//  Copyright © 2017년 Carus. All rights reserved.
//

import UIKit

class writeCell: UICollectionViewCell {
    
    @IBOutlet weak var writeImageView: UIImageView!
    
    
    
    
    

        var buttonTappedAction : ((UICollectionViewCell) -> Void)?
        
    @IBAction func imageDeleteButton(_ sender: UIButton) {
                    
            buttonTappedAction?(self)
        }
    
    
    
    var saveButtonTappedAction : ((UICollectionViewCell) -> Void)?

    
    @IBAction func imageSaveButton(_ sender: UIButton) {
        saveButtonTappedAction?(self)

    }
    
    
    
    var showButtonTappedAction : ((UICollectionViewCell) -> Void)?

    
    @IBAction func imageShowButton(_ sender: UIButton) {
        showButtonTappedAction?(self)

    }

}
