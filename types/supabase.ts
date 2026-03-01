export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      notifications: {
        Row: {
          id: string
          title: string
          body: string
          package_name: string
          app_name: string | null
          timestamp: string
          device_id: string | null
          processed: boolean
          processed_at: string | null
          processed_by: string | null
          metadata: Json | null
          created_at: string
        }
        Insert: {
          id?: string
          title: string
          body: string
          package_name: string
          app_name?: string | null
          timestamp?: string
          device_id?: string | null
          processed?: boolean
          processed_at?: string | null
          processed_by?: string | null
          metadata?: Json | null
          created_at?: string
        }
        Update: {
          id?: string
          title?: string
          body?: string
          package_name?: string
          app_name?: string | null
          timestamp?: string
          device_id?: string | null
          processed?: boolean
          processed_at?: string | null
          processed_by?: string | null
          metadata?: Json | null
          created_at?: string
        }
      }
      debit_amount: {
        Row: {
          id: string
          notification_id: string | null
          amount: number
          currency: string
          extraction_status: string
          extraction_error: string | null
          regex_pattern_id: string | null
          app_name: string | null
          package_name: string | null
          title: string | null
          body: string | null
          timestamp: string
          created_at: string
        }
        Insert: {
          id?: string
          notification_id?: string | null
          amount: number
          currency?: string
          extraction_status?: string
          extraction_error?: string | null
          regex_pattern_id?: string | null
          app_name?: string | null
          package_name?: string | null
          title?: string | null
          body?: string | null
          timestamp: string
          created_at?: string
        }
        Update: {
          id?: string
          notification_id?: string | null
          amount?: number
          currency?: string
          extraction_status?: string
          extraction_error?: string | null
          regex_pattern_id?: string | null
          app_name?: string | null
          package_name?: string | null
          title?: string | null
          body?: string | null
          timestamp?: string
          created_at?: string
        }
      }
      credit_amount: {
        Row: {
          id: string
          notification_id: string | null
          amount: number
          currency: string
          extraction_status: string
          extraction_error: string | null
          regex_pattern_id: string | null
          app_name: string | null
          package_name: string | null
          title: string | null
          body: string | null
          timestamp: string
          created_at: string
        }
        Insert: {
          id?: string
          notification_id?: string | null
          amount: number
          currency?: string
          extraction_status?: string
          extraction_error?: string | null
          regex_pattern_id?: string | null
          app_name?: string | null
          package_name?: string | null
          title?: string | null
          body?: string | null
          timestamp: string
          created_at?: string
        }
        Update: {
          id?: string
          notification_id?: string | null
          amount?: number
          currency?: string
          extraction_status?: string
          extraction_error?: string | null
          regex_pattern_id?: string | null
          app_name?: string | null
          package_name?: string | null
          title?: string | null
          body?: string | null
          timestamp?: string
          created_at?: string
        }
      }
      app_regex_patterns: {
        Row: {
          id: string
          app_name: string
          package_name: string
          regex_pattern: string
          money_group_index: number
          currency: string
          enabled: boolean
          description: string | null
          example_text: string | null
          transaction_type: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          app_name: string
          package_name: string
          regex_pattern: string
          money_group_index?: number
          currency?: string
          enabled?: boolean
          description?: string | null
          example_text?: string | null
          transaction_type?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          app_name?: string
          package_name?: string
          regex_pattern?: string
          money_group_index?: number
          currency?: string
          enabled?: boolean
          description?: string | null
          example_text?: string | null
          transaction_type?: string
          created_at?: string
          updated_at?: string
        }
      }
      user_settings: {
        Row: {
          user_id: string
          allowed_ips: string[] | null
          api_key_hash: string | null
          telegram_enabled: boolean
          telegram_bot_token: string | null
          telegram_chat_id: string[] | null
          telegram_send_on_debit: boolean
          telegram_send_on_credit: boolean
          telegram_message_template: string
          speech_template: string
          preferred_voice_name: string | null
          voice_rate: number | null
          voice_pitch: number | null
          voice_volume: number | null
          member_allowed_apps: string[] | null
          created_at: string
          updated_at: string
        }
        Insert: {
          user_id: string
          allowed_ips?: string[] | null
          api_key_hash?: string | null
          telegram_enabled?: boolean
          telegram_bot_token?: string | null
          telegram_chat_id?: string[] | null
          telegram_send_on_debit?: boolean
          telegram_send_on_credit?: boolean
          telegram_message_template?: string
          speech_template?: string
          preferred_voice_name?: string | null
          voice_rate?: number | null
          voice_pitch?: number | null
          voice_volume?: number | null
          member_allowed_apps?: string[] | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          user_id?: string
          allowed_ips?: string[] | null
          api_key_hash?: string | null
          telegram_enabled?: boolean
          telegram_bot_token?: string | null
          telegram_chat_id?: string[] | null
          telegram_send_on_debit?: boolean
          telegram_send_on_credit?: boolean
          telegram_message_template?: string
          speech_template?: string
          preferred_voice_name?: string | null
          voice_rate?: number | null
          voice_pitch?: number | null
          voice_volume?: number | null
          member_allowed_apps?: string[] | null
          created_at?: string
          updated_at?: string
        }
      }
      user_roles: {
        Row: {
          id: string
          user_id: string
          role: 'admin' | 'member'
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          role: 'admin' | 'member'
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          role?: 'admin' | 'member'
          created_at?: string
          updated_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}
