//
//  ColoringView.swift
//  Sandbox Clone
//
//  Created by Mariia Chemerys on 17.11.2023.
//

import SwiftUI

struct ColoringView: View {
    
    var numberedPicturebw: NumberedPicturebw
    @StateObject var coloringState = ColoringState()
    @State private var isScaled = false
    @State private var scaledButtonIndex: Int? = 0
    //EDIT
    @State private var chosenColorNumber: Int = 0
    @State private var selectedRowIndex: Int?
    @State private var selectedColumnIndex: Int?
    @State private var selectedNumber: Int?
    
    // Introduce a state variable to store colors for each square
    @State private var squareColors: [[Color]] = Array(repeating: Array(repeating: .lightGray, count: 21), count: 20)
    
    
    var body: some View {
        
        let mystring = coloringState.coordinatesFileTextToString(fileName: "\(numberedPicturebw.name) coordinates of colored squares")
        
        let numberedSquaresStrings = coloringState.readLinesFromFile(fileName: "\(numberedPicturebw.name) numbered grid")
        
        let boardWidth = coloringState.getBoardWidth(arrayOfNumberedSquaresStrings: numberedSquaresStrings)
        let boardHeight = coloringState.getBoardHeight(arrayOfNumberedSquaresStrings: numberedSquaresStrings)
        
        let numberedSquaresIntegers = coloringState.linesWithSquareNumbersToTwoDimensionalIntArray(lines: numberedSquaresStrings)
        
        let numbersOfPresentColors = coloringState.getPresentColorsNumbers(squareNumbersInt2DArray: numberedSquaresIntegers)
        
        NavigationView {
            VStack {
                
                ZStack {
                    
                    HStack {
                        NavigationLink(destination: MainView(), label: {
                            Image(systemName: "arrow.backward")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                                .bold()
                                .position(x: 20, y: 10)
                                .navigationBarBackButtonHidden()
                        })
                        .background(
                            Rectangle()
                                .frame(width:30, height: 20)
                                .position(x: 20, y: 10)
                                .foregroundColor(.clear))
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .navigationBarBackButtonHidden()
                        .frame(width:30, height: 20)
                        .position(x: 20, y: 10)
                        .accessibilityLabel("back")
                        .accessibilityHint("Double tap to go back to the picture catalog screen")
                        
                        
                    }
                    
                    VStack(spacing: 1){
                        ForEach(0..<boardHeight){
                            rowIndex in
                            HStack(spacing: 1){
                                ForEach(0..<boardWidth){
                                    columnIndex in
                                    
                                    Text("\(numberedSquaresIntegers[rowIndex][columnIndex])")
                                        .frame(width: 17, height: 22)
                                        .foregroundColor(
                                            //(selectedRowIndex == rowIndex && selectedColumnIndex == columnIndex) ? .blue : .white
                                            squareColors[rowIndex][columnIndex] == .lightGray ? .white : squareColors[rowIndex][columnIndex]
                                        )
                                        .font(.system(size: 14))
                                        .accessibilityLabel(squareColors[rowIndex][columnIndex] == .lightGray ? "number \(numberedSquaresIntegers[rowIndex][columnIndex]) \(coloringState.getColorName(squareNumber: numberedSquaresIntegers[rowIndex][columnIndex])) field not yet colored" : "number \(numberedSquaresIntegers[rowIndex][columnIndex]) \(coloringState.getColorName(squareNumber: numberedSquaresIntegers[rowIndex][columnIndex])) field already colored")
                                        .background(
                                            Rectangle()
                                                .foregroundColor(squareColors[rowIndex][columnIndex]))
                                        .onTapGesture {
                                            selectedRowIndex = rowIndex
                                            selectedColumnIndex = columnIndex
                                            selectedNumber = numberedSquaresIntegers[rowIndex][columnIndex]
                                            if (selectedRowIndex == rowIndex && selectedColumnIndex == columnIndex) && chosenColorNumber == selectedNumber {
                                                let newColor = Color(coloringState.getColor(squareNumber: selectedNumber!))
                                                squareColors[rowIndex][columnIndex] = newColor
                                            }
                                        }
                                    
                                    
                                }
                            }
                        }
                    }
                    .position(CGPoint(x: 197, y: 330))

                    if coloringState.isPictureColored(colorArray: squareColors) == true{
                        Text("Congratulations! You've colored the picture of \(numberedPicturebw.name).")
                            .font(.title)
                            .frame(width: 400)
                            .foregroundColor(Color("apricot"))
                            .position(CGPoint(x: 200, y: 610))
                    }
                    
                    ZStack {
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 33.0){
                                ForEach(numbersOfPresentColors, id:\.self){
                                    number in
                                    Button(action: {
                                        withAnimation {
                                            self.isScaled.toggle()
                                        }
                                    }) {
                                        if number != 0{
                                            Text("\(number)")
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color.white)
                                                .accessibilityLabel("\(coloringState.getColorName(squareNumber: number)) - number \(number)")
                                            
                                                .background(coloringState.getColor(squareNumber: number))
                                                .clipShape(Circle())
                                                .onTapGesture {
                                                    scaledButtonIndex = number
                                                    chosenColorNumber = number
                                                }.scaleEffect(scaledButtonIndex == number ? 1.6 : 1.3)
                                            
                                        }
                                        else{
                                            Text("\(number)")
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color.black)
                                                .background(coloringState.getColor(squareNumber: number))
                                                .clipShape(Circle())
                                            
                                                .accessibilityLabel("\(coloringState.getColorName(squareNumber: number)) - number \(number)")
                                                .onTapGesture {
                                                    scaledButtonIndex = number
                                                    chosenColorNumber = number
                                                }.scaleEffect(scaledButtonIndex == number ? 1.6 : 1.4)
                                            
                                        }
                                    }
                                    .contentShape(Circle())
                                    .accessibility(addTraits: .isButton)
                                    
                                    
                                }
                                
                            }
                            .frame(width: CGFloat(numbersOfPresentColors.count) * 86.0, height: 150)
                            .zIndex(1)
                            
                        }
                    }.background(
                        Rectangle()
                            .foregroundColor(.lightGray)
                            .position(x: 195, y: 90)
                        
                    )
                    .position(CGPoint(x: 200, y: 720))
                    
                }.navigationBarBackButtonHidden()
                
            }.navigationBarBackButtonHidden()
                .frame(width: 400, height:500)
                .position(x: 198, y: 258)
            
            
        }.navigationBarBackButtonHidden()
        
    }
}

#Preview {
    ColoringView(numberedPicturebw: NumberedPicturebw(id:0, name: "tyrannosaurus", imageNamebw: "tyrannosaurus black and white"))
}
