# CMS Notification Forwarder

Realtime notification management system for Android notification forwarding application. Built with Next.js 14, Supabase, and TypeScript.

## 🚀 Features

- ✅ **Realtime Updates** - WebSocket subscriptions for instant notification display
- ✅ **Secure Authentication** - Supabase Auth with email/password
- ✅ **Row Level Security** - Database-level security policies
- ✅ **Responsive Design** - Works on desktop and mobile
- ✅ **Dark Mode Support** - Automatic dark/light theme
- ✅ **Browser Notifications** - Native browser notification support
- ✅ **Filter & Search** - Filter processed/unprocessed notifications
- ✅ **Mark as Processed** - Track notification handling status
- ✅ **Telegram Auto-Send** - Automatic Telegram notifications even when CMS is closed
- ✅ **Transaction Categorization** - Auto-categorize debit/credit transactions

## 📋 Prerequisites

- Node.js >= 18.0.0
- npm or yarn
- Supabase account (https://supabase.com)
- Vercel account for deployment (optional)

## 🛠️ Installation

### 1. Clone the repository

\`\`\`bash
git clone <repository-url>
cd cms-notification-forwarder
\`\`\`

### 2. Install dependencies

\`\`\`bash
npm install
\`\`\`

### 3. Setup environment variables

Copy `.env.example` to `.env.local`:

\`\`\`bash
cp .env.example .env.local
\`\`\`

Edit `.env.local` with your Supabase credentials:

\`\`\`env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
\`\`\`

### 4. Setup Supabase Database

Run the following SQL in your Supabase SQL Editor:

\`\`\`sql
-- Create notifications table
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    package_name TEXT NOT NULL,
    app_name TEXT,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    device_id TEXT,
    processed BOOLEAN DEFAULT FALSE,
    processed_at TIMESTAMPTZ,
    processed_by UUID REFERENCES auth.users(id),
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_notifications_timestamp ON notifications(timestamp DESC);
CREATE INDEX idx_notifications_processed ON notifications(processed) WHERE processed = FALSE;

-- Enable Row Level Security
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Authenticated users can view notifications"
ON notifications FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Service can insert notifications"
ON notifications FOR INSERT
TO authenticated, anon
WITH CHECK (true);

CREATE POLICY "Authenticated users can update notifications"
ON notifications FOR UPDATE
TO authenticated
USING (true);

-- Enable Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE notifications;
\`\`\`

### 5. Create Auth User

In Supabase Dashboard:
1. Go to Authentication → Users
2. Click "Add user" → "Create new user"
3. Enter your email and password
4. Check "Email confirmed"

## 🚀 Development

Run the development server:

\`\`\`bash
npm run dev
\`\`\`

Open [http://localhost:3000](http://localhost:3000) in your browser.

## 📦 Build

Build for production:

\`\`\`bash
npm run build
\`\`\`

Start production server:

\`\`\`bash
npm start
\`\`\`

## 🌐 Deployment

### Deploy to Vercel

1. Install Vercel CLI:
\`\`\`bash
npm i -g vercel
\`\`\`

2. Login to Vercel:
\`\`\`bash
vercel login
\`\`\`

3. Deploy:
\`\`\`bash
vercel --prod
\`\`\`

4. Set environment variables in Vercel Dashboard:
   - Go to Project Settings → Environment Variables
   - Add `NEXT_PUBLIC_SUPABASE_URL`
   - Add `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - Add `SUPABASE_SERVICE_ROLE_KEY`

### Deploy via Git

1. Push code to GitHub
2. Import repository in Vercel Dashboard
3. Configure environment variables
4. Deploy

## 📱 Android App Integration

To integrate with the Android notification forwarder app, update the Supabase configuration in the Android app:

\`\`\`kotlin
// SupabaseConfig.kt
object SupabaseConfig {
    const val SUPABASE_URL = "YOUR_SUPABASE_URL"
    const val SUPABASE_KEY = "YOUR_SUPABASE_ANON_KEY"
    
    val client = createSupabaseClient(
        supabaseUrl = SUPABASE_URL,
        supabaseKey = SUPABASE_KEY
    ) {
        install(Postgrest)
    }
}
\`\`\`

## 🔒 Security

- All routes protected by Supabase Auth middleware
- Row Level Security (RLS) enabled on database
- HTTPS enforced (automatic with Vercel)
- Security headers configured in `next.config.js`
- Environment variables never committed to Git

## 📁 Project Structure

\`\`\`
cms-notification-forwarder/
├── app/
│   ├── dashboard/
│   │   └── page.tsx          # Main dashboard
│   ├── login/
│   │   └── page.tsx          # Login page
│   ├── globals.css           # Global styles
│   ├── layout.tsx            # Root layout
│   └── page.tsx              # Home (redirects to dashboard)
├── components/
│   └── NotificationList.tsx  # Realtime notification component
├── lib/
│   └── supabase/
│       ├── client.ts         # Client-side Supabase client
│       └── server.ts         # Server-side Supabase client
├── types/
│   └── supabase.ts           # TypeScript types
├── docs/                     # Documentation
├── middleware.ts             # Auth middleware
├── next.config.js            # Next.js configuration
├── tailwind.config.ts        # Tailwind CSS config
└── package.json
\`\`\`

## 🛠️ Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **Auth**: Supabase Auth
- **Realtime**: Supabase Realtime (WebSocket)
- **Deployment**: Vercel

## 📖 Documentation

See the `docs/` directory for detailed documentation:

- [`CMS_REALTIME_IMPLEMENTATION_PLAN.md`](docs/CMS_REALTIME_IMPLEMENTATION_PLAN.md) - Full architecture & implementation details
- [`QUICK_START_GUIDE.md`](docs/QUICK_START_GUIDE.md) - 30-minute quick start guide
- [`ENVIRONMENT_SETUP_CHECKLIST.md`](docs/ENVIRONMENT_SETUP_CHECKLIST.md) - Complete setup checklist
- [`TELEGRAM_AUTO_SEND_GUIDE.md`](TELEGRAM_AUTO_SEND_GUIDE.md) - Telegram automatic notification setup

## 🐛 Troubleshooting

### Realtime not working
- Verify Realtime is enabled in Supabase Dashboard (Database → Replication)
- Check RLS policies allow SELECT
- Ensure WebSocket connection is not blocked

### Authentication fails
- Verify user exists in Supabase Auth
- Check email is confirmed
- Clear browser cache and cookies

### TypeScript errors
- Run `npm install` to install all dependencies
- Restart TypeScript server in VS Code

## 📄 License

MIT License

## 👥 Contributors

- Your Name

## 🆘 Support

For issues and questions:
- Check the [documentation](docs/)
- Open an issue on GitHub
- Contact: your-email@example.com

---

**Version**: 1.0.0  
**Last Updated**: January 4, 2026
