# 班表簿｜請假統計

手機優先的請假統計 Web App 初版。直接開啟 `index.html` 即可使用，目前使用瀏覽器 `localStorage` 儲存資料，方便先驗證操作流程。

## 已完成

- 五個功能分頁：請假統計、人員與假別、目前假單、歷史假單、異動紀錄
- 多人請假、修改假單、半天與自訂時間
- 假別可選常用項目或自行輸入
- 重疊假單允許儲存，並保留警告規則的接入位置
- 軟刪除與異動紀錄
- 管理 PIN：`421685`
- 目前假單與歷史假單 CSV 匯出
- 異動紀錄 TSV 匯出

## Supabase 接線方向

後續建立 Supabase 專案後，可先執行 `supabase-schema.sql` 建立 `departments`、`employees`、`leave_types`、`leave_records`、`audit_logs` 資料表，再將 `app.js` 的 `loadData`、`save` 替換成 Supabase 查詢。正式版本需將管理 PIN 改為 Supabase Edge Function 或其他伺服器端驗證。