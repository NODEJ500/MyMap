//
//  ViewController.swift
//  MyMap
//
//  Created by Jun on 2021/09/08.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dispMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる（１）
        textField.resignFirstResponder()
        
        //入力された文字を取り出す（２）
        if let searchKey = textField.text {
            
        //入力された文字をデバックエリアに表示（３）
        print(searchKey)
            
        //入力された文字から位置情報を取得（５）
        let geodcoder = CLGeocoder()
            
        ////入力された文字から位置情報を取得（６）
            geodcoder.geocodeAddressString(searchKey, completionHandler: { (placemarks,error) in
                
                //位置情報が存在する場合は、unwrapPlacemarksを取り出す（７）
                if let unwrapPlacemarks = placemarks {
                    
                    //１件目の情報を取り出す（８）
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        //位置情報を取り出す（９）
                        if let locatoin = firstPlacemark.location {
                            
                            //位置情報から緯度経度をtargetCoordinateに取り出す（１０）
                            let targetCoordinate = locatoin.coordinate
                            
                            //緯度経度をデバックエリアに表示（１１）
                            print(targetCoordinate)
                        
                    }
                  }
                }
        })
    }
        return true
    }
}

