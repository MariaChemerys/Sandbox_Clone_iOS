//
//  Coloring State.swift
//  Sandbox Clone
//
//  Created by Mariia Chemerys on 19.11.2023.
//

import Foundation
import SwiftUI

class ColoringState: ObservableObject{
    
// GETTING COORDINATES FROM A TEXT FILE
    
    func getRowColumnCoordinatesSeparatedByComma(coordinatesString: String) -> [String]{
        
        // delete * (string end indicator) and n (missing color indicator) from the coordinatesString
        var cleanedCoordinatesString = coordinatesString.replacingOccurrences(of: "*", with: "")
        cleanedCoordinatesString = cleanedCoordinatesString.replacingOccurrences(of: "n", with: "")
        
        var rowColumnCoordinatesSeparatedByComma: [String] = cleanedCoordinatesString.components(separatedBy: ";")
        rowColumnCoordinatesSeparatedByComma.removeLast()
        return rowColumnCoordinatesSeparatedByComma
    }
    
    
// GETTING NUMBERS OF SQUARES FROM THE TEXT FILE WITH NUMBERED GRIDS
    
    func readLinesFromFile(fileName: String) -> [String] {
        let errorArray: [String] = Array(repeating: "error", count: 1)
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt"){
            do {
                // Read the contents of the file into a string
                let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
                
                // Split the string into an array of lines
                let trimmedInput = fileContents.trimmingCharacters(in: .whitespacesAndNewlines)

                let lines = trimmedInput.components(separatedBy: "\n")
                
                return lines
            } catch {
                // Handle error if file reading fails
                print("Error reading file: \(error)")
                return errorArray
            }
        }
        else{
            print("file not found")
        }
        return errorArray
    }
    
    func linesWithSquareNumbersToTwoDimensionalIntArray(lines: [String]) -> [[Int]]{
        
        // Split each row into columns and convert the string values to integers
        let boardHeight = getBoardHeight(arrayOfNumberedSquaresStrings: lines)
        let boardWidth = getBoardWidth(arrayOfNumberedSquaresStrings: lines)
        var str2DArray = Array(repeating: Array(repeating: "", count: boardWidth), count: boardHeight)
        var i=0
        for currentLine in lines{
            var currentLineSeparated = currentLine.components(separatedBy: ",")
            currentLineSeparated.removeLast()
            str2DArray[i] = currentLineSeparated
            i+=1
        }
        
        // Convert the 2D string array to a 2D int array
        let intArray: [[Int]] = str2DArray.map { row in
            row.map { element in
                // Convert each element to an integer
                if let intValue = Int(element) {
                    return intValue
                } else {
                    // Handle cases where conversion fails (e.g., non-integer strings)
                    return 584 // Default value
                }
            }
        }
        
        return intArray
    }
    
// GETTING BOARD HEIGHT AND WIDTH
    
    func getBoardHeight(arrayOfNumberedSquaresStrings: [String]) -> Int{
        let boardHeight = arrayOfNumberedSquaresStrings.count
        return boardHeight
    }
    
    func getBoardWidth(arrayOfNumberedSquaresStrings: [String]) -> Int{
        let squareNumbersInAString = arrayOfNumberedSquaresStrings[0].components(separatedBy: ",")
        let boardWidth = squareNumbersInAString.count - 1
        return boardWidth
    }
    
    func getPresentColorsNumbers(squareNumbersInt2DArray: [[Int]]) -> [Int]{
        let flattenedSet = Set(squareNumbersInt2DArray.flatMap { $0 })

        // Convert the set back to an array
        let uniqueNumbers = Array(flattenedSet)
        let sortedUniqueNumbers = uniqueNumbers.sorted()
        return sortedUniqueNumbers
    }
    
    func getColor(squareNumber: Int) -> Color{
        switch(squareNumber){
        case 0:
            return Color.white
        case 1:
            return Color.gray
        case 2:
            return Color.black
        case 3:
            return Color.green
        case 4:
            return Color("apricot")
        case 5:
            return Color.blue
        case 6:
            return Color("dark blue")
        case 7:
            return Color("light blue")
        case 8:
            return Color.orange
        case 9:
            return Color("very light gray")
        case 10:
            return Color("light orange")
        case 11:
            return Color("dark gray")
        case 12:
            return Color.yellow
        case 13:
            return Color("light yellow")
        case 14:
            return Color("light red")
        case 15:
            return Color.red
        case 16:
            return Color.brown
        case 17:
            return Color("light brown")
        case 18:
            return Color("dark brown")
        case 19:
            return Color("dark green")
        case 20:
            return Color("light green")
        case 21:
            return Color("dark pink")
        case 22:
            return Color.purple
        case 23:
            return Color("dark red")
        default:
            return Color.cyan
        }
    }
    
    // This function is used when VoiceOver mode is ON to vocalize the names of colors
    func getColorName(squareNumber: Int) -> String{
        switch(squareNumber){
        case 0:
            return "white"
        case 1:
            return "gray"
        case 2:
            return "black"
        case 3:
            return "green"
        case 4:
            return "pink"
        case 5:
            return "blue"
        case 6:
            return "dark blue"
        case 7:
            return "light blue"
        case 8:
            return "orange"
        case 9:
            return "light gray"
        case 10:
            return "light orange"
        case 11:
            return "dark gray"
        case 12:
            return "yellow"
        case 13:
            return "light yellow"
        case 14:
            return "light red"
        case 15:
            return "red"
        case 16:
            return "brown"
        case 17:
            return "light brown"
        case 18:
            return "dark brown"
        case 19:
            return "dark green"
        case 20:
            return "light green"
        case 21:
            return "dark pink"
        case 22:
            return "purple"
        case 23:
            return "dark red"
        default:
            return "cyan"
        }
    }
    
    func isPictureColored(colorArray: [[Color]]) -> Bool {
        for row in colorArray {
            for color in row {
                if color == .lightGray {
                    return false
                }
            }
        }
        return true
    }
}
