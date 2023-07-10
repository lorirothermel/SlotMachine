//
//  ContentView.swift
//  SlotMachine
//
//  Created by Lori Rothermel on 7/2/23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var showingInfoView: Bool = false
    @State private var reels: Array = [0, 1, 2]
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    
    @State private var isActiveBet10: Bool = true    // Default
    @State private var isActiveBet20: Bool = false
    
    @State private var showingModal: Bool = false
    
    @State private var animatingSymbol: Bool = false
    
        
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    
    
    // MARK: - Functions
    
    // Spin the reels
    func spinReels() {
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }  // spinReels
    
    
    // Check the winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // Player Wins
            playerWins()
            
            // New High Score
            if coins > highscore {
                newHighScore()
            }  // if
        } else {
            // Player Loses
            playerLosses()
        }  // if...else
    }  // checkWinning
    

    func playerWins() {
        coins += betAmount * 10
    }  // playerWins
    
    
    func newHighScore() {
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: "HighScore")
    }  // newHighScore
    

    func playerLosses() {
        coins -= betAmount
    }  // playerLosses
    
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }  // activateBet20
    
    
    func activateBet10() {
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
    }  // activateBet10
    
        
    // Game Is Over
    func isGameOver() {
        if coins <= 0 {
            // Show Modal Windows
            showingModal = true
        }  // if
    }  // isGameOver
    
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
    }  // resetGame
    
    
    
    
    var body: some View {
        ZStack {
            // MARK: - Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - Interface
            VStack(alignment: .center, spacing: 5) {
                // MARK: - Header
                LogoView()
                Spacer()
                
                // MARK: - Score
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }  // HStack
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highscore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }  // HStack
                    .modifier(ScoreContainerModifier())
                    
                    
                }  // HStack
                
                // MARK: - Slot Machine
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - Reel #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut, value: animatingSymbol)
                            .onAppear {
                                animatingSymbol.toggle()
                            }  // .onAppear
                    }  // ZStack
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - Reel #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }  // .onAppear
                        }  // ZStack
                        Spacer()
                        // MARK: - Reel #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut, value: animatingSymbol)
                                .onAppear {
                                    animatingSymbol.toggle()
                                }  // .onAppear
                        }  // ZStack
                    }  // HStack
                    .frame(maxWidth: 500)
                    
                    // MARK: - Spin Button
                    Button {
                        // Spin the reels
                        spinReels()
                        
                        // Check Winning
                        checkWinning()
                        
                        // Game is Over
                        isGameOver()
                        
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }  // Button
                    
                }  // VStack
                .layoutPriority(2)
                
                // MARK: - Footer
                Spacer()
                
                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        // MARK: - Bet 20
                        Button {
                            activateBet20()
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : .white)
                                .modifier(BetNumberModifier())
                        }  // Button - Bet 20
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }  // HStack
                    
                    // MARK: - Bet 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            activateBet10()
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : .white)
                                .modifier(BetNumberModifier())
                        }  // Button - Bet 10
                        .modifier(BetCapsuleModifier())
                        
                    }  // HStack
                }  // HStack
            }  // VStack
            
            // MARK: - Buttons
            .overlay(
                // Reset
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })  // Button
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )  // .overlay
            .overlay(
                // Info
                Button(action: {
                    showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })  // Button
                    .modifier(ButtonModifier()),
                alignment: .topTrailing
            )  // .overlay
            .padding(6)
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            
            // MARK: - PopUp
            if $showingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    // Modal
                    VStack(spacing: 0) {
                        // Title
                        Text("Game Over".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        Spacer()
                        
                        // Message
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad Luck! You lost all of the ooins. \nLet's Play Again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            Button {
                                showingModal = false
                                coins = 100
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )  // .background
                            }  // Button

                        }  // VStack
                        
                        Spacer()
                        
                    }  // VStack
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                }  // ZStack
            }  // if
            
            
        }  // ZStack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }  // .sheet
        
    }  // some View
}  // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
