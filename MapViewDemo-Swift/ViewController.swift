//
//  ViewController.swift
//  MapViewDemo-Swift
//

import UIKit
import ArcGIS


class ViewController: UIViewController , AGSMapViewLayerDelegate{

    var mapController = MapInstanced.sharedInstance
//    var mapEnum = TDTCase(rawValue: 1)
    
    @IBOutlet weak var mapView: AGSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set the delegate for the map view
        self.mapView.layerDelegate = self
        //Add it to the map view
        //MARK: Vector+Anno
        let tdtLayer: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(vec) as! CustomerTiledLayer
        self.mapView.addMapLayer(tdtLayer, withName: "tdtLayer")
        let tdtLayerAnno: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(anno) as! CustomerTiledLayer
        self.mapView.addMapLayer(tdtLayerAnno, withName: "tdtLayerAnno")
        //MARK: Image+Anno
//        let tdtLayer: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(img) as! CustomerTiledLayer
//        self.mapView.addMapLayer(tdtLayer, withName: "tdtLayer")
//        let tdtLayerAnno: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(imageanno) as! CustomerTiledLayer
//        self.mapView.addMapLayer(tdtLayerAnno, withName: "tdtLayerAnno")
    }
    //MARK: AGSMapViewLayerDelegate methods
    
    func mapViewDidLoad(mapView: AGSMapView!){

        self.mapView.locationDisplay.autoPanMode = .Default
        self.mapView.locationDisplay.startDataSource()
    }

}

