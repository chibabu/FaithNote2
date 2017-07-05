//// 랜덤 스트링 함수 시작
//func randomString(length: Int) -> String { //
//    
//    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//    let len = UInt32(letters.length)
//    
//    var randomString = ""
//    
//    for _ in 0 ..< length {
//        let rand = arc4random_uniform(len)
//        var nextChar = letters.character(at: Int(rand))
//        randomString += NSString(characters: &nextChar, length: 1) as String
//    }
//    
//    return randomString
//}
//// 랜덤 스트링 함수 끝






//// 카메라 Function Start
//
//@IBAction func toolBarTakePic(_ sender: UIBarButtonItem) {
//    let imagePicker = UIImagePickerController()
//    imagePicker.delegate = self
//    imagePicker.sourceType = .camera
//    present(imagePicker, animated: true, completion: nil)
//}
//// 카메라 Function End






//// asset 방법 시작
//        let imageUrl          = editinginfo[UIImagePickerControllerReferenceURL] as! URL
//        let imageName         = imageUrl.lastPathComponent
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
//            var assets = PHAsset.fetchAssets(withALAssetURLs: [imageUrl!], options: nil)

//            if let fileAsset = assets.firstObject {

//                imagesList.append(p)
//                print(imagesList)
//                let fileName = (fileAsset.creationDate?.description)!
//// asset 방법 끝







//// 이미지 풀 사이즈 시작
//func getAssetFullsize(asset: PHAsset) -> UIImage {
//    let manager = PHImageManager.default()
//    let option = PHImageRequestOptions()
//    var img = UIImage()
//    option.isSynchronous = true
//    let w = asset.pixelWidth
//    let h = asset.pixelHeight
//    manager.requestImage(for: asset, targetSize: CGSize(width: w, height: h), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//        img = result!
//    })
//    return img
//}
//// 이미지 풀 사이즈 끝






//// 이미지 썸네일 사이즈 시작
//func getAssetThumbnail(asset: PHAsset) -> UIImage {
//    let manager = PHImageManager.default()
//    let option = PHImageRequestOptions()
//    var thumbnail = UIImage()
//    option.isSynchronous = true
//    let w = 100
//    let h = 100
//    manager.requestImage(for: asset, targetSize: CGSize(width: w, height: h), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//        thumbnail = result!
//    })
//    return thumbnail
//}
//// 이미지 썸네일 사이즈 끝




//// 텍스트 뷰 크기 시작
//    public func textViewDidEndEditing(_ textView: UITextView)
//    {
//        if imageInWriteView.image != nil {
//            var frame = self.writeTextView.frame
//            frame.size.height = 390
//            self.writeTextView.frame = frame
//        } else {
//        var frame = self.writeTextView.frame
//        frame.size.height = 510
//        self.writeTextView.frame = frame
//        }
//    }
//// 텍스트 뷰 크기 끝




//// 로컬 파일 삭제 Function start
//
//func localFileDelete (directory : [String]) {
//    let fileManager = FileManager.default
//    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
//    let documentsPath = documentsUrl.path
//    
//    do {
//        //                if let documentPath = documentsPath
//        //                {
//        //                    let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentsPath!)/\(directoryNameList[memoNumber])_Faith")
//        //                    print("all files in cache: \(fileNames)")
//        //                    for fileName in fileNames {
//        
//        
//        //                        if (fileName.hasSuffix(".jpg"))
//        //                        {
//        let filePathName = "\(documentsPath!)/\(directory[memoNumber])_Faith"
//        try fileManager.removeItem(atPath: filePathName)
//        //                            print("filePathName :", filePathName)
//        //                        }
//        //                    }
//        
//        //                    let files = try fileManager.contentsOfDirectory(atPath: "\(directoryNameList[memoNumber])_Faith")
//        _ = try fileManager.contentsOfDirectory(atPath: "\(directory[memoNumber])_Faith")
//        
//        //                    print("all files in cache after deleting images: \(files)")
//        //                    print("documentPath :", documentPath)
//        
//    }
//        
//        //            }
//    catch {
//        print("Could not clear temp folder: \(error)")
//    }
//    
//    
//}
//// 로컬 파일 삭제 Function End




//// 콜렉션 프레임
//
//func setCollectionFrame (_ frameHeight: Int, _ frameWidth: Int,  _ frameOriginY: Int ) {
//    
//    var writeCollectionFrame = writeCollection.frame
//    writeCollection.layer.backgroundColor = UIColor.black.cgColor
//    writeCollectionFrame.size.height = CGFloat(frameHeight)
//    writeCollectionFrame.origin.y = CGFloat(frameOriginY)
//    writeCollectionFrame.size.width = CGFloat(frameWidth)
//    writeCollection.frame = writeCollectionFrame
//}
//// 콜렉션 프레임 끝
//
//
//// 이미지 뷰 프레임
//func setImageViewFrame(_ imageCell : writeCell,_ frameHeight: Int, _ frameWidth: Int) {
//    var writeCollectionaImageFile = imageCell.writeImageView
//    writeCollectionaImageFile?.layer.backgroundColor = UIColor.red.cgColor
//    writeCollectionaImageFile?.layer.borderWidth = 1
//    writeCollectionaImageFile?.layer.borderColor = UIColor.blue.cgColor
//    writeCollectionaImageFile?.frame.size.height = CGFloat(frameHeight)
//    writeCollectionaImageFile?.frame.size.width = CGFloat(frameWidth)
//    imageCell.writeImageView = writeCollectionaImageFile
//}
//
//// 이미지 뷰 프레임 끝
//
//
//// 콜렉션 셀 프레임
//func setCollectionCellFrame(_ indexPath : IndexPath,_ frameHeight: Int,_ frameWidth: Int,_ frameOriginY: Int ) {
//    
//    var writeCollectionCellFrame = writeCollection.cellForItem(at: indexPath)?.frame
//    writeCollection.cellForItem(at: indexPath)?.layer.backgroundColor = UIColor.white.cgColor
//    writeCollectionCellFrame?.size.height = CGFloat(frameHeight)
//    writeCollectionCellFrame?.size.width = CGFloat(frameWidth)
//    writeCollectionCellFrame?.origin.y = CGFloat(frameOriginY)
//    writeCollection.cellForItem(at: indexPath)?.frame = writeCollectionCellFrame!
//}
//// 콜렉션 셀 프레임




//// 이미지 쇼 시작
//
//func showImage (_ image: UIImage) {
//    
//    if collectionframe == 0 { // 0일때 프레임 축소
//        showImageInWriteView.alpha = 0
//        
//    } else if collectionframe == 1 {// 1일때 프레임 확장
//        
//        UIView.animate(withDuration: 1.0, animations: ({
//            self.showImageInWriteView.alpha = 1
//            self.showImageInWriteView.layer.borderColor = UIColor.gray.cgColor
//            self.showImageInWriteView.image = image
//            }
//            
//            )
//        )
//        
//    } else {}
//    
//    
//}
//
//// 이미지 쇼 끝




