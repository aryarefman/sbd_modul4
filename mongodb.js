// ========== Inisialisasi Database ==========
use WarungPakBudi-NRP;

// ========== 1. Insert data awal ==========

// Koleksi: produk
db.produk.insertMany([
  { nama: "Teh Botol", kategori: "Minuman", stok: 8, harga_beli: 3000 },
  { nama: "Air Mineral", kategori: "Minuman", stok: 25, harga_beli: 2000 },
  { nama: "Susu Coklat", kategori: "Minuman", stok: 6, harga_beli: 4500 },
  { nama: "Indomie Goreng Spesial", kategori: "Makanan", stok: 30, harga_beli: 2500 },
  { nama: "Permen X", kategori: "Snack", stok: 15, harga_beli: 500 }
]);

// Koleksi: pelanggan
db.pelanggan.insertMany([
  { nama: "Siti Aminah", alamat: "Jl. Melati No. 1, Surabaya", poin: 30, tanggal_bergabung: new Date("2023-05-10") },
  { nama: "Joko Santoso", alamat: "Jl. Mawar No. 10, Sidoarjo", poin: 15, tanggal_bergabung: new Date("2022-11-01") },
  { nama: "Pak Budi Hartono", alamat: "Jl. Kenari No. 8, Gresik", poin: 45, tanggal_bergabung: new Date("2021-07-12") }
]);

// Koleksi: transaksi
db.transaksi.insertMany([
  {
    tanggal: new Date("2025-05-22"),
    total_belanja: 37000,
    metode_pembayaran: "QRIS",
    nama_pelanggan: "Siti Aminah"
  },
  {
    tanggal: new Date("2025-05-22"),
    total_belanja: 28000,
    metode_pembayaran: "Tunai",
    nama_pelanggan: "Joko Santoso"
  },
  {
    tanggal: new Date("2022-12-15"),
    total_belanja: 15000,
    metode_pembayaran: "Tunai",
    nama_pelanggan: "Pak Budi Hartono"
  },
  {
    tanggal: new Date("2021-10-02"),
    total_belanja: 22000,
    metode_pembayaran: "Tunai",
    nama_pelanggan: "Joko Santoso"
  },
  {
    tanggal: new Date("2025-05-20"),
    total_belanja: 18000,
    metode_pembayaran: "Transfer Bank",
    nama_pelanggan: "Siti Aminah"
  }
]);

// ========== 2. Produk kategori "Minuman" dengan stok < 10 ==========
db.produk.find({ kategori: "Minuman", stok: { $lt: 10 } });

// ========== 3. Tampilkan data pelanggan "Siti Aminah" ==========
db.pelanggan.find({ nama: "Siti Aminah" });

// ========== 4. Transaksi tanggal 22 Mei 2025 ==========
db.transaksi.find(
  { tanggal: ISODate("2025-05-22") },
  { _id: 0, tanggal: 1, total_belanja: 1, metode_pembayaran: 1 }
);

// ========== 5. Daftar unik kategori produk ==========
db.produk.distinct("kategori");

// ========== 6. Total jumlah pelanggan ==========
db.pelanggan.countDocuments({});

// ========== 7. Update stok dan harga beli Indomie Goreng Spesial ==========
db.produk.updateOne(
  { nama: "Indomie Goreng Spesial" },
  { $set: { harga_beli: 2800 }, $inc: { stok: 50 } }
);

// ========== 8. Tambah 10 poin untuk pelanggan sebelum 1 Jan 2024 ==========
db.pelanggan.updateMany(
  { tanggal_bergabung: { $lt: ISODate("2024-01-01") } },
  { $inc: { poin: 10 } }
);

// ========== 9. Ubah alamat Pak Budi Hartono ==========
db.pelanggan.updateOne(
  { nama: "Pak Budi Hartono" },
  { $set: { alamat: "Jl. Cendrawasih No. 5, Gresik" } }
);

// ========== 10. Hapus produk "Permen X" ==========
db.produk.deleteOne({ nama: "Permen X" });

// ========== 11. Hapus transaksi tunai sebelum tahun 2023 ==========
db.transaksi.deleteMany({
  metode_pembayaran: "Tunai",
  tanggal: { $lt: ISODate("2023-01-01") }
});

// ========== 12. Metode pembayaran dengan pendapatan tertinggi ==========
db.transaksi.aggregate([
  {
    $group: {
      _id: "$metode_pembayaran",
      total_pendapatan: { $sum: "$total_belanja" }
    }
  },
  { $sort: { total_pendapatan: -1 } }
]);

// ========== 13. Tiga pelanggan dengan transaksi terbanyak ==========
db.transaksi.aggregate([
  {
    $group: {
      _id: "$nama_pelanggan",
      total_transaksi: { $sum: 1 }
    }
  },
  { $sort: { total_transaksi: -1 } },
  { $limit: 3 }
]);

// ========== 14. Produk dengan stok < 5 unit ==========
db.produk.find(
  { stok: { $lt: 5 } },
  { _id: 0, nama: 1, kategori: 1, stok: 1 }
).sort({ stok: 1 });