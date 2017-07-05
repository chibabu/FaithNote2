//
//  writeImageViewController.swift
//  FaithNote
//
//  Created by 차종훈 on 2017. 7. 1..
//  Copyright © 2017년 Carus. All rights reserved.
//

import UIKit

class writeImageView: UIViewController {


    @IBOutlet weak var writeImageView: UIImageView!
    
    internal var memoNumber = 0
    

//     Segue Start
    override func prepare(for segue:  UIStoryboardSegue, sender: Any?) {
        
        
        if let segueIdentifier = segue.identifier {
            
            if segueIdentifier == "toWriteFromImage" {
                
                    let writeView = segue.destination as! writeView
                    writeView.memoNumber = memoNumber
                
            } else {}
        }
    }
    
//     Segue End


    
    override func viewDidLoad() { // 뷰윌어페어보다 먼저
        super.viewDidLoad()
        
        print("memoNumber :", memoNumber)
        
        writeImageView.image = selectedImageData
        
        
        
    }
    
}
