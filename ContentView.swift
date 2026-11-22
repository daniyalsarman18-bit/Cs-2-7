import SwiftUI

struct ContentView: View {
    @State private var isMenuOpen = true
    @State private var bubblePosition = CGPoint(x: 190, y: 160)
    @State private var dragStart = CGPoint(x: 190, y: 160)
    @State private var esp = false
    @State private var noRecoil = false
    @State private var aimAssist = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(colors: [.black, Color(red: 0.10, green: 0.015, blue: 0.025)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 10) {
                    Text("BALDYREX")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .tracking(3).foregroundStyle(.white)
                    Text("SO2 / CONTROL PANEL")
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .tracking(2).foregroundStyle(.red)
                    Text("DEMO INTERFACE")
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .tracking(2).foregroundStyle(.gray)
                    Divider().overlay(Color.red.opacity(0.45))
                    ToggleRow(title: "ESP", subtitle: "Visual demo switch", isOn: $esp)
                    ToggleRow(title: "NO RECOIL", subtitle: "Visual demo switch", isOn: $noRecoil)
                    ToggleRow(title: "AIM ASSIST", subtitle: "Visual demo switch", isOn: $aimAssist)
                    Divider().overlay(Color.red.opacity(0.45))
                    HStack {
                        Circle().fill(.red).frame(width: 7, height: 7)
                        Text("LOCAL UI ONLY")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundStyle(.gray)
                        Spacer()
                        Button("HIDE") {
                            withAnimation(.spring(response: 0.32)) { isMenuOpen = false }
                        }
                        .font(.system(size: 11, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.white).padding(.horizontal, 13).padding(.vertical, 8)
                        .background(Color.red.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(18)
                .frame(width: min(geometry.size.width - 36, 310))
                .background(.ultraThinMaterial)
                .background(Color.black.opacity(0.78))
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.red.opacity(0.8), lineWidth: 1.2))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .shadow(color: .red.opacity(0.22), radius: 22)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .opacity(isMenuOpen ? 1 : 0)
                .scaleEffect(isMenuOpen ? 1 : 0.92)

                if !isMenuOpen {
                    Button {
                        withAnimation(.spring(response: 0.32)) { isMenuOpen = true }
                    } label: {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 20, weight: .black))
                            .foregroundStyle(.white).frame(width: 58, height: 58)
                            .background(Color(red: 0.75, green: 0.02, blue: 0.08))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 1))
                            .shadow(color: .red.opacity(0.45), radius: 14)
                    }
                    .position(bubblePosition)
                    .gesture(DragGesture().onChanged { value in
                        bubblePosition = CGPoint(
                            x: min(max(34, dragStart.x + value.translation.width), geometry.size.width - 34),
                            y: min(max(70, dragStart.y + value.translation.height), geometry.size.height - 70))
                    }.onEnded { _ in dragStart = bubblePosition })
                }
            }
            .onAppear {
                bubblePosition = CGPoint(x: geometry.size.width - 48, y: geometry.size.height * 0.55)
                dragStart = bubblePosition
            }
        }
        .statusBarHidden()
    }
}

private struct ToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.system(size: 13, weight: .black, design: .rounded)).foregroundStyle(.white)
                Text(subtitle).font(.system(size: 9, weight: .medium, design: .monospaced)).foregroundStyle(.gray)
            }
            Spacer()
            Toggle(title, isOn: $isOn).labelsHidden().tint(.red).scaleEffect(0.88)
        }
        .padding(.vertical, 5)
    }
}
