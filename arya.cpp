#include <iostream>   // Untuk input/output standar seperti cout dan cin
#include <string>     // Untuk menggunakan tipe data string
using namespace std;  // Agar tidak perlu menulis std:: setiap kali

// Kelas abstrak untuk pegawai toko
class PegawaiToko {
protected:
    string nama; // Menyimpan nama pegawai
    int id;      // Menyimpan ID pegawai
public:
    PegawaiToko(string nama = "", int id = 0) : nama(nama), id(id) {} // Konstruktor dengan parameter default
    virtual ~PegawaiToko() {}                 // Destructor virtual agar bisa dihapus secara polimorfik
    virtual void display() = 0;               // Method virtual murni, menjadikan kelas ini abstrak
    void setNama(string namaBaru) { nama = namaBaru; } // Mengatur nama pegawai
    void setId(int idBaru) { id = idBaru; }            // Mengatur ID pegawai
    string getNama() { return nama; }                  // Mengambil nama pegawai
    int getId() { return id; }                         // Mengambil ID pegawai
};

// Kelas abstrak untuk produk
class ProdukDisplay {
protected:
    string judul;   // Menyimpan judul produk
    double harga;   // Menyimpan harga produk
public:
    ProdukDisplay(string judul = "", double harga = 0.0) : judul(judul), harga(harga) {} // Konstruktor
    virtual ~ProdukDisplay() {}       // Destructor virtual
    virtual void display() = 0;       // Method virtual murni
    void setJudul(string j) { judul = j; }      // Mengatur judul produk
    void setHarga(double h) { harga = h; }      // Mengatur harga produk
    string getJudul() { return judul; }         // Mengambil judul produk
    double getHarga() { return harga; }         // Mengambil harga produk
};

// Kelas abstrak untuk data gudang
class Gudang {
protected:
    string nama;  // Nama manajer/distributor
    int id;       // ID gudang
public:
    Gudang(string nama = "", int id = 0) : nama(nama), id(id) {} // Konstruktor
    virtual ~Gudang() {}                  // Destructor virtual
    virtual void display() = 0;           // Method virtual murni
    void setNama(string namaBaru) { nama = namaBaru; } // Setter nama
    void setId(int idBaru) { id = idBaru; }            // Setter ID
    string getNama() { return nama; }                  // Getter nama
    int getId() { return id; }                         // Getter ID
};

// Kelas turunan dari PegawaiToko: Kasir
class Kasir : public PegawaiToko {
public:
    Kasir(string nama, int id) : PegawaiToko(nama, id) {} // Konstruktor
    ~Kasir() {}    // Destructor
    void display() { // Implementasi display
        cout << "\U0001F9FE Kasir: " << nama << " | ID: " << id << endl;
    }
};

// Kelas turunan dari PegawaiToko: Penjaga Rak
class PenjagaRak : public PegawaiToko {
public:
    PenjagaRak(string nama, int id) : PegawaiToko(nama, id) {}
    ~PenjagaRak() {}
    void display() {
        cout << "\U0001F4DA Penjaga Rak: " << nama << " | ID: " << id << endl;
    }
};

// Kelas turunan dari ProdukDisplay: Buku
class Buku : public ProdukDisplay {
public:
    Buku(string judul, double harga) : ProdukDisplay(judul, harga) {}
    ~Buku() {}
    void display() {
        cout << "\U0001F4D8 Buku: " << judul << " | Harga: Rp" << harga << endl;
    }
};

// Kelas turunan dari ProdukDisplay: Majalah
class Majalah : public ProdukDisplay {
public:
    Majalah(string judul, double harga) : ProdukDisplay(judul, harga) {}
    ~Majalah() {}
    void display() {
        cout << "\U0001F4F0 Majalah: " << judul << " | Harga: Rp" << harga << endl;
    }
};

// Kelas turunan dari Gudang: Manajer Gudang
class ManajerGudang : public Gudang {
public:
    ManajerGudang(string nama, int id) : Gudang(nama, id) {}
    ~ManajerGudang() {}
    void display() {
        cout << "\U0001F4E6 Manajer Gudang: " << nama << " | ID: " << id << endl;
    }
};

// Kelas turunan dari Gudang: Distributor
class Distributor : public Gudang {
public:
    Distributor(string nama, int id) : Gudang(nama, id) {}
    ~Distributor() {}
    void display() {
        cout << "\U0001F69A Distributor: " << nama << " | ID: " << id << endl;
    }
};

// Global array pointer untuk menyimpan objek-objek
const int MAX = 100;                  // Maksimum data
PegawaiToko* pegawai[MAX];           // Array pegawai
int jumPegawai = 0;                  // Jumlah pegawai

ProdukDisplay* produk[MAX];          // Array produk
int jumProduk = 0;                   // Jumlah produk

Gudang* gudang[MAX];                 // Array gudang
int jumGudang = 0;                   // Jumlah gudang

// Fungsi menambah data pegawai
void tambahPegawai() {
    int pilihan, id;
    string nama;
    cout << "1. Tambah Kasir\n2. Tambah Penjaga Rak\nPilihan: ";
    cin >> pilihan;
    cout << "Masukkan ID: "; cin >> id;
    cin.ignore(); // Membersihkan newline
    cout << "Masukkan Nama: "; getline(cin, nama);
    if (pilihan == 1)
        pegawai[jumPegawai++] = new Kasir(nama, id);
    else
        pegawai[jumPegawai++] = new PenjagaRak(nama, id);
    cout << "\u2705 Pegawai berhasil ditambahkan.\n";
}

// Menampilkan semua pegawai
void tampilPegawai() {
    if (jumPegawai == 0) cout << "\U0001F6AB Belum ada pegawai.\n";
    for (int i = 0; i < jumPegawai; i++) pegawai[i]->display();
}

// Mengedit data pegawai berdasarkan ID
void editPegawai() {
    int id;
    cout << "Masukkan ID Pegawai yang ingin diedit: "; cin >> id;
    for (int i = 0; i < jumPegawai; i++) {
        if (pegawai[i]->getId() == id) {
            string namaBaru;
            cin.ignore();
            cout << "Masukkan nama baru: "; getline(cin, namaBaru);
            pegawai[i]->setNama(namaBaru);
            cout << "\u2705 Data pegawai diperbarui.\n";
            return;
        }
    }
    cout << "\u274C Pegawai tidak ditemukan.\n";
}

// Menghapus data pegawai berdasarkan ID
void hapusPegawai() {
    int id;
    cout << "Masukkan ID Pegawai yang ingin dihapus: "; cin >> id;
    for (int i = 0; i < jumPegawai; i++) {
        if (pegawai[i]->getId() == id) {
            delete pegawai[i]; // Dealokasi memori
            for (int j = i; j < jumPegawai - 1; j++) pegawai[j] = pegawai[j + 1]; // Geser data
            jumPegawai--;
            cout << "\u2705 Pegawai berhasil dihapus.\n";
            return;
        }
    }
    cout << "\u274C Pegawai tidak ditemukan.\n";
}

// Fungsi tambah produk buku atau majalah
void tambahProduk() {
    int pilihan;
    double harga;
    string judul;
    cout << "1. Tambah Buku\n2. Tambah Majalah\nPilihan: "; cin >> pilihan;
    cin.ignore();
    cout << "Masukkan Judul: "; getline(cin, judul);
    cout << "Masukkan Harga: "; cin >> harga;
    if (pilihan == 1)
        produk[jumProduk++] = new Buku(judul, harga);
    else
        produk[jumProduk++] = new Majalah(judul, harga);
    cout << "\u2705 Produk berhasil ditambahkan.\n";
}

// Menampilkan semua produk
void tampilProduk() {
    if (jumProduk == 0) cout << "\U0001F4E5 Rak masih kosong.\n";
    for (int i = 0; i < jumProduk; i++) produk[i]->display();
}

// Mengedit produk berdasarkan judul
void editProduk() {
    string judul;
    cout << "Masukkan judul yang ingin diupdate: ";
    cin.ignore(); getline(cin, judul);
    for (int i = 0; i < jumProduk; i++) {
        if (produk[i]->getJudul() == judul) {
            string judulBaru;
            double hargaBaru;
            cout << "Judul baru: "; getline(cin, judulBaru);
            cout << "Harga baru: "; cin >> hargaBaru;
            produk[i]->setJudul(judulBaru);
            produk[i]->setHarga(hargaBaru);
            cout << "\u2705 Data produk diperbarui.\n";
            return;
        }
    }
    cout << "\u274C Produk tidak ditemukan.\n";
}

// Menghapus produk berdasarkan judul
void hapusProduk() {
    string judul;
    cout << "Masukkan judul produk yang rusak: ";
    cin.ignore(); getline(cin, judul);
    for (int i = 0; i < jumProduk; i++) {
        if (produk[i]->getJudul() == judul) {
            delete produk[i];
            for (int j = i; j < jumProduk - 1; j++) produk[j] = produk[j + 1];
            jumProduk--;
            cout << "\u2705 Produk berhasil dihapus.\n";
            return;
        }
    }
    cout << "\u274C Produk tidak ditemukan.\n";
}

// Menambah data gudang (manajer/distributor)
void tambahGudang() {
    int pilihan, id;
    string nama;
    cout << "1. Tambah Manajer Gudang\n2. Tambah Distributor\nPilihan: "; cin >> pilihan;
    cout << "Masukkan ID: "; cin >> id;
    cin.ignore();
    cout << "Masukkan Nama: "; getline(cin, nama);
    if (pilihan == 1)
        gudang[jumGudang++] = new ManajerGudang(nama, id);
    else
        gudang[jumGudang++] = new Distributor(nama, id);
    cout << "\u2705 Data gudang berhasil ditambahkan.\n";
}

// Menampilkan semua data gudang
void tampilGudang() {
    if (jumGudang == 0) cout << "\U0001F6CB Belum ada data gudang.\n";
    for (int i = 0; i < jumGudang; i++) gudang[i]->display();
}

// Edit gudang berdasarkan ID
void editGudang() {
    int id;
    cout << "Masukkan ID Gudang yang ingin diedit: "; cin >> id;
    for (int i = 0; i < jumGudang; i++) {
        if (gudang[i]->getId() == id) {
            string namaBaru;
            cin.ignore();
            cout << "Masukkan nama baru: "; getline(cin, namaBaru);
            gudang[i]->setNama(namaBaru);
            cout << "\u2705 Data gudang diperbarui.\n";
            return;
        }
    }
    cout << "\u274C Gudang tidak ditemukan.\n";
}

// Hapus data gudang
void hapusGudang() {
    int id;
    cout << "Masukkan ID Gudang yang ingin dihapus: "; cin >> id;
    for (int i = 0; i < jumGudang; i++) {
        if (gudang[i]->getId() == id) {
            delete gudang[i];
            for (int j = i; j < jumGudang - 1; j++) gudang[j] = gudang[j + 1];
            jumGudang--;
            cout << "\u2705 Gudang berhasil dihapus.\n";
            return;
        }
    }
    cout << "\u274C Gudang tidak ditemukan.\n";
}

// Menu utama
void menu() {
    int pilihan;
    do {
        // Tampilkan menu interaktif
        cout << "\n\U0001F4DA Menu Toko Buku Arya:\n";
        cout << "1. Tambah Pegawai\n2. Lihat Pegawai\n3. Edit Pegawai\n4. Hapus Pegawai\n";
        cout << "5. Tambah Produk\n6. Lihat Produk\n7. Edit Produk\n8. Hapus Produk\n";
        cout << "9. Tambah Gudang\n10. Lihat Gudang\n11. Edit Gudang\n12. Hapus Gudang\n";
        cout << "0. Keluar\n▶ Pilih: ";
        cin >> pilihan;
        switch (pilihan) {
            case 1: tambahPegawai(); break;
            case 2: tampilPegawai(); break;
            case 3: editPegawai(); break;
            case 4: hapusPegawai(); break;
            case 5: tambahProduk(); break;
            case 6: tampilProduk(); break;
            case 7: editProduk(); break;
            case 8: hapusProduk(); break;
            case 9: tambahGudang(); break;
            case 10: tampilGudang(); break;
            case 11: editGudang(); break;
            case 12: hapusGudang(); break;
            case 0: cout << "\U0001F44B Keluar dari program...\n"; break;
            default: cout << "\u2757 Pilihan tidak valid!\n"; break;
        }
    } while (pilihan != 0);
}

// Fungsi utama (entry point)
int main() {
    cout << "\U0001F4D6 Selamat datang di Sistem Toko Buku Arya!\n"; // Welcome message
    menu(); // Tampilkan menu utama
    // Dealokasi semua memori yang digunakan
    for (int i = 0; i < jumPegawai; i++) delete pegawai[i];
    for (int i = 0; i < jumProduk; i++) delete produk[i];
    for (int i = 0; i < jumGudang; i++) delete gudang[i];
    return 0;
}