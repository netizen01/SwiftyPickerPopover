//
//  ViewController.swift
//  SwiftyPickerPopover
//
//  Created by Yuta Hoshino on 2016/09/14.
//  Copyright © 2016 Yuta Hoshino. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class SampleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBAction func tappedStringPickerButton(_ sender: UIButton) {
        let displayStringFor:((String?)->String?)? = { string in
            if let s = string {
                switch(s){
                case "value 1":
                    return "😊"
                case "value 2":
                    return "😏"
                case "value 3":
                    return "😓"
                default:
                    return s
                }
            }
            return nil
        }
        
        // StringPickerPopover appears
        StringPickerPopover(title: "StringPicker", choices: ["value 1","value 2","value 3"])
            .setDisplayStringFor(displayStringFor)
            .setDoneAction({
                selectedRow, selectedString in
                print("done row \(selectedRow) \(selectedString)")
            })
            .setCancelAction({
                print("cancel")
            })
            .appear(originView: sender, baseViewController: self)
        
    }
    
    @IBAction func tappendDatePickerButton(_ sender: UIButton) {
        // DatePickerPopover appears
        DatePickerPopover().appearFrom(originView: sender, baseViewController: self, title: "DatePicker", secondsToAutomaticallyHide: 3.0, afterHiddenAction: { print("automatically hidden")}, dateMode: .date, initialDate: Date(), minimumDate:nil, maximumDate:nil, doneAction: { selectedDate in print("selectedDate \(selectedDate)")}, cancelAction: {print("cancel")})
        // Or more briefly. minimumDate and maximumDate are omissible.
//        DatePickerPopover().appearFrom(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), doneAction: { selectedDate in print("selectedDate \(selectedDate)")}, cancelAction: {print("cancel")})

    }
    
    @IBAction func tappendDatePickerCanClearButton(_ sender: UIButton) {
        // DatePickerPopover appears
        DatePickerPopover().appearFrom(originView: sender, baseViewController: self, title: "Clearable DatePicker", dateMode: .date, initialDate: Date(), doneAction: { selectedDate in print("selectedDate \(selectedDate)")}, cancelAction: {print("cancel")},clearAction: { print("clear")})
    }
    
    @IBAction func tappendDatePickerTime5MinIntButton(_ sender: UIButton) {
        // DatePickerPopover appears.
        // permittedArrowDirections and minuteInterval are omissible.
        DatePickerPopover().appearFrom(originView: sender, baseViewController: self, title: "DatePicker .time 5minInt.", permittedArrowDirections: .down, dateMode: .time, initialDate: Date(), minuteInterval: 5, doneAction: { selectedDate in print("selectedDate \(selectedDate)")}, cancelAction: {print("cancel")})
    }

    @IBAction func countdownButton(_ sender: UIButton) {
        // DatePickerPopover appears
        print("countdown")
        CountdownPickerPopover().appearFrom(originView: sender, baseViewController: self, title: "CountdownPicker", dateMode: .countDownTimer, initialInterval: TimeInterval(), doneAction: { timeInterval in print("timeInterval \(timeInterval)")}, cancelAction: {print("cancel")})
        
    }
    
    @IBAction func columnsString(_ sender: UIButton) {
        ColumnStringPickerPopover().appearFrom(originView: sender, baseViewController: self, title: "Columns Strings",
            choices: [["Breakfast", "Lunch", "Dinner"], ["Tacos", "Sushi", "Steak", "Waffles", "Burgers"]],
            initialRow: [0,0],
            columnPercent: [0.5, 0.5],
            fontSize: 12.0,
            doneAction: { selectedRows, selectedStrings in print("selected rows \(selectedRows) strings \(selectedStrings)")}, cancelAction: {print("cancel")})
    }

    //CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let theCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = theCell.contentView.viewWithTag(1) as! UILabel
        label.text = (indexPath as NSIndexPath).row.description
        
        return theCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let theCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let popover = StringPickerPopover(title: "CollectionView", choices: ["value 1","value 2","value 3"])
        .setInitialRow(1)
        .setDoneAction({ (selectedRow, selectedString) in
            print("done row \(selectedRow) \(selectedString)")
        })
        .setCancelAction( { print("cancel")}
        )
        
        popover.appear(originView: theCell, baseView: collectionView, baseViewController: self)
        popover.hideAutomatically(after: 5.0)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    
}

