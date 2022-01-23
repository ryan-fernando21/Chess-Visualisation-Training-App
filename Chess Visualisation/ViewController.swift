//
//  ViewController.swift
//  Chess Visualisation
//
//  Created by Ryan Fernando on 23/01/2022.
//


import UIKit
import AVFoundation




func firstProcess(string:String) -> String {
    var newString:String = ""
    let numbers:String = "1234567890"
    var count = 0

    for char in string {
        
       
        if char=="."{
            newString = ""
        }
        else {
            newString.append(char)
        }
    }
    return newString
}

func processMoves(string:String)->String {
    var newString = ""
    for char in string {
        if char == "N" {
            newString.append(" Knight ")
        }
        else {
            if char == "B" {
                newString.append(" Bishop ")
            }
            else {
                if char == "Q" {
                    newString.append(" Queen ")
                }
                else {
                    if char == "K" {
                        newString.append(" King ")
                    }
                    else {
                        if (char == "R") {
                            newString.append(" Rook ")
                        }
                        else {
                            if char == "x" {
                                newString.append(" takes ")
                            }
                            else {
                                if char == "+" {
                                    newString.append(" check. ")
                                }
                                else {
                                    if char == "#" {
                                        newString.append( " checkmate.")
                                    }
                                    else {
                                        newString.append(char)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return newString
}

func firstElem(string: String) -> (String, String) {
    let numbers = "1234567890"
    var newString = ""
    var counter = 0
    var count = 0
    var i = 0
    var string_copy: String = string
    loop: for char in string_copy {
        if count == 2 && counter == 2 {
                break loop
            }
        if
            numbers.contains(char) {
            count = count + 1
        }
        else {
            if char == "." {
                count = count + 1
            }
            else{
                count = 0
            }
        }
        if count == 2 {
            counter = counter + 1
        }
        newString.append(char)
        string_copy.remove(at: string_copy.startIndex)
        i = i + 1
        
    }
    if counter==2 && count == 2 {
        let first_elem = String(newString.dropLast(2))
        let to_append = String(newString[newString.index(newString.endIndex, offsetBy: -2)...])
        return (first_elem, to_append + string_copy)
    }
    let first_elem = String(newString)
    return(first_elem, string_copy)
}

func readFile(file: String) -> String{
    var savedData = ""
    do{
        savedData = try String(contentsOfFile: file)
    } catch {
        
        print(error)
    }
    var delete = false
    var newData = ""
    for char in savedData {
        if char == "[" {
            delete = true
        }
        if char == "\\" {
            delete = true
        }
        if char == "n" {
            delete = true
        }
       if delete == false {
            newData.append(char)
        }
        if (char == "]") {
            delete = false
        }

    }
   
    return newData
}

var all_moves:String = readFile(file: "/Users/ryanfernando/Downloads/chess_game.pgn")
var current_moves:String = ""

class ViewController: UIViewController {
   
   
    @IBOutlet weak var slower: UIButton!
    
    @IBOutlet weak var faster: UIButton!
    
    @IBOutlet weak var moves: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var string = all_moves
    var current_moves = ""
    var tuple:(String,String) = ("","")
    
   
    
    
    
    @IBAction func speak_moves(_ sender: Any) {
        if (all_moves == "") {
            let utterance = AVSpeechUtterance(string: "Game Over")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)

        }
        tuple = firstElem(string: all_moves)
        current_moves = tuple.0
        all_moves = tuple.1
        let first_process = firstProcess(string: current_moves)
        let to_speak = processMoves(string: first_process)
        moves.text = current_moves
        let utterance = AVSpeechUtterance(string: to_speak)
        print(current_moves)
        print(first_process)
        print(to_speak)
        print("----")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
   

}


