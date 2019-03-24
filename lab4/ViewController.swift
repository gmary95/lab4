//
//  ViewController.swift
//  lab4
//
//  Created by Mary Gerina on 3/17/19.
//  Copyright © 2019 Mary Gerina. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var calculationTable: NSTableView!
    @IBOutlet weak var isCircularChecker: NSButtonCell!
    @IBOutlet weak var imageView: NSImageView!
    
    var n = 0
    var CArr:[Double] = []
    var LArr:[Double] = []
    var RArr:[Double] = []
    var MArr:[Double] = []
    var lambArr:[Double] = []
    var TArr:[Double] = []
    var QArr:[Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func change(_ sender: Any) {
        if isCircularChecker.state == .off {
            imageView.image = NSImage(named: "nonCircular")
        } else {
            imageView.image = NSImage(named: "circular")
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        CArr = []
        LArr = []
        RArr = []
        MArr = []
        lambArr = []
        TArr = []
        QArr = []
        
        let calculator: CalculationHelper = isCircularChecker.state == .off ? LinearCalculationHelper() : CircularCalculationHelper()
        
        for i in 0 ..< calculator.pArray.count {
            CArr.append(calculator.calcC_N(at: i))
            LArr.append(calculator.calcL(i: i))
            RArr.append(calculator.calcR(i: i))
            MArr.append(calculator.calcM(i: i))
            lambArr.append(calculator.calcLamb(i: i))
            TArr.append(calculator.calcT(i: i))
            QArr.append(calculator.calcQ(i: i))
        }
        
        calculationTable.reloadData()
    }
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == calculationTable {
            return CArr.count
        }
        return 1
    }
}

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiersInputTable {
        static let ECell = "EID"
        static let KCell = "KID"
        static let MCell = "MID"
        static let RCell = "RID"
    }
    
    fileprivate enum CellIdentifiersCalculationTable {
        static let PiCell = "PiID"
        static let LiCell = "LiID"
        static let RiCell = "RiID"
        static let MiCell = "MiID"
        static let lambiCell = "lambiID"
        static let TiCell = "TiID"
        static let QiCell = "QiID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableView == calculationTable {
            return self.loadCalculation(tableView, viewFor: tableColumn, row: row)
        }
        return nil
    }
    
    
    func loadCalculation(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSTableCellView? {
        
        var text: String = ""
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            if CArr.count > 0 {
                text = "\(CArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.PiCell
            }
        } else if tableColumn == tableView.tableColumns[1] {
            if LArr.count > 0 {
                text = "\(LArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.LiCell
            }
        } else if tableColumn == tableView.tableColumns[2] {
            if RArr.count > 0 {
                text = "\(RArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.RiCell
            }
        } else if tableColumn == tableView.tableColumns[3] {
            if MArr.count > 0 {
                text = "\(MArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.MiCell
            }
        } else if tableColumn == tableView.tableColumns[4] {
            if lambArr.count > 0 {
            text = "\(lambArr[row].rounded(toPlaces: 6))"
            cellIdentifier = CellIdentifiersCalculationTable.lambiCell
            }
        } else if tableColumn == tableView.tableColumns[5] {
            if TArr.count > 0 {
                text = "\(TArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.TiCell
            }
        } else if tableColumn == tableView.tableColumns[6] {
            if QArr.count > 0 {
                text = "\(QArr[row].rounded(toPlaces: 6))"
                cellIdentifier = CellIdentifiersCalculationTable.QiCell
            }
        }
    
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}

