# 💬 WhatsApp Clone UI – Flutter + Firebase

A **WhatsApp-style messaging app** built using **Flutter** and **Firebase**, featuring a high-fidelity UI, dark/light themes, and microinteractions for a polished user experience.

---

## 🚀 Features

### 🏠 Main Screens
- **Home (Chat List)** – Displays user chats with preview, status, and timestamps.
- **Chat (Conversation)** – Real-time messaging interface with animations.
- **Stories (Status)** – Displays and transitions between user stories.

### 🔐 Authentication
- **Phone Number Login (OTP)** using Firebase Authentication.
- Auto user creation in Firestore upon first login.

### 🎨 Design
- Pixel-perfect **WhatsApp-style UI**.
- Custom color system (`WhatsAppColors`) and responsive layouts.
- **Light & Dark Mode** with smooth transitions.
- **Material 3** and adaptive typography.

### 💫 Microinteractions
- Animated chat opening.
- Message send animation.

### ☁️ Firebase Integration
- **Firebase Auth** – Phone verification.
- **Cloud Firestore** – Real-time chat and message storage.
- **Firestore Streams** – Instant updates for chats and messages.

### 🌙 Theme Customization
-Easily switch between light and dark themes with persistence using ThemeProvider.

---

## 🧱 Architecture

**Pattern:** Provider + MVVM  
**Layers:**
- **Models:** Define app data (User, Chat, Message).
- **Providers:** Manage app state and Firebase operations.
- **Services:** Handle backend logic and Firestore interactions.
- **UI Screens:** Built with responsive and animated widgets.

---

## 🧠 Design Philosophy

- Maintain **pixel-perfect fidelity** with the WhatsApp UI.
- Use **clean, scalable, and modular code**.
- Follow **Flutter and Firebase best practices**.
- Ensure **seamless user experience** with microinteractions.

---

## 🧰 Tech Stack

| Technology | Purpose |
|-------------|----------|
| Flutter | Cross-platform UI |
| Firebase Auth | Phone number login |
| Cloud Firestore | Real-time data |
| Provider | State management |
| SharedPreferences | Theme persistence |
| Material 3 | Modern UI components |

---

## 📱 Screenshots

| Start Screen | Verification Screen | Home Screen | Chat Screen | Status Screen |
|--------------|--------------|----------------|--------------|--------------|
| <img width="509" height="1034" alt="Screenshot 2025-10-30 231527" src="https://github.com/user-attachments/assets/bf5c1e60-bb12-4ed5-ba6c-4238b9932b4e" /> | <img width="509" height="1034" alt="Screenshot 2025-10-30 234044" src="https://github.com/user-attachments/assets/a8fbc80c-358a-4385-a6e2-8756ae206081" /> | <img width="509" height="1045" alt="CopyQ fRLosg" src="https://github.com/user-attachments/assets/6d9bba1c-6cd7-4ce5-85ad-33e9460b1f84" /> | <img width="508" height="1045" alt="CopyQ VgVAPh" src="https://github.com/user-attachments/assets/0b34ea6e-665f-4e5a-949a-31edaf880fcc" /> | <img width="509" height="1039" alt="CopyQ suHheg" src="https://github.com/user-attachments/assets/23ad2124-ea48-40d4-8ac0-3420b940a932" /> |

| Light Mode | Dark Mode |
|-------------|------------|
| <img width="509" height="1039" alt="CopyQ mIHNMu" src="https://github.com/user-attachments/assets/87328374-d5ba-43df-9f6c-4d2ad71efdb2" /> | <img width="509" height="1039" alt="CopyQ kxJRIf" src="https://github.com/user-attachments/assets/b5528d73-4ae3-47cf-ac24-6396f9a71cc0" /> |


---

## 🧩 Setup Instructions

1. **Clone Repository**
   ```bash
   git clone https://github.com/radwahmed/whatsApp
   cd whatsApp
