# CogniDispatch Frontend Client

The **CogniDispatch Frontend** is a modern React web portal built using the Next.js framework. It acts as the interactive user interface for homeowners to create voice-based emergency dispatch requests, and for technicians to accept jobs and stream real-time location telemetry.

## 🚀 Key Features
*   **Voice-Activated Triage**: Integrated with Azure Cognitive Speech SDK to record speech command inputs and feed them to the Azure OpenAI backend.
*   **Interactive Maps**: Real-time geolocation tracking of dispatch incidents and en-route emergency vehicles using Leaflet and OpenStreetMap.
*   **Live Updates**: Bidirectional web socket synchronization with the dispatch service via Socket.IO client.
*   **Flexible Routing**: Uses Next.js API rewrites for seamless integration with multiple backend microservices during local development.

---

## 🛠️ Technology Stack
*   **Framework**: Next.js (v15+)
*   **UI Components**: React 19, Tailwind CSS (v3)
*   **Interactive Maps**: Leaflet, `react-leaflet`
*   **Auth Session Management**: `next-auth`
*   **Voice SDK**: `microsoft-cognitiveservices-speech-sdk`
*   **Real-time sync**: `socket.io-client`

---

## 📁 Repository Structure
```
├── src/
│   ├── app/              # Next.js App Router (pages and layouts)
│   ├── components/       # Reusable React components (Maps, Voice Recorder, Portal UI)
│   └── styles/           # CSS styles and Tailwind configurations
├── next.config.js        # Next.js configurations & API Gateway rewrites
├── postcss.config.js     # PostCSS plugins (Autoprefixer)
├── tailwind.config.js    # Tailwind layout utility configurations
├── Dockerfile            # Standalone multi-stage production build
└── package.json          # Node dependencies
```

---

## ⚙️ Development API Rewrites
During local development, Next.js rewrites traffic destined for `/api/...` to the local microservice endpoints:

*   `/api/auth/` $\rightarrow$ Auth Service (`http://localhost:5001`)
*   `/api/vendors/` $\rightarrow$ Vendor Service (`http://localhost:5002`)
*   `/api/ai/` $\rightarrow$ AI Service (`http://localhost:5003`)
*   `/api/admin/` $\rightarrow$ Admin Service (`http://localhost:5004`)
*   `/api/dispatches/` & `/socket.io` $\rightarrow$ Dispatch Service (`http://localhost:5005` or `5000`)
*   `/api/payments/` $\rightarrow$ Payment Service (`http://localhost:5006` or `5004`)

---

## 🛠️ Local Development

### 1. Prerequisites
*   Node.js (v18+)

### 2. Startup Commands
From the frontend root:
```bash
# Install dependencies
npm install

# Run the development server
npm run dev
```
Open `http://localhost:3000` in your web browser.

---

## 🐳 Containerization (Standalone Mode)
This project is configured to build in Next.js `standalone` mode, which optimizes the container size by including only the minimal files required to run in production.

Build command:
```bash
docker build -t cogniregistry.azurecr.io/cogni-frontend:latest .
```
