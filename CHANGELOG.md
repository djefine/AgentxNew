# Changelog

## v0.2.0 — 2026-10-22

Disamakan dengan versi terbaru DezXBT/AgentX (7 commit sesudah v0.1.0), ditambah perbaikan proxy milik repo ini.

- **Tanda tangan transaksi (x-client-transaction-id) diambil dengan cookie akun.** Ini cara DezXBT (19b7825): cookie hanya dikirim ke x.com, provider tetap dipakai bersama, ada peringatan kalau sebuah *read* terkirim tanpa tanda tangan, dan `AGENTX_DUMP_RAW` untuk melihat jawaban mentah. Menggantikan perbaikan lama di repo ini (provider per akun yang mengirim cookie ke semua host).
- **Error di dalam body jawaban X sekarang dilaporkan** (posting/tulis yang ditolak tidak lagi terlihat sukses); link `/status/` diterima; daftar kosong jadi `[]`.
- **Akun yang tidak dikenal** dilaporkan sebagai `account_error`.
- **Pin/unpin** yang berhasil tidak lagi dilaporkan sebagai error.
- **Model tweet** sekarang membawa info balasan (reply linkage) dan pilihan polling.
- **`download --out`** bisa berupa folder, bukan hanya nama file.
- Tetap dari repo ini: `agentx-proxy.sh` (menyalin `$https_proxy` yang berganti-ganti ke setiap akun sebelum perintah jalan) dan provider/FxTwitter yang memakai proxy dari environment.

## v0.1.0

Salinan awal DezXBT/AgentX (MIT). Sesudah tag ini (tanpa versi baru) repo ini menambah satu perbaikan: posting/avatar/bio jalan di belakang proxy yang berganti-ganti (7661acc).
