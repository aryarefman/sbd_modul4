// ========== Inisialisasi Database ==========
use WarungPakBudi-NRP;

// ========== 1. Insert data awal ==========

// Koleksi: produk
db.produk.insertMany([
  {
    nama: "Sabun Mandi Lifebuoy Total 10",
    kategori: "Perawatan Diri",
    harga_beli: 3000,
    harga_jual: 4000,
    stok: 75,
    satuan: "pcs",
    tanggal_masuk: new Date("2025-05-01")
  },
  {
    nama: "Kopi Kapal Api Special Mix",
    kategori: "Minuman",
    harga_beli: 1000,
    harga_jual: 1500,
    stok: 200,
    satuan: "sachet",
    tanggal_masuk: new Date("2025-04-20")
  },
  {
    nama: "Beras Rojolele Super",
    kategori: "Bahan Pokok",
    harga_beli: 60000,
    harga_jual: 65000,
    stok: 30,
    satuan: "karung 5kg",
    tanggal_masuk: new Date("2025-05-10")
  },
  {
    nama: "Susu UHT Cokelat 250ml",
    kategori: "Minuman",
    harga_beli: 4500,
    harga_jual: 5500,
    stok: 8,
    satuan: "kotak",
    tanggal_masuk: new Date("2025-05-15")
  },
  {
    nama: "Deterjen Bubuk Attack",
    kategori: "Perlengkapan Rumah",
    harga_beli: 15000,
    harga_jual: 17500,
    stok: 40,
    satuan: "pack 800gr",
    tanggal_masuk: new Date("2025-04-25")
  }
]);

// Koleksi: pelanggan
db.pelanggan.insertMany([
  {
    nama: "Siti Aminah",
    nomor_telepon: "081234567890",
    alamat: "Jl. Merpati No. 1, Surabaya",
    poin_loyalitas: 50,
    tanggal_bergabung: new Date("2023-11-15")
  },
  {
    nama: "Budi Hartono",
    nomor_telepon: "087654321098",
    alamat: "Jl. Elang No. 22, Surabaya",
    poin_loyalitas: 120,
    tanggal_bergabung: new Date("2024-01-20")
  },
  {
    nama: "Retno Wulandari",
    nomor_telepon: "085550001111",
    alamat: "Jl. Kenari Indah Blok C3, Sidoarjo",
    poin_loyalitas: 75,
    tanggal_bergabung: new Date("2024-03-01")
  }
]);

// Koleksi: transaksi
db.transaksi.insertMany([
  {
    nama_pelanggan: "Siti Aminah",
    tanggal: new Date("2025-05-22T16:15:00"),
    metode_pembayaran: "Debit",
    total_belanja: 22000,
    status: "Selesai",
    items: [
      { nama_produk: "Susu UHT Cokelat 250ml", harga: 5500, jumlah: 4 }
    ]
  },
  {
    nama_pelanggan: "Siti Aminah",
    tanggal: new Date("2025-05-20T17:00:00"),
    metode_pembayaran: "Tunai",
    total_belanja: 30000,
    status: "Selesai",
    items: [
      { nama_produk: "Indomie Goreng Spesial", harga: 3000, jumlah: 5 },
      { nama_produk: "Kopi Kapal Api Special Mix", harga: 1500, jumlah: 10 }
    ]
  },
  {
    nama_pelanggan: "Budi Hartono",
    tanggal: new Date("2025-05-21T21:30:00"),
    metode_pembayaran: "QRIS",
    total_belanja: 73000,
    status: "Selesai",
    items: [
      { nama_produk: "Beras Rojolele Super", harga: 65000, jumlah: 1 },
      { nama_produk: "Sabun Mandi Lifebuoy Total 10", harga: 4000, jumlah: 2 }
    ]
  },
  {
    nama_pelanggan: "Retno Wulandari",
    tanggal: new Date("2022-12-01T23:45:00"),
    metode_pembayaran: "Tunai",
    total_belanja: 10000,
    status: "Selesai",
    items: [
      { nama_produk: "Permen X", harga: 1000, jumlah: 10 }
    ]
  },
  {
    nama_pelanggan: null,
    tanggal: new Date("2025-05-22T18:00:00"),
    metode_pembayaran: "Tunai",
    total_belanja: 6000,
    status: "Selesai",
    items: [
      { nama_produk: "Indomie Goreng Spesial", harga: 3000, jumlah: 2 }
    ]
  }
]);

// ========== 2. Produk kategori "Minuman" dengan stok < 10 ==========
db.produk.find({ kategori: "Minuman", stok: { $lt: 10 } });

// ========== 3. Tampilkan data pelanggan "Siti Aminah" ==========
db.pelanggan.find({ nama: "Siti Aminah" });

// ========== 4. Transaksi tanggal 22 Mei 2025 ==========
db.transaksi.find(
  {
    tanggal: {
      $gte: ISODate("2025-05-22T00:00:00.000Z"),
      $lt: ISODate("2025-05-23T00:00:00.000Z")
    }
  },
  {
    _id: 0,
    tanggal: 1,
    total_belanja: 1,
    metode_pembayaran: 1
  }
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