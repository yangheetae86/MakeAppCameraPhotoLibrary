//
//  ViewController.swift
//  MakeApp15-2CameraPhotoLibrary
//
//  Created by JU HAN LEE on 2020/04/03.
//  Copyright © 2020 YangHeeTae. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var imgView: UIImageView!
    let imagePicker: UIImagePickerController! = UIImagePickerController()//인스턴스 변수생성
    var captureImage: UIImage!//이미지 저장변수
    var videoURL: URL!//녹화비디오URL저장변수
    var flagImageSave = false//이미지저장여부 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) { //카메라의 사용 가능 여부를 확인, 가능한경우 아래내용수행
            flagImageSave = true //카메라 촬영후 저장할 것이기 때문에 이미지 저장을 허용
            imagePicker.delegate = self // 이미지 피커의 델리게이트를 self로 설정합니다
            imagePicker.sourceType = .camera //이미지 피커의 소스타입을 camera로 설정합니다
            imagePicker.mediaTypes = [kUTTypeImage as String] //미디어 타입은 kUTTypeImage로 설정
            imagePicker.allowsEditing = false //편집은 허용하지 않음
            
            present(imagePicker, animated: true, completion: nil) //현재뷰 컨트롤러를 imagePicker로 대체 즉 뷰에 imagepicker가 보이게
        }
        else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.") //카메라를 사용할수 없을때는 경고창표시
        }
    }
    
    @IBAction func btnLoadImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) { //사진첩의 사용 여부를 확인, 가능한 경우 아래내용수행
            flagImageSave = false //카메라 촬영후 저장이 아니고 불러오기떄문에 false
            
            imagePicker.delegate = self //이미지 피커의 델리게이트를 self로 설정합니다
            imagePicker.sourceType = .photoLibrary //이미지 피커의 소스타입을 photoLibrary로 설정합니다
            imagePicker.mediaTypes = [kUTTypeImage as String] //미디어 타입은 kUTTypeImage로 설정
            imagePicker.allowsEditing = true //편집은 허용함
            
            present(imagePicker, animated: true, completion: nil) //현재뷰 컨트롤러를 imagePicker로 대체 즉 뷰에 imagepicker가 보이게
        }
        else {
            myAlert("Photo album inaccessable", message: "UIApplication cannot aceess the photo album")
        }
    }
    
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }
    let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
    
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) { //카메라의 사용 가는 여부 확인, 가능한 경우 아래내용수행
            flagImageSave = true //카메라 촬영후 저장할 것이기 때문에 이미지 저장을 허용
            
            imagePicker.delegate = self // 이미지 피커의 델리게이트를 self로 설정합니다
            imagePicker.sourceType = .camera //이미지 피커의 소스타입을 camera로 설정합니다
            imagePicker.mediaTypes = [kUTTypeMovie as String] //미디어 타입은kUTTypeMovie로 설정
            imagePicker.allowsEditing = false //편집은 허용함
            
            present(imagePicker, animated: true, completion: nil) //현재뷰 컨트롤러를 imagePicker로 대체 즉 뷰에 imagepicker가 보이게
        }
        else {
            myAlert("Camera inccessable", message: "Application cannot access the camera.") //카메라를 사용할수 없을때는 경고창표시
        }
    }
    
    @IBAction func btnLoadVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) { //사진첩의 사용 여부를 확인, 가능한 경우 아래내용수행
            flagImageSave = false //카메라 촬영후 저장이 아니고 불러오기떄문에 false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary //이미지 피커의 소스타입을 photoLibrary로 설정합니다
            imagePicker.mediaTypes = [kUTTypeMovie as String] //kUTTypeMovie
            imagePicker.allowsEditing = false //비디오편집? false
            
            present(imagePicker, animated: true, completion: nil) //현재뷰 컨트롤러를 imagePicker로 대체 즉 뷰에 imagepicker가 보이게
        }
        else {
            myAlert("Photo album inccessable", message: "Application cannot access the photo album.")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imgView.image = captureImage
        }
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            if flagImageSave {
                    videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
                }
            }
        self.dismiss(animated: true, completion: nil)
        }
    }

