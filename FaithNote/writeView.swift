//
//  writeView.swift
//  FaithNote
//
//  Created by 차종훈 on 2017. 5. 7..
//  Copyright © 2017년 Carus. All rights reserved.
//

import UIKit
import ELCImagePickerController
//import Photos
//import RealmSwift




class writeView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, ELCImagePickerControllerDelegate  {
    
    
    
    
    
    //MARK : - Variable start
    
    
    @IBOutlet var toolBarView: UIToolbar!
    
    @IBOutlet weak var writeTextView: UITextView!
    
    @IBOutlet weak var writeCollection: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    let elcImagePicker = ELCImagePickerController(imagePicker: ())
    
    @IBOutlet weak var writeMainLabel: UILabel!
    
    internal var memoNumber = -1
    
    var collectionframe = 0

    @IBOutlet weak var showImageInWriteView: UIImageView!
    
    var checkIndex = -1

    // Variable end
    
    
    
    
    //MARK : - Function Start
    
    
    
    
    
    // 로컬 파일 삭제 시작
    
    func localFileDelete (directory : String, fileName : [String]) {
        let fileManager = FileManager.default
        do {
//            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            let documentsPath = documentsUrl.path
            
            
            //                print("directory[memoNumber] :", directory)
            for i in 0..<fileName.count {
            let filePathName = "\(documentsPath)/\(directory)_Faith/\(fileName[i])_Faith.jpg"
            try fileManager.removeItem(atPath: filePathName)
            }
            //                _ = try fileManager.contentsOfDirectory(atPath: "\(directory[memoNumber])_Faith")
            
        }
            
            //            }
        catch {
            print("Could not clear temp folder: \(error)")
        }
        
        
    }
    
    // 로컬 파일 삭제 끝
    
    
    
    
    
    
    
    
    
    
    
    
    // 이미지 추가 Function Start
    
    @IBAction func toolBarImage(_ sender: UIBarButtonItem) {
        
        func availableAddImageNumber () -> Int {
            let countImage = 5 - directoryNameListTemp.count
            
            return countImage
        }
        
        elcImagePicker?.maximumImagesCount = availableAddImageNumber()
        elcImagePicker?.returnsOriginalImage = false
        elcImagePicker?.returnsImage = true
        elcImagePicker?.onOrder = true
        elcImagePicker?.imagePickerDelegate = self
        present((elcImagePicker)!, animated: true, completion: nil)
        
        
        //            imagePicker.delegate = self
        //            imagePicker.allowsEditing = false
        //            imagePicker.sourceType = .photoLibrary
        //            present(imagePicker, animated: true, completion: nil)
        
    }
    // 이미지 추가 Function End
    
    
    
    
    // 키보드 무빙 Function Start
    
    @IBAction func downKeyBoard(_ sender: UIBarButtonItem) {
        self.writeTextView.resignFirstResponder()
        
    }
    // 키보드 무빙 End
    
    
    
    
    
    // 랜덤 해쉬값 Start
    
    func generateHashString() -> String {
        let currentHash = Date().hashValue.description
        
        return currentHash
    }
    // 랜덤 해쉬값 End
    
    
    
    
    // 로컬 디렉토리 삭제 Function start
    
    func localDirectoryDelete (directory : [String]) {
        let fileManager = FileManager.default
        do {
//            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            
            let documentsPath = documentsUrl.path
            
            
            let filePathName = "\(documentsPath)/\(directory[memoNumber])_Faith"
            //                    let filePathName = "\(documentUrl)/\(directory[memoNumber])_Faith"
            print("NSTemporaryDirectory() :", NSTemporaryDirectory())
            
            try fileManager.removeItem(atPath: filePathName)
        }
        catch {
            print("Could not clear temp folder: \(error)")
        }
        
    }
    
    
    
    // 로컬 디렉토리 삭제 Function End
    

    
    
    
    
    
    
    // 이미지 로컬에 저장 시작
    func imageWriteToLocal (_ imageFDA: [UIImage], _ directoryNLT: String, _ imageFNA: [String]) {


        for i in 0..<imageFNA.count {
 
            let dataPath = documentsUrl.appendingPathComponent("\(directoryNLT)_Faith")
            
            
            let fileURL = dataPath.appendingPathComponent("\(imageFNA[i])_Faith.jpg")
            let pngImageData = UIImagePNGRepresentation(imageFDA[i])
            try! FileManager.default.createDirectory(atPath: (dataPath.path), withIntermediateDirectories: true, attributes: nil)
            try! pngImageData?.write(to: fileURL, options: .atomic)
            
        }
        
    }
    // 이미지 로컬에 저장 끝
    
    
    // 이미지 임시저장 시작
    func imageSaveToTemp (_ imageUrl: URL, _ imageFile: UIImage) {
        
        imageFileName = generateHashString()
        
        print("이미지 피커 이전 imageArrayTemp :", imageArrayTemp)
        
        directoryNameListTemp.insert(imageFileName, at: 0) // 이미지 랜덤해쉬 이름 배열
        imageUrlArrayTemp.insert(imageUrl, at: 0) // 실제 이미지 URL 데이터 배열
        imageArrayTemp.insert(imageFile, at: 0) // 실제 이미지 파일 데이터 배열
        
        print("이미지 피커 이후 imageArrayTemp :", imageArrayTemp)
        
        //            }
    }
    // 이미지 임시저장 끝
    
    
    
    
    
    
    
    // 이미지 피커 시작
    
    func elcImagePickerControllerDidCancel(_ picker: ELCImagePickerController!) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func elcImagePickerController(_ picker: ELCImagePickerController!, didFinishPickingMediaWithInfo info: [Any]) {
        
        dismiss(animated: true, completion: nil)
        
        
        if directoryNameListTemp != [] { // 이미지 값이 저장되어 있다면, 로컬에 저장된 이미지를 불러와서 배열에 어펜드
            // ** 다 지웠다가 다시 이미지를 넣으면 오류남.. 고치길..
            for i in 0..<directoryNameListTemp.count {
                let filePath = documentsUrl.appendingPathComponent("\(directoryNameList[memoNumber])_Faith/\(directoryNameListTemp[i])_Faith.jpg").path
//                print("UIImage(contentsOfFile: filePath)! :", UIImage(contentsOfFile: filePath))

                if UIImage(contentsOfFile: filePath) != nil {
                imageArrayTemp.append(UIImage(contentsOfFile: filePath)!)
                } else {}
//                print("picker imageArrayTemp :",imageArrayTemp)
            }
            
        } else {}
        
        
        for i in 0..<info.count {
            let imageFileDicTemp = info[i] as! [String:Any]
            let imageFile = imageFileDicTemp[UIImagePickerControllerOriginalImage] as! UIImage
            let imageUrl = imageFileDicTemp[UIImagePickerControllerReferenceURL] as! URL
            
            imageSaveToTemp(imageUrl, imageFile)

        }
        
        
    }
    
    // 이미지 피커 끝
    
    
    
    
    // 텍스트 뷰 크기 설정 시작
    
    func textViewDidBeginEditing(_ textView: UITextView) // 텍스트뷰 눌렀을 때
    {
        var frame = self.writeTextView.frame
        frame.size.height = 260
        self.writeTextView.frame = frame
        
        showImageInWriteView.alpha = 0
        
//        writeCollection.reloadData()
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) { // 텍스트뷰 나갔을 때
        if directoryNameListTemp != [] { // 이미지가 있으면
            var frame = self.writeTextView.frame
            frame.size.height = 380
            self.writeTextView.frame = frame
        } else {
            var frame = self.writeTextView.frame
            frame.size.height = 520
            self.writeTextView.frame = frame
        }
    }
    
    // 텍스트 뷰 크기 설정 끝
    
    
    
    
    
    // 콜렉션 뷰 크기 설정 시작
    
    func imageCollectionHide (_ bool: Bool) {
        writeCollection.isHidden = bool
    }
    
    // 콜렉션 뷰 크기 설정 끝
    
    // 기본 경고창 시작
    func basicAlert (_ messages : String){ // 글을 입력 안했으면 경고창
        let alertView = UIAlertController(title: "Error", message: messages, preferredStyle: UIAlertControllerStyle.alert)
        // alertview에 확인버튼 삽입
        alertView.addAction(UIAlertAction(title: "return", style: UIAlertActionStyle.default, handler: nil))
        
        // 현재 viewcontroller에 추가하기
        self.present(alertView, animated: true, completion: nil)
    }
    // 기본 경고창 끝

    
    
    
    
    
    

    
    
    
    // 이미지 콜렉션 시작
    
    
    // 몇개 보여줄거야
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

            return directoryNameListTemp.count

    }


    
    // 뭐 보여줄거야
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! writeCell
        
        
//        self.writeCollection.alpha = 0
//        
//        UICollectionView.animate(withDuration: 0.8) {
//            self.writeCollection.alpha = 1
//        }
        
//        
        imageCell.writeImageView.alpha = 0
        UIImageView.animate(withDuration: 0.8) {
            imageCell.writeImageView.alpha = 1
        }
        
        // image Delete Button start
        imageCell.buttonTappedAction = { (imageCell) in
            

            let alertController = UIAlertController(title: "DELETE this Image?", message: "Image - \(indexPath.row+1)", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Delete", style: .default) { (_) in
                
                if imageArrayTemp != [] { // 이미지가 추가된다면(새글이든 수정이든 상관없음)
                    
                    deleteImageList.append(directoryNameListTemp[indexPath.row])
                    imageArrayTemp.remove(at: indexPath.row)
                    directoryNameListTemp.remove(at: indexPath.row)
                    
                    
                    print("imageArrayTemp :", imageArrayTemp)
                    print("directoryNameListTemp :", directoryNameListTemp)
                    
                } else { // 이미지 추가가 없다면
                    deleteImageList.append(directoryNameListTemp[indexPath.row])
                    directoryNameListTemp.remove(at: indexPath.row)
                }
                
                collectionView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        // image Delete Button end
        

        

        if memoNumber == -1 { // 새 글일 경우
            print("새 글일 경우")
            if imageArrayTemp != [] { // 이미지를 추가 해줬을 경우 -> 이미지를 보여줌
                print("이미지를 추가 해줬을 경우 -> 이미지를 보여줌")
                imageCell.writeImageView.image = imageArrayTemp[indexPath.row]
                
                
                // save image
                imageCell.saveButtonTappedAction = { (imageCell) in
                    
                    let alertController = UIAlertController(title: "SAVE this Image in Album?", message: "Image - \(indexPath.row+1)", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
                        
                        UIImageWriteToSavedPhotosAlbum(imageArrayTemp[indexPath.row], nil, nil, nil)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                    
                    alertController.addAction(confirmAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                // save image end
                
                // show image
                imageCell.showButtonTappedAction = { (imageCell) in
                    print("처음 :", self.checkIndex)
                    
                    if self.checkIndex == indexPath.row { // 이미지 죽이기
                        self.showImageInWriteView.alpha = 0
                        
                        self.checkIndex = -1
                        print("중간 :", self.checkIndex)
                        
                    } else if self.checkIndex != indexPath.row { // 이미지 살리기
                        UIView.animate(withDuration: 0.5, animations: ({
                            self.showImageInWriteView.alpha = 1
                            self.showImageInWriteView.layer.borderColor = UIColor.gray.cgColor
                            self.showImageInWriteView.image = imageArrayTemp[indexPath.row]
                            self.checkIndex = indexPath.row
                            
                        }))} else {}
                    
//                    print("마지막 :",self.checkIndex)
                    
                }
                // show image end
                
                

            } else if imageArrayTemp == [] { // 이미지 추가가 없으면 아무것도 안 띄어줌 실행이 안됨.
                print("이미지 추가가 없으면 아무것도 안 띄어줌")
                
            } else {}
            
            
            
        } else if memoNumber != -1 { // 글 수정일 경우
            print("글 수정일 경우")
            
            if imageArrayTemp != [] { // 이미지 추가가 있는 경우
                print("이미지 추가가 있는 경우")
            imageCell.writeImageView.image = imageArrayTemp[indexPath.row]
                
                
                // save image
                imageCell.saveButtonTappedAction = { (imageCell) in
                    
                    let alertController = UIAlertController(title: "SAVE this Image in Album?", message: "Image - \(indexPath.row+1)", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
                        
                        UIImageWriteToSavedPhotosAlbum(imageArrayTemp[indexPath.row], nil, nil, nil)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                    
                    alertController.addAction(confirmAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                // save image end
                
                // show image
                imageCell.showButtonTappedAction = { (imageCell) in
//                    print("처음 :", self.checkIndex)
                    
                    if self.checkIndex == indexPath.row { // 이미지 죽이기
                        self.showImageInWriteView.alpha = 0
                        
                        self.checkIndex = -1
//                        print("중간 :", self.checkIndex)
                        
                    } else if self.checkIndex != indexPath.row { // 이미지 살리기
                        UIView.animate(withDuration: 0.5, animations: ({
                            self.showImageInWriteView.alpha = 1
                            self.showImageInWriteView.layer.borderColor = UIColor.gray.cgColor
                            self.showImageInWriteView.image = imageArrayTemp[indexPath.row]
                            self.checkIndex = indexPath.row
                            
                        }))} else {}
                    
//                    print("마지막 :",self.checkIndex)
                    
                }
                // show image end
                
                
                
                

                
            } else { // 이미지 추가가 없는 경우
                print("이미지 추가가 없는 경우")
                
                let filePath = documentsUrl.appendingPathComponent("\(directoryNameList[memoNumber])_Faith/\(directoryNameListTemp[indexPath.row])_Faith.jpg").path
                
                let TitleImage = UIImage(contentsOfFile: filePath)
                
                imageCell.writeImageView.image = TitleImage
                
                
                
                // save image
                imageCell.saveButtonTappedAction = { (imageCell) in
                    
                    let alertController = UIAlertController(title: "SAVE this Image in Album?", message: "Image - \(indexPath.row+1)", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
                        
                        UIImageWriteToSavedPhotosAlbum(TitleImage!, nil, nil, nil)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                    
                    alertController.addAction(confirmAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                // save image end
                
                

                // show image
                imageCell.showButtonTappedAction = { (imageCell) in
//                    print("처음 :", self.checkIndex)

                    if self.checkIndex == indexPath.row { // 이미지 죽이기
                        self.showImageInWriteView.alpha = 0

                        self.checkIndex = -1
//                        print("중간 :", self.checkIndex)
                        
                    } else if self.checkIndex != indexPath.row { // 이미지 살리기
                        UIView.animate(withDuration: 0.5, animations: ({
                            self.showImageInWriteView.alpha = 1
                            self.showImageInWriteView.layer.borderColor = UIColor.gray.cgColor
                            self.showImageInWriteView.image = TitleImage!
                            self.checkIndex = indexPath.row

                        }))} else {}
                    
//                    print("마지막 :",self.checkIndex)

                }
                // show image end

                
            }
        } else {}


        return imageCell

        }

    // 클릭하면 어떻게 돼
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
    // 이미지 콜렉선 끝
    

    
    
    // Segue Start
    override func prepare(for segue:  UIStoryboardSegue, sender: Any?) {
        
        
        if let segueIdentifier = segue.identifier {
            
            if segueIdentifier == "toImageView" {
                
                let writeImageView = segue.destination as! writeImageView
                writeImageView.memoNumber = memoNumber
                
            } else {}
        }
    }
    
    // Segue End
   
    
    
    
    
    
    // Function End
    
    
    
    
    
    
    
    // 입력 저장 버튼 Start
    
    @IBAction func writeSave(_ sender: UIButton) {
        self.writeTextView.resignFirstResponder()

        
//        if writeTextView.text == "" {
            if writeTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                basicAlert("No Contents")
//            }
        
        
        } else {
            
            if memoNumber == -1 { //새글 추가하는 경우
                
                print("새글 추가하는 경우")
                
                // 글 부분
                mMemoDataValue.insert(writeTextView.text, at: 0)
                UserDefaults.standard.set(mMemoDataValue, forKey: "\(arraySelect)_Faith")
                // 글 부분 끝
                
                
                // 이미지 부분 시작
                if directoryNameListTemp != [] { // 이미지를 넣었을 때
                    print("이미지를 넣었을 때")
                    directoryNameList.insert(directoryNameListTemp[0] , at: 0) // 이미지 디렉토리 이름 저장
                    UserDefaults.standard.set(directoryNameList, forKey: "\(arraySelect)_directoryNameList")
                    
                    mMemoImageDic.insert(directoryNameListTemp, at: 0) // 이미지 파일 이름 저장
                    UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
                    
                    // 파일 로컬디렉토리에 쓰기
                    imageWriteToLocal(imageArrayTemp, directoryNameListTemp[0], directoryNameListTemp)
                    
                    
                    
                } else { // 이미지를 넣지 않았을 때
                    print("이미지를 넣지 않았을 때")
                    directoryNameList.insert("", at: 0)  // 이미지 디렉토리 이름 널값 저장(인덱스 맞춰주기 위해)
                    UserDefaults.standard.set(directoryNameList, forKey: "\(arraySelect)_directoryNameList")
                    
                    mMemoImageDic.insert(directoryNameListTemp, at: 0) // 이미지 파일 이름 널값 저장(인덱스 맞춰주기 위해)
                    UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
                    
                }
            
            
                
                // 이미지 부분 끝
                
            } else { // 글 수정 하는 경우
                // 텍스트 부분
                mMemoDataValue.remove(at: memoNumber)
                mMemoDataValue.insert(writeTextView.text, at: memoNumber)
                UserDefaults.standard.set(mMemoDataValue, forKey: "\(arraySelect)_Faith")
                // 텍스트 부분 끝
                
                // 이미지 부분
                if (directoryNameList[memoNumber] == "" && directoryNameListTemp != []){ // 이미지 값이 없는 메모를 수정할 때 and 이미지 추가가 있는 경우
                        print("이미지 값이 없는 메모를 수정할 때 이미지 추가가 있는 경우")
                        print("directoryNameList :", directoryNameList[0])
                        directoryNameList[memoNumber] = directoryNameListTemp[0] // ""값 대신 새로 입력된 디렉토리 이름 넣어주기
                        UserDefaults.standard.set(directoryNameList, forKey: "\(arraySelect)_directoryNameList")
                        mMemoImageDic[memoNumber] = directoryNameListTemp // ""값 대신 새로 입력된 파일배열 넣어주기
                        UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
                        
                        imageWriteToLocal(imageArrayTemp, directoryNameListTemp[0], directoryNameListTemp)

                    
                    
                } else if imageArrayTemp != []  { // 이미지 값이 있는 메모를 수정할 때 and 이미지 추가가 있을 때
                    print("이미지 값이 있는 메모를 수정할 때 and 이미지 추가가 있을 때")

                        
                        mMemoImageDic[memoNumber] = directoryNameListTemp // 새로 입력된 파일 추가
                        UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
                    
                    imageWriteToLocal(imageArrayTemp, directoryNameList[memoNumber], directoryNameListTemp)
                    
                        // 삭제가 안됨... 삭제와 쓰기가 동시에 안되는 모양..
                    
                    let delayInSeconds = 2.0
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                        
                        self.localFileDelete(directory: directoryNameList[self.memoNumber], fileName: deleteImageList)

                        
                    }
                } else { // 이미지 추가가 없을때
                    mMemoImageDic[memoNumber] = directoryNameListTemp // 새로 입력된 파일 추가
                    UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
                    localFileDelete(directory: directoryNameList[memoNumber], fileName: deleteImageList)

                    }
                
                    // 이미지 부분 끝

                
            } // 텍스트가 nil 이 아닐때 (else) 닫아주기
            
            directoryNameListTemp.removeAll()
            imageUrlArrayTemp.removeAll()
            imageArrayTemp.removeAll()
            
            self.performSegue(withIdentifier: "goToViewUI", sender: self)
        }
    }
    // 입력 저장 버튼 End
    
    
    
    
    
    // 메모 삭제 시작
    
    @IBAction func toolBarDelete(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "DELETE this Memo?", message: "ALL Attached Files will be removed in this Memo", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Delete", style: .default) { (_) in

            
            
        self.writeTextView.resignFirstResponder()
        
        if self.memoNumber != -1 { // 기존 작성된 글일 경우
            
            
            // 텍스트 부분
            mMemoDataValue.remove(at: self.memoNumber)
            UserDefaults.standard.set(mMemoDataValue, forKey: "\(arraySelect)_Faith")
            // 텍스트 부분 끝
            
            
            self.localDirectoryDelete (directory: directoryNameList)
            
            // 이미지 변수 부분
            directoryNameList.remove(at: self.memoNumber)
            UserDefaults.standard.set(directoryNameList, forKey: "\(arraySelect)_directoryNameList")
            
            mMemoImageDic.remove(at: self.memoNumber)
            UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
            // 이미지 변수 부분 끝
            
            directoryNameListTemp.removeAll()
            imageArrayTemp.removeAll()
            imageUrlArrayTemp.removeAll()
            
            self.performSegue(withIdentifier: "goToViewUI", sender: self)
            
        } else { // 새 글일 경우
            
            
            directoryNameListTemp.removeAll()
            imageArrayTemp.removeAll()
            imageUrlArrayTemp.removeAll()
            self.performSegue(withIdentifier: "goToViewUI", sender: self)
            
        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 메모 삭제 끝
    
    
    
    
    
    
    // 입력 취소 버튼 Start
    
    @IBAction func writeCancle(_ sender: UIButton) {
        
        if (memoNumber != -1 && (writeTextView.text != mMemoDataValue[memoNumber] || directoryNameListTemp != mMemoImageDic[memoNumber])) || (memoNumber == -1 && (writeTextView.text != String() || directoryNameListTemp != [])) {
            
            print("writeTextView.text :", writeTextView.text)
            print("directoryNameListTemp :", directoryNameListTemp)
        let alertController = UIAlertController(title: "BACK to main?", message: "Your edits will not be saved", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Back", style: .default) { (_) in
            
            
        self.writeTextView.resignFirstResponder()
        
        directoryNameListTemp.removeAll()
        imageArrayTemp.removeAll()
        imageUrlArrayTemp.removeAll()
        self.performSegue(withIdentifier: "goToViewUI", sender: self)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.writeTextView.resignFirstResponder()
            
            directoryNameListTemp.removeAll()
            imageArrayTemp.removeAll()
            imageUrlArrayTemp.removeAll()
            self.performSegue(withIdentifier: "goToViewUI", sender: self)
        }
        
    }
    
    // 입력 취소 버튼 End
    
    
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        self.writeTextView.resignFirstResponder()
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if memoNumber == -1 {
            self.writeTextView.becomeFirstResponder()//텍스트필드에 포커스
            
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if directoryNameListTemp != [] { // 이미지 값이 있으면 콜렉션 뷰를 숨기지 않는다
            imageCollectionHide (false)
            
            var frame = self.writeTextView.frame
            frame.size.height = 380
            self.writeTextView.frame = frame
            
        } else {
            imageCollectionHide (true)
            
        }
        writeCollection.reloadData()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("memoNumber :", memoNumber)
        
        writeMainLabel.text = "[\(arraySelect)]"
        
        writeCollection.layer.borderColor = UIColor.lightGray.cgColor
        
        writeTextView.inputAccessoryView = toolBarView
        
        writeTextView.delegate = self
        
 

    
        // 새 메모 작성(-1)할 때와 수정할 때 텍스트 입력 화면 Start
        
        if memoNumber == -1 { // 새 메모
            
            // 텍스트 부분
            mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
            writeTextView.text = ""
            // 텍스트 부분 끝
            
            
            
            // 이미지 부분
            mMemoImageDic = UserDefaults.standard.object(forKey: "\(arraySelect)_Dic_Faith") as? [[String]] ?? [[String]]() // 이미지 배열 불러오기
            directoryNameList = UserDefaults.standard.object(forKey: "\(arraySelect)_directoryNameList") as? [String] ?? [String]() // 디렉토리 배열 불러오기
            // 이미지 부분 끝
            
            
        } else { // 메모 수정
            
            // 텍스트 부분
            mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as! [String]
            writeTextView.text = mMemoDataValue[memoNumber]
            // 텍스트 부분 끝
            
            
            // 이미지 부분
            mMemoImageDic = UserDefaults.standard.object(forKey: "\(arraySelect)_Dic_Faith") as? [[String]] ?? [[String]]() // 이미지 배열 불러오기
            directoryNameList = UserDefaults.standard.object(forKey: "\(arraySelect)_directoryNameList") as? [String] ?? [String]() // 디렉토리 배열 불러오기
            
            directoryNameListTemp = mMemoImageDic[memoNumber]
            
            
            // 이미지 부분 끝
            
//            print("mMemoImageDic :", mMemoImageDic)
//            print("뷰디드로드 : 메모 수정 텍스트 입력 화면 directoryNameList :", directoryNameList)
        
            
        }
        // 새 메모 작성(-1)할 때와 수정할 때 텍스트 입력 화면 End
        
    }
    
    
    
    
    
    
    
    
}
