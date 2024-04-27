//
//  ContentView.swift
//  Sandbox Clone
//
//  Created by Mariia Chemerys on 16.11.2023.
//

import SwiftUI

struct MainView: View {
    
    
    @State var searchTerm = ""
    
    var numberedPicturebwViewModel = NumberedPicturebwViewModel()
    
    var filteredPictures: [NumberedPicturebw]{
        guard !searchTerm.isEmpty else {return numberedPicturebwViewModel.numberedPicturesbw}
        return numberedPicturebwViewModel.numberedPicturesbw.filter{$0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        //ScrollView {
            
        NavigationView {
            //Image("beaver colored")
            ScrollView {
            
            VStack {
                
                HStack {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                        .bold()
                        .position(CGPoint(x: 25, y: 25))
                        .accessibilityLabel("settings")
                    
                    NavigationLink(destination: GalleryView(), label: {
                        Text("")
                            .position(/*@START_MENU_TOKEN@*/CGPoint(x: 10.0, y: 10.0)/*@END_MENU_TOKEN@*/)
                            .frame(width: 10, height:10)
                    })
                    .background(
                        Rectangle()
                            .frame(width: 10, height:10)
                            .cornerRadius(2)
                            .foregroundColor(.apricot))
                    .position(CGPoint(x: 121, y: 26))
                    .accessibilityLabel("gallery screen")
                    
                    
                    Rectangle()
                        .frame(width: 12, height:12)
                        .cornerRadius(2)
                        .foregroundColor(.gray)
                        .position(CGPoint(x: 0, y: 25))
                        .accessibilityLabel("picture catalog screen")
                    Rectangle()
                        .frame(width: 10, height:10)
                        .foregroundColor(.clear)
                        .border(Color.gray, width: 1.1)
                        .cornerRadius(2)
                        .position(CGPoint(x: -120, y: 26))
                        .accessibilityLabel("draw screen")
                }
                //                    .background(
                //                     Rectangle())
                .frame(height: 40)
                .padding(0)
                
                
                if(searchTerm.isEmpty) {
                    Rectangle()
                        .frame(height: 10)
                        .padding(-5)
                        .foregroundColor(Color("light gray"))
                    
                    ZStack {
                        ScrollView(.horizontal) {
                            Rectangle()
                                .frame(width: 500, height: 0)
                                .foregroundColor(.clear)
                                .zIndex(0)
                            HStack{
                                ForEach(filteredPictures.suffix(5)){
                                    numberedPicturebw in
                                    NavigationLink{
                                        ColoringView(numberedPicturebw: numberedPicturebw)
                                    }label: {
                                        HStack{
                                            Image(numberedPicturebw.imageNamebw)
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .border(Color.black, width: 3)
                                                .cornerRadius(12)
                                            
                                        }
                                    }.accessibilityHint("Double tap to open the image and color it.")
                                }
                            }.zIndex(1)
                                .position(x: 273, y: 50)
                                .frame(width: 548, height: 107)
                            
                            
                        }
                        
                    }
                }
                
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(height: 790)
                        .padding(-5)
                        .foregroundColor(Color("light gray"))
                        .zIndex(0)
                        .position(CGPoint(x: 200, y: 390))
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(filteredPictures.prefix(8)){
                            numberedPicturebw in
                            NavigationLink{
                                ColoringView(numberedPicturebw: numberedPicturebw)
                            }label: {
                                HStack{
                                    
                                    if(searchTerm.isEmpty) {
                                        Image(numberedPicturebw.imageNamebw)
                                            .resizable()
                                            .frame(width: 187, height: 185)
                                            .cornerRadius(15)
                                    }
                                    else{
                                        Image(numberedPicturebw.imageNamebw)
                                            .resizable()
                                            .frame(width: 187, height: 185)
                                            .cornerRadius(15)
                                        //.position(CGPoint(x: 100, y: -100))
                                    }
                                    
                                }
                            }.accessibilityHint("Double tap to open the image and color it.")
                        }
                    }.position(CGPoint(x: 196.5, y: 390))
                    
                }
                
                
                Spacer()
            }.frame(height: 1150)
        }
            }.searchable(text: $searchTerm)
            .navigationBarBackButtonHidden()
            .frame(height:1060)
            .position(CGPoint(x: 194.5, y: 500))
            
        //}

    }
}

#Preview {
    MainView()
}
