#include <iostream>  // Library standar untuk input/output
#include <string>    // Library untuk menggunakan tipe data string
using namespace std; // Agar tidak perlu menuliskan std:: setiap kali menggunakan elemen dari namespace std

// Kelas abstrak untuk Pegawai Toko
class PegawaiToko {
protected:
    string nama; // Menyimpan nama pegawai
    int id;      // Menyimpan ID pegawai
public:
    // Konstruktor dengan parameter default
    PegawaiToko(string nama = "", int id = 0) : nama(nama), id(id) {}
    
    // Fungsi virtual murni (kelas ini menjadi abstrak)
    virtual void display() = 0;

    // Setter untuk nama
    void setNama(string namaBaru) { nama = namaBaru; }

    // Setter untuk id
    void setId(int idBaru) { id = idBaru; }

    // Getter untuk nama
    string getNama() { return nama; }

    // Getter untuk id
    int getId() { return id; }
};

// Kelas abstrak untuk Produk Display
class ProdukDisplay {
protected:
    string judul;   // Judul produk (buku/majalah)
    double harga;   // Harga produk
public:
    // Konstruktor dengan parameter default
    ProdukDisplay(string judul = "", double harga = 0.0) : judul(judul), harga(harga) {}

    // Fungsi virtual murni
    virtual void display() = 0;

    // Setter untuk judul
    void setJudul(string j) { judul = j; }

    // Setter untuk harga
    void setHarga(double h) { harga = h; }

    // Getter untuk judul
    string getJudul() { return judul; }

    // Getter untuk harga
    double getHarga() { return harga; }
};

// Kelas turunan Kasir dari PegawaiToko
class Kasir : public PegawaiToko {
public:
    // Konstruktor Kasir
    Kasir(string nama, int id) : PegawaiToko(nama, id) {}

    // Override fungsi display
    void display() {
        cout << "🧾 Kasir: " << nama << " | ID: " << id << endl;
    }
};

// Kelas turunan PenjagaRak dari PegawaiToko
class PenjagaRak : public PegawaiToko {
public:
    // Konstruktor PenjagaRak
    PenjagaRak(string nama, int id) : PegawaiToko(nama, id) {}

    // Override fungsi display
    void display() {
        cout << "📚 Penjaga Rak: " << nama << " | ID: " << id << endl;
    }
};

// Kelas Buku sebagai turunan ProdukDisplay
class Buku : public ProdukDisplay {
public:
    // Konstruktor Buku
    Buku(string judul, double harga) : ProdukDisplay(judul, harga) {}

    // Override fungsi display
    void display() {
        cout << "📘 Buku: " << judul << " | Harga: Rp" << harga << endl;
    }
};

// Kelas Majalah sebagai turunan ProdukDisplay
class Majalah : public ProdukDisplay {
public:
    // Konstruktor Majalah
    Majalah(string judul, double harga) : ProdukDisplay(judul, harga) {}

    // Override fungsi display
    void display() {
        cout << "📰 Majalah: " << judul << " | Harga: Rp" << harga << endl;
    }
};

// Deklarasi array pointer dan jumlah elemen untuk pegawai dan produk
const int MAX = 100;                // Maksimal jumlah data
PegawaiToko* pegawai[MAX];         // Array pointer ke objek pegawai
int jumPegawai = 0;                // Jumlah pegawai saat ini

ProdukDisplay* produk[MAX];        // Array pointer ke objek produk
int jumProduk = 0;                 // Jumlah produk saat ini

// Fungsi untuk menambah pegawai baru
void tambahPegawai() {
    int pilihan, id;
    string nama;
    cout << "1. Tambah Kasir\n2. Tambah Penjaga Rak\nPilihan: ";
    cin >> pilihan;                // Input pilihan jenis pegawai
    cout << "Masukkan ID: ";
    cin >> id;                     // Input ID pegawai
    cin.ignore();                 // Membersihkan buffer newline
    cout << "Masukkan Nama: ";
    getline(cin, nama);           // Input nama pegawai

    // Menambahkan pegawai ke array sesuai pilihan
    if (pilihan == 1)
        pegawai[jumPegawai++] = new Kasir(nama, id);
    else
        pegawai[jumPegawai++] = new PenjagaRak(nama, id);
    
    cout << "✅ Pegawai berhasil ditambahkan.\n";
}

// Fungsi untuk menampilkan seluruh pegawai
void tampilPegawai() {
    if (jumPegawai == 0) cout << "📛 Belum ada pegawai.\n";
    for (int i = 0; i < jumPegawai; i++) {
        pegawai[i]->display();   // Memanggil fungsi display polymorphic
    }
}

// Fungsi untuk mengedit data pegawai
void editPegawai() {
    int id;
    cout << "Masukkan ID Pegawai yang ingin diedit: ";
    cin >> id;                    // Input ID pegawai yang ingin diedit
    for (int i = 0; i < jumPegawai; i++) {
        if (pegawai[i]->getId() == id) {   // Jika ditemukan ID-nya
            string namaBaru;
            cin.ignore();
            cout << "Masukkan nama baru: ";
            getline(cin, namaBaru);        // Input nama baru
            pegawai[i]->setNama(namaBaru); // Update nama
            cout << "✅ Data pegawai diperbarui.\n";
            return;
        }
    }
    cout << "❌ Pegawai tidak ditemukan.\n";
}

// Fungsi untuk menghapus pegawai
void hapusPegawai() {
    int id;
    cout << "Masukkan ID Pegawai yang ingin dihapus: ";
    cin >> id;                    // Input ID yang ingin dihapus
    for (int i = 0; i < jumPegawai; i++) {
        if (pegawai[i]->getId() == id) {
            delete pegawai[i];   // Hapus memori
            for (int j = i; j < jumPegawai - 1; j++) {
                pegawai[j] = pegawai[j + 1]; // Geser data
            }
            jumPegawai--;        // Kurangi jumlah
            cout << "✅ Pegawai berhasil dihapus.\n";
            return;
        }
    }
    cout << "❌ Pegawai tidak ditemukan.\n";
}

// Fungsi untuk menambahkan produk
void tambahProduk() {
    int pilihan;
    double harga;
    string judul;
    cout << "1. Tambah Buku\n2. Tambah Majalah\nPilihan: ";
    cin >> pilihan;
    cin.ignore();
    cout << "Masukkan Judul: ";
    getline(cin, judul);
    cout << "Masukkan Harga: ";
    cin >> harga;

    // Tambah produk sesuai pilihan
    if (pilihan == 1)
        produk[jumProduk++] = new Buku(judul, harga);
    else
        produk[jumProduk++] = new Majalah(judul, harga);

    cout << "✅ Produk berhasil ditambahkan.\n";
}

// Fungsi untuk menampilkan seluruh produk
void tampilProduk() {
    if (jumProduk == 0) cout << "📭 Rak masih kosong.\n";
    for (int i = 0; i < jumProduk; i++) {
        produk[i]->display();    // Polymorphism display produk
    }
}

// Fungsi untuk mengedit produk
void editProduk() {
    string judul;
    cout << "Masukkan judul yang ingin diupdate: ";
    cin.ignore();
    getline(cin, judul);         // Input judul yang dicari
    for (int i = 0; i < jumProduk; i++) {
        if (produk[i]->getJudul() == judul) {
            string judulBaru;
            double hargaBaru;
            cout << "Judul baru: ";
            getline(cin, judulBaru);
            cout << "Harga baru: ";
            cin >> hargaBaru;
            produk[i]->setJudul(judulBaru); // Update judul
            produk[i]->setHarga(hargaBaru); // Update harga
            cout << "✅ Data produk diperbarui.\n";
            return;
        }
    }
    cout << "❌ Produk tidak ditemukan.\n";
}

// Fungsi untuk menghapus produk
void hapusProduk() {
    string judul;
    cout << "Masukkan judul produk yang rusak: ";
    cin.ignore();
    getline(cin, judul);         // Input judul yang ingin dihapus
    for (int i = 0; i < jumProduk; i++) {
        if (produk[i]->getJudul() == judul) {
            delete produk[i];    // Hapus memori
            for (int j = i; j < jumProduk - 1; j++) {
                produk[j] = produk[j + 1]; // Geser data
            }
            jumProduk--;         // Kurangi jumlah
            cout << "✅ Produk berhasil dihapus.\n";
            return;
        }
    }
    cout << "❌ Produk tidak ditemukan.\n";
}

// Fungsi menu utama
void menu() {
    int pilihan;
    do {
        // Menampilkan pilihan menu
        cout << "\n📚 Menu Toko Buku Nara:\n";
        cout << "1. Tambah Pegawai\n2. Lihat Pegawai\n3. Edit Pegawai\n4. Hapus Pegawai\n";
        cout << "5. Tambah Produk\n6. Lihat Produk\n7. Edit Produk\n8. Hapus Produk\n";
        cout << "0. Keluar\n▶ Pilih: ";
        cin >> pilihan;   // Input pilihan

        // Menjalankan pilihan yang sesuai
        switch (pilihan) {
            case 1: tambahPegawai(); break;
            case 2: tampilPegawai(); break;
            case 3: editPegawai(); break;
            case 4: hapusPegawai(); break;
            case 5: tambahProduk(); break;
            case 6: tampilProduk(); break;
            case 7: editProduk(); break;
            case 8: hapusProduk(); break;
            case 0: cout << "👋 Keluar dari program...\n"; break;
            default: cout << "❗ Pilihan tidak valid!\n"; break;
        }
    } while (pilihan != 0); // Ulangi sampai user pilih keluar
}

// Fungsi utama program
int main() {
    cout << "📖 Selamat datang di Sistem Toko Buku Arya!\n";
    menu();    // Panggil menu utama

    // Hapus semua memori yang telah dialokasikan
    for (int i = 0; i < jumPegawai; i++) delete pegawai[i];
    for (int i = 0; i < jumProduk; i++) delete produk[i];
    return 0;
}