//
//  CustomerLayerOperation.swift
//  MapViewDemo-Swift
//
//  Created by 赵春红(sugar) on 15/7/16.
//  Copyright (c) 2015年 Esri. All rights reserved.


import UIKit
import ArcGIS
import Foundation

class CustomerLayerOperation: NSOperation {
    let fatherView: CustomerTiledLayer
    var tileKey: AGSTileKey
    var imageData: NSData = NSData()
    var mapType: String
    init(tile: AGSTileKey,mapType: String,fatherView: CustomerTiledLayer) {
        self.tileKey = tile
        self.fatherView = fatherView
        self.mapType = mapType
    }
    override func main() {
        autoreleasepool{
            if self.isCancelled(){
                return
            }
            if(!self.isCancelled()){
                let baseUrl = String(format: self.mapType,(self.tileKey.level),(self.tileKey.row),(self.tileKey.column))
                let aUrl: NSURL = NSURL(string: baseUrl)!
                let data: NSData?  = NSData(contentsOfURL: aUrl)
                if let newData = data {
                    self.imageData = newData
                }
                if(!self.isCancelled()){
                    self.fatherView.didFinishedOperation(self)
                }
            }
        }
    }
}
