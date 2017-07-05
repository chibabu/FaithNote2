//
//  main.swift
//  FaithNote
//
//  Created by 차종훈 on 2017. 5. 6..
//  Copyright © 2017년 Carus. All rights reserved.
//
//import Firebase
import UIKit
import ModernSearchBar
//import GoogleMobileAds


class mainView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, ModernSearchBarDelegate {
    
    
    
    
    var arraySelectNumber = Int() // 피커뷰 인덱스 선택 인트값
    var arrayCategory = ["Category"]

    //MARK: - variable start

    @IBOutlet weak var pickerCatego: UIPickerView!
    @IBOutlet weak var memoTableView: UITableView!
    @IBOutlet weak var labelFolderSelect: UILabel!
    @IBOutlet weak var labelMemo: UILabel!
//    @IBOutlet weak var imageViewInTable: UIImageView!
    @IBOutlet weak var labelInTable: UILabel!
    @IBOutlet weak var memoSearchBar: ModernSearchBar!
    @IBOutlet weak var categorySearchBar: ModernSearchBar!
    
    // variable end
    
    override func viewDidLoad() { // 뷰윌어페어보다 먼저
        super.viewDidLoad()
        
        
        
        
//        let url = NSURL(string: "AppName://FaithNote")
//        extensionContext?.open(url! as URL, completionHandler: nil)
        
        
        
        
        // 앱이 재시동 되더라도 이전 카테고리 선택했던 값을 불러온다
        
        
        arrayCategory = UserDefaults.standard.object(forKey: "arrayCategory") as? [String] ?? [String]()

    
        arraySelectNumber = UserDefaults.standard.integer(forKey: "arraySelectNumber")
        
        print("arraySelectNumber :", arraySelectNumber)
        
        if arrayCategory != [] {
            arraySelect = arrayCategory[arraySelectNumber]
        } else {}
        
        
        mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
        
        
        
        
        labelFolderSelect.layer.borderColor = UIColor.lightGray.cgColor
        labelMemo.layer.borderColor = UIColor.lightGray.cgColor
        
        //MARK: - PickerView Act
        pickerCatego.delegate = self
        pickerCatego.dataSource = self
        //MARK: - PickerView Act ..end
        
        
        print("arrayCategory :", arrayCategory)
        print("arraySelectNumber :", arraySelectNumber)
        
        
       
        
        
        
        // 서치바 시작
        ///Uncomment this one...
        configureCategorySearchBar()
            configureSearchBar()
        
        // 서치바 끝
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 불러온 카테고리 값으로 커서를 이동
        self.pickerCatego.selectRow(arraySelectNumber, inComponent: 0, animated: false)
        
    }
    
    
    

    
    
    
    
    
    // function ----
    

    
    
    // 로컬 파일 삭제 start
    
    func localFileDeleteAll (directory : [String]) {
        let fileManager = FileManager.default
//        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path
        do {
            
            for i in 0..<directory.count {
                print("directory.count :", directory.count)
                print("directory: ", directory)
                let filePathName = "\(documentsPath)/\(directory[i])_Faith"
                print("filePathName :", filePathName)
                try fileManager.removeItem(atPath: filePathName)
                
//                _ = try fileManager.contentsOfDirectory(atPath: "\(directory[i])_Faith")
            }
        }
            
            //            }
        catch {
            print("Could not clear temp folder: \(error)")
        }
        
        
    }
    // 로컬 파일 삭제 Function End
    
    
    
    
    
    // Create Category start
    
    @IBAction func createFolder(_ sender: UIBarButtonItem) {

        
        let alertController = UIAlertController(title: "Create Category", message: "Please input new Category name :", preferredStyle: .alert)
        
        // 아무값도 입력하지 않았을 때
        let confirmAction = UIAlertAction(title: "Create", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                if (field.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    
                    let alertView = UIAlertController(title: "Error", message: "No Contents", preferredStyle: UIAlertControllerStyle.alert)
                    // alertview에 확인버튼 삽입
                    alertView.addAction(UIAlertAction(title: "return", style: UIAlertActionStyle.default, handler: nil))
                    
                    // 현재 viewcontroller에 추가하기
                    self.present(alertView, animated: true, completion: nil)
                    
                    
                } else {
                    
                    // 값은 입력 받았으나 기존 있던값을 입력했을 때
                    if self.arrayCategory.contains(field.text!) {
                        
                        let alertView = UIAlertController(title: "Error", message: "Found a Same Title!", preferredStyle: UIAlertControllerStyle.alert)
                        // alertview에 확인버튼 삽입
                        alertView.addAction(UIAlertAction(title: "return", style: UIAlertActionStyle.default, handler: nil))
                        
                        // 현재 viewcontroller에 추가하기
                        self.present(alertView, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        
                        self.arrayCategory.insert(field.text!, at: 0)
                        
                        
                        UserDefaults.standard.set(self.arrayCategory, forKey: "arrayCategory")
                        
                        
                        self.pickerCatego.selectRow(0, inComponent: 0, animated: true)
                        self.pickerView(self.pickerCatego, didSelectRow: 0, inComponent: 0)
                        
                        
                        self.pickerCatego.reloadAllComponents()
                        
                        
                    }
                }
            } else {
                // user did not fill field
                
            }
            
    

        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Category name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        self.categorySearchBar.suggestionsView_maxHeight = 1000
        ///Modify properties of the suggestionsView
        self.categorySearchBar.suggestionsView_backgroundColor = UIColor.brown
        self.categorySearchBar.suggestionsView_contentViewColor = UIColor.yellow
        self.categorySearchBar.suggestionsView_separatorStyle = .singleLine
        self.categorySearchBar.suggestionsView_selectionStyle = UITableViewCellSelectionStyle.gray
        self.categorySearchBar.suggestionsView_verticalSpaceWithSearchBar = 10
        self.categorySearchBar.suggestionsView_spaceWithKeyboard = 20
        configureCategorySearchBar()



        

    }
    
    
    
    // Create Folder end
    
    

    
    

    
    
    // Delete Category start
    
    @IBAction func deleteFolder(_ sender: UIButton) {
        if arrayCategory != [] {
        let alertController = UIAlertController(title: "DELETE this Cateogry?", message: "ALL Memo will be removed in this Category", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Delete", style: .default) { (_) in

        if self.arrayCategory != [] {
            
            
            
            mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
            
            
            self.arraySelectNumber = UserDefaults.standard.integer(forKey: "arraySelectNumber")
            
            
            
            
            self.arrayCategory.remove(at: self.arraySelectNumber)
            UserDefaults.standard.set(self.arrayCategory, forKey: "arrayCategory")
            
            mMemoDataValue.removeAll()
            UserDefaults.standard.set(mMemoDataValue, forKey: "\(arraySelect)_Faith")
            
            
            
            
            // 이미지 부분
            
            
            mMemoImageDic = UserDefaults.standard.object(forKey: "\(arraySelect)_Dic_Faith") as? [[String]] ?? [[String]]() // 이미지 배열 불러오기
            directoryNameList = UserDefaults.standard.object(forKey: "\(arraySelect)_directoryNameList") as? [String] ?? [String]() // 디렉토리 배열 불러오기
            
            
            print("directoryNameList :", directoryNameList)
            if directoryNameList != []{ // 디렉토리값이 있다면
                print("ddirectoryNameList :", directoryNameList)
                self.localFileDeleteAll (directory: directoryNameList)
            }
            
            // 이미지 변수 부분
            directoryNameList.removeAll()
            UserDefaults.standard.set(directoryNameList, forKey: "\(arraySelect)_directoryNameList")
            
        
            mMemoImageDic.removeAll()
            UserDefaults.standard.set(mMemoImageDic, forKey: "\(arraySelect)_Dic_Faith")
            // 이미지 변수 부분 끝
            
            // 이미지 부분 끝
            
            
            
            self.pickerCatego.reloadAllComponents()
            
            if self.arraySelectNumber < self.arrayCategory.endIndex {
                self.pickerView(self.pickerCatego, didSelectRow: self.arraySelectNumber, inComponent: 0)
                
                
            } else {
                self.pickerView(self.pickerCatego, didSelectRow: self.arraySelectNumber-1, inComponent: 0)
                
            }
            
            self.memoTableView.reloadData()
            self.categorySearchBar.getSuggestionsView().reloadData()
        } else {
            
            
        }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        } else {}
        
    }
    
    
    // Delete Category end
    
    
    
    
    // Add memo start
    
    @IBAction func addMemo(_ sender: UIButton) {
        
        
        if arrayCategory != [] {
            
            
            self.performSegue(withIdentifier: "addToWriteView", sender: self)
            
            
        } else {
            let alertView = UIAlertController(title: "Error", message: "No Category!", preferredStyle: UIAlertControllerStyle.alert)
            // alertview에 확인버튼 삽입
            alertView.addAction(UIAlertAction(title: "return", style: UIAlertActionStyle.default, handler: nil))
            
            // 현재 viewcontroller에 추가하기
            self.present(alertView, animated: true, completion: nil)
            
            
        }
    }
    
    // Add memo end
    
    
    
    
    
    
    
    //MARK: - PickerView Declare ..start
    
    
    
    
    
    
    
    // 총 갯수
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrayCategory.count
        
    }
    
    // 뭘 보여줄거냐
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrayCategory[row]
        
    }
    
    // 몇개씩 보여줄꺼냐?
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if arrayCategory != [] { // 카테고리 값이 하나라도 있을 때
            
            UserDefaults.standard.set(arrayCategory.index(of: arrayCategory[row])!, forKey: "arraySelectNumber")
            
            arraySelect = arrayCategory[row]
            
            
        } else {}
        
        memoTableView.reloadData()
        
        configureSearchBar()
        memoSearchBar.resignFirstResponder()
        //        configureCategorySearchBar()
    }
    
    //MARK: - PickerView Declare ..end
    
    
    
    
    
    
    //MARK: - TableView Declare
    
    // 몇개씩 보여줄꺼?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
        // 카테고리를 선택 할때마다 불러와야 하므로
        
        if mMemoDataValue == [] { // 메모값이 없을 때
            labelInTable.isHidden = false
            
            return 0
        }
        
        return mMemoDataValue.count
        
        
    }
    
    // 뭘 보여줄꺼?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMemo = tableView.dequeueReusableCell(withIdentifier: "cellMemo", for: indexPath) as! mainCell
        
        mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
        
        labelInTable.isHidden = true
        
        cellMemo.memoTitle!.text = mMemoDataValue[indexPath.row]
        
        return cellMemo
        
    }
    
    
    
    // 클릭하며 어떻게?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toWriteView", sender: self)
    }
    //    MARK: - TableView Declare ..end
    
    
    
    var numberTemp = Int()

    
    
    // Segue Start
    override func prepare(for segue:  UIStoryboardSegue, sender: Any?) {
        
        
        if let segueIdentifier = segue.identifier {
            
            if segueIdentifier == "toWriteView" {
                
                if let selectedRow = memoTableView.indexPathForSelectedRow?.row {
                    let writeView = segue.destination as! writeView
                    writeView.memoNumber = selectedRow
                    
            } else if (memoSearchBar.getSuggestionsView().indexPathForSelectedRow?.row) != nil {
                    let writeView = segue.destination as! writeView
                    writeView.memoNumber = numberTemp
                    
                } else {
                    
                    // 배열을 선택하지 않았을 때(-1)
                }
            } else {}
        }
    }
    
    // Segue End

    
    
    
    // search bar start
    
    func onClickItemSuggestionsView(item: String) {
        if categorySearchBar.isFirstResponder {
            self.pickerCatego.selectRow(arrayCategory.index(of: item)!, inComponent: 0, animated: true)
            categorySearchBar.resignFirstResponder()
            

        } else if memoSearchBar.isFirstResponder {
            numberTemp = mMemoDataValue.index(of: item)!
            self.performSegue(withIdentifier: "toWriteView", sender: self)
        }

       
    }
    
    ///Called if you use Custom Item suggestion list
//    func onClickItemWithUrlSuggestionsView(item: ModernSearchBarModel) {
//        print("User touched this item: "+item.title+" with this url: "+item.url.description)
//    }
    
    ///Called when user touched shadowView
//    func onClickShadowView(shadowView: UIView) {
//        print("User touched shadowView")
//    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("Text did change, what i'm suppose to do ?")
//    }
    
    //    private func makingSearchBarAwesome(){
    //        self.memoSearchBar.backgroundImage = UIImage()
    //        self.memoSearchBar.layer.borderWidth = 0
    //        self.memoSearchBar.layer.borderColor = UIColor(red: 181, green: 240, blue: 210, alpha: 1).cgColor
    //    }
    
    //    private func configureCategorySearchBar(){
    //        self.categorySearchBar.suggestionsView_searchIcon_width = 15
    //        ///Adding delegate
    //        self.categorySearchBar.delegateModernSearchBar = self
    //
    //        ///Set datas to search bar
    //        self.categorySearchBar.setDatas(datas: arrayCategory)
    //    }
    
    //    private func configureMemoSearchBar(){
    //
    //
    //
    //        arrayCategory = UserDefaults.standard.object(forKey: "arrayCategory") as? [String] ?? [String]()
    //
    //        mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
    //
    //        self.memoSearchBar.suggestionsView_searchIcon_height = 10
    //        self.memoSearchBar.suggestionsView_searchIcon_width = 10
    //
    //
    //        var suggestionListWithUrl = Array<ModernSearchBarModel>()
    //        for i in 0..<mMemoDataValue.count {
    //
    //            suggestionListWithUrl.append(ModernSearchBarModel(title: mMemoDataValue[i].padding(toLength: 5, withPad: "" , startingAt: 0), url: "Overlay.png"))
    //
    //        }
    //
    //        print("mMemoDataValue[1].characters.count :", mMemoDataValue[1].characters.count/mMemoDataValue[1].characters.count+5)
    //
    //        print("suggestionListWithUrl :", suggestionListWithUrl)
    //
    //
    //        ///Adding delegate
    //        self.memoSearchBar.delegateModernSearchBar = self
    //
    //        ///Set datas to search bar
    //        self.memoSearchBar.setDatasWithUrl(datas: suggestionListWithUrl)
    //
    //
    //
    //    }
    
    
    
    
    private func configureCategorySearchBar(){
        arrayCategory = UserDefaults.standard.object(forKey: "arrayCategory") as? [String] ?? [String]()
        
        var suggestionList = Array<String>()
        
        for i in 0..<arrayCategory.count {
            if arrayCategory[i].characters.count <= 18 {
                suggestionList.append(arrayCategory[i].padding(toLength: arrayCategory[i].characters.count, withPad: " ", startingAt: 0))
            } else {
                suggestionList.append("\(arrayCategory[i].padding(toLength: 15, withPad: " ", startingAt: 0))...")
            }
        }
        
        self.categorySearchBar.delegateModernSearchBar = self

        self.categorySearchBar.setDatas(datas: suggestionList)
        
        self.categorySearchBar.suggestionsView_searchIcon_height = 15
        self.categorySearchBar.suggestionsView_searchIcon_width = 15
        
        self.customDesign(categorySearchBar)
    }
    
    
    
    
    private func configureSearchBar(){
        
        arrayCategory = UserDefaults.standard.object(forKey: "arrayCategory") as? [String] ?? [String]()
        
        mMemoDataValue = UserDefaults.standard.object(forKey: "\(arraySelect)_Faith") as? [String] ?? [String]()
 
        
        var suggestionList = Array<String>()

        
        
        for i in 0..<mMemoDataValue.count {
            if mMemoDataValue[i].characters.count <= 18 {
                suggestionList.append(mMemoDataValue[i].padding(toLength: mMemoDataValue[i].characters.count, withPad: " ", startingAt: 0))
            } else {
                suggestionList.append("\(mMemoDataValue[i].padding(toLength: 15, withPad: " ", startingAt: 0))...")
            }
        }
        
        self.memoSearchBar.delegateModernSearchBar = self
        
        
        ///Set datas to search bar
        self.memoSearchBar.setDatas(datas: suggestionList)
        
        self.memoSearchBar.suggestionsView_searchIcon_height = 15
        self.memoSearchBar.suggestionsView_searchIcon_width = 15
        
        self.customDesign(memoSearchBar)
        
    }
    
    private func customDesign(_ modernSearchBarCu: ModernSearchBar){
        
        // --------------------------
        // Enjoy this beautiful customizations (It's a joke...)
        // --------------------------
        
        
        
        //Modify shadows alpha
        modernSearchBarCu.shadowView_alpha = 0.5
        
        //Modify the default icon of suggestionsView's rows
        modernSearchBarCu.searchImage = ModernSearchBarIcon.Icon.search.image
        
        //Modify properties of the searchLabel
        modernSearchBarCu.searchLabel_font = UIFont(name: "Avenir-Light", size: 15)
        modernSearchBarCu.searchLabel_textColor = UIColor.darkGray
        modernSearchBarCu.searchLabel_backgroundColor = UIColor.white
        
        //Modify properties of the searchIcon
        modernSearchBarCu.suggestionsView_searchIcon_height = 15
        modernSearchBarCu.suggestionsView_searchIcon_width = 15
        modernSearchBarCu.suggestionsView_searchIcon_isRound = false
        
        //Modify properties of suggestionsView
        ///Modify the max height of the suggestionsView
        modernSearchBarCu.suggestionsView_maxHeight = 190
        ///Modify properties of the suggestionsView
        modernSearchBarCu.suggestionsView_backgroundColor = UIColor.white
        modernSearchBarCu.suggestionsView_contentViewColor = UIColor.white
        modernSearchBarCu.suggestionsView_separatorStyle = .singleLine
        modernSearchBarCu.suggestionsView_selectionStyle = UITableViewCellSelectionStyle.gray
                 modernSearchBarCu.suggestionsView_verticalSpaceWithSearchBar = 2
                 modernSearchBarCu.suggestionsView_spaceWithKeyboard = 0
    }

    
    
    // search bar end
    
    
    
    // function End ----
    

    
    
    
    
}
