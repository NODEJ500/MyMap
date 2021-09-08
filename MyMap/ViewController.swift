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
            
        //入力された文字から位置情報を取得（６）
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
                            
                            //MKPointAnnotationインスタンスを取得し、ピンを生成（１２）
                            let pin = MKPointAnnotation()
                            
                            //ピンを置く緯度経度を設定（１３）
                            pin.coordinate = targetCoordinate
                            
                            //ピンを設定（１４）
                            pin.title = searchKey
                            
                            //ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            //緯度経度を中心にして、半径500mの範囲を表示（１６）
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate , latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                    }
                  }
                }
           })
       }
        //デフォルト操作を行うので、trueを返す（４）
        return true
    }
    @IBAction func chageMapButton(_ sender: Any) {
        
        //mapTypeプロパティー値をトグル
        //標準　→　航空写真　→　航空写真＋標準
        //　→　３D Flyover →　３D　Flyover＋標準
        //　→　交通機関
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        } else if dispMap.mapType == .satellite{
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid{
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover{
            dispMap.mapType = .hybridFlyover
        } else if  dispMap.mapType == .hybridFlyover{
            dispMap.mapType = .mutedStandard
        } else {
            dispMap.mapType = .standard
    }
  }
}
