using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using DevExpress.XtraEditors.Controls;

namespace QLPK
{
    public partial class frmPhong : DevExpress.XtraEditors.XtraForm
    {
        qlpk1Entities2 c = new qlpk1Entities2();
        public frmPhong()
        {
            InitializeComponent();
        }

        private void textEdit5_EditValueChanged(object sender, EventArgs e)
        {

        }

        void show()
        {
            txtMaPhong.ReadOnly = true;
            txtTen.ReadOnly = true;
        }

        void load()
        {
            var b = c.Khoas.Select(a=>a.TenKhoa);

            ComboBoxItemCollection item = cbNhom.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {
                foreach (var i in b)
                {
                    item.Add(i);
                }
            }
            item.EndUpdate();
            show();
        }
        private void frmPhong_Load(object sender, EventArgs e)
        {
            load();
            loadKhoaG();

        }

        private void cbNhom_SelectedIndexChanged(object sender, EventArgs e)
        {
            gridPhong.BeginUpdate();
            try
            {
                string ma = cbNhom.Properties.GetDisplayText(cbNhom).ToString();
                var temp = c.Khoas.Where(a => a.TenKhoa==ma).Select(a => a.MaKhoa).FirstOrDefault();
                gridView1.Columns.Clear();
                gridPhong.DataSource = c.usp_ShowPhong(temp);

            }
            finally
            {
                gridPhong.EndUpdate();
            }
        }

    
        private void gridPhong_Click(object sender, EventArgs e)
        {

        }
        bool them = false;
        private void simpleButton1_Click(object sender, EventArgs e)
        {
            them = true;
            txtTen.ReadOnly = false;
            cbNhom.ReadOnly = false;
            txtMaPhong.ReadOnly = false;
        }

        private void gridPhong_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView1.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView1.GetRowCellValue(rowHandle, "MaPhong");
            txtMaPhong.Text = obj.ToString();
            var t = gridView1.GetRowCellValue(rowHandle, "TenPhong");
            txtTen.Text = t.ToString();

            string maphong = obj.ToString();

            gridControl1.DataSource = c.usp_ShowGiuong(maphong);


        }

        private void groupControl1_Paint(object sender, PaintEventArgs e)
        {

        }
        bool sua = false;
        private void btnSua_Click(object sender, EventArgs e)
        {
            sua = true;
            txtTen.ReadOnly = false;
            cbNhom.ReadOnly = false;
        
        }

        private void gridPhong_Click_1(object sender, EventArgs e)
        {

        }

        private void simpleButton1_Click_1(object sender, EventArgs e)
        {
            if(them==true)
            {
                string ma = txtMaPhong.Text;
                string ten = txtTen.Text;
                string khoa;
                string temp = cbNhom.Properties.GetDisplayText(cbNhom).ToString();
                khoa = c.Khoas.Where(a => a.TenKhoa == temp).Select(a => a.MaKhoa).FirstOrDefault();

                c.usp__Insert__Phong(ma, ten, khoa);
                c.SaveChanges();
                them = false;

            }


            if (sua == true)
            {
                string ma = txtMaPhong.Text;

                string ten = txtTen.Text;
                string khoa;
                string temp = cbNhom.Properties.GetDisplayText(cbNhom).ToString();
                khoa = c.Khoas.Where(a => a.TenKhoa == temp).Select(a => a.MaKhoa).FirstOrDefault();
                c.usp__Update__Phong(ma, ten, khoa);
                c.SaveChanges();
            }
        }

        private void btnReload_Click(object sender, EventArgs e)
        {
            show();
        }

        void loadKhoaG()
        {
            var b = c.Khoas.Select(a => a.TenKhoa);

            ComboBoxItemCollection item = cbKhoaGiuong.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {
                foreach (var i in b)
                {
                    item.Add(i);
                }
            }
            item.EndUpdate();
            show();
        }
        private void cbKhoaGiuong_SelectedIndexChanged(object sender, EventArgs e)
        {
            string khoa;
            string temp = cbKhoaGiuong.Properties.GetDisplayText(cbKhoaGiuong).ToString();
            khoa = c.Khoas.Where(a => a.TenKhoa == temp).Select(a => a.MaKhoa).FirstOrDefault();

            cbPhongGiuong.Properties.Items.Clear();
            var pg = c.Phongs.Where(a => a.Khoa == khoa).Select(a => a.MaPhong);
            ComboBoxItemCollection item = cbPhongGiuong.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {
                foreach (var i in pg)
                {
                    item.Add(i);
                }
            }
            item.EndUpdate();

        }
        bool themG = false;
        private void simpleButton5_Click(object sender, EventArgs e)
        {
            themG = true;
        }

        private void simpleButton2_Click(object sender, EventArgs e)
        {
            if(themG==true)
            {
                string maG = txtMG.Text;
                string phong = cbPhongGiuong.Properties.GetDisplayText(cbPhongGiuong).ToString();
                c.usp_Insert_Giuong(maG, phong);
                   c.SaveChanges();
                    themG = false;


            }
        }

        private void gridControl1_Click(object sender, EventArgs e)
        {

        }

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView2.FocusedRowHandle;

            var obj = gridView2.GetRowCellValue(rowHandle, "MaGiuong");

            frmPhieuXuatVien f = new frmPhieuXuatVien();
            f.MA = obj.ToString();
            f.Show();
        }
    }
}