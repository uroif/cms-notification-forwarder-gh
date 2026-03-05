# CMS Notification Forwarder
![License: Non-Commercial](https://img.shields.io/badge/License-Non--Commercial-orange.svg)
![Status: Public](https://img.shields.io/badge/Status-Source--Available-blue.svg)

Realtime notification management system for Android notification forwarding application. Built with Next.js, Supabase, and TypeScript.

## License & Usage Terms

This project is **Source-Available**, not Open Source in the traditional OSI sense. It is provided for **personal and educational use only**.

### 🚫 Commercial Use Prohibited
The source code and any resulting binaries are strictly prohibited from being used for commercial purposes. This includes:
* **Selling or Renting:** You cannot sell this software or any part of its code.
* **SaaS/Hosting:** You cannot host this software as a paid service for others.
* **Corporate Use:** You cannot use this tool within a business environment for commercial gain.

### ✅ Permitted Use
* **Personal Projects:** Feel free to use this for your own personal experiments.
* **Learning & Research:** You are encouraged to study the code and modify it for educational purposes.
* **Contributions:** Contributions via Pull Requests are welcome, provided they adhere to the same non-commercial terms.

*For commercial licensing inquiries or if you are unsure whether your use case qualifies as "commercial," please reach out at: **contact@trungduy.com***.

## 🚀 Features

- ✅ **Realtime Updates** - WebSocket subscriptions for instant notification display
- ✅ **Secure Authentication** - Supabase Auth with email/password
- ✅ **Row Level Security** - Database-level security policies
- ✅ **Browser Notifications** - Native browser notification support
- ✅ **Telegram Auto-Send** - Automatic Telegram notifications even when CMS is closed
- ✅ **Transaction Categorization** - Auto-categorize debit/credit transactions

## 📋 Prerequisites

- Node.js >= 18.0.0
- npm or yarn
- Supabase account (https://supabase.com)
- Vercel account for deployment

## 🛠️ Installation

1. Clone the repository
2. Install environment
3. Setup Supabase Database
4. Create Auth User

## 🚀 Development

Run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## 📱 Android App Integration

To integrate with the Notification Forwarder app, you must update the Supabase configuration in the Android app:

## 🔒 Security

- All routes protected by Supabase Auth middleware
- Row Level Security (RLS) enabled on database
- HTTPS enforced (automatic with Vercel)
- Security headers configured in `next.config.js`
- Environment variables never committed to Git

## 🛠️ Tech Stack

- **Framework**: Next.js (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **Auth**: Supabase Auth
- **Realtime**: Supabase Realtime (WebSocket)
- **Deployment**: Vercel
