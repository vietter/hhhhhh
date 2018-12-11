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
using System.Data.Entity;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraEditors.Mask;
using System.Collections;
namespace QLPK
{
    public partial class frmPhieuNhapVien : DevExpress.XtraEditors.XtraForm
    {
        qlpk1Entities2 c = new qlpk1Entities2();
       
        private string name;
        public string NAME
        {
            set
            {
                name = value;
            }
        }
        public frmPhieuNhapVien()
        {
            InitializeComponent();
        }

        void show()
        {
            txtMaPhieu.ReadOnly = true;
            txtKhoa.ReadOnly = true;
            dateNgayLap.ResetText();
            dateNgayNV.ResetText();
            txtNV.ResetText();

            txtKhoa.ResetText();
            var q = c.v_NoiTru;
            gridBNNT.DataSource = q.ToList();
            txtBN.ResetText();
        }


        private void frmPhieuNhapVien_Load(object sender, EventArgs e)
        {
            show();
            txtNV.ReadOnly = true;
            txtNV.Text = name;

        }



        private void barButtonItem2_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            using (DbContextTransaction trans = c.Database.BeginTransaction())
            {
                try
                {
                    String nl = Convert.ToDateTime(dateNgayLap.Text).ToString("yyyy-MM-dd");
                    DateTime ngaylap = Convert.ToDateTime(nl);



                    String nv = Convert.ToDateTime(dateNgayNV.Text).ToString("yyyy-MM-dd");
                    DateTime ngaynv = Convert.ToDateTime(nv);

                    String benhnhan = txtBN.Text;
                    String ma = txtMaPhieu.Text;
                    string giuog = comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1);


                    String khoa1 = txtKhoa.Text;

                    String myString = khoa1.Replace(System.Environment.NewLine, "");
                    

                    String nhanvien = txtNV.Text;
                    if (ngaylap > ngaynv)
                        MessageBox.Show("Ngày nhập viện trước ngày lập");

                    c.usp__Insert__PNV(ma, ngaynv, ngaylap, myString, benhnhan, nhanvien, giuog);
                    c.SaveChanges();
                    trans.Commit();
                    MessageBox.Show("Thêm phiếu thành công");
                }
                catch
                {
                    trans.Rollback();
                }
            }

        }

        private void barButtonItem8_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }



        private void cbBenhNhan_TextChanged(object sender, EventArgs e)
        {

        }

        private void barButtonItem3_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            show();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {

            
                String ns = Convert.ToDateTime(dtS.Text).ToString("yyyy-MM-dd");
            DateTime ngay1 = Convert.ToDateTime(ns);



            String ne = Convert.ToDateTime(dtE.Text).ToString("yyyy-MM-dd");
            DateTime ngay2 = Convert.ToDateTime(ne);

            //  var query = c.PhieuNhapViens.Where(a => a.TgNV <= ngay2 && a.TgNV >= ngay1).Select(a => new { a.MaPNV, a.BenhNhan, a.Khoa});

            var query = from tt in c.PhieuNhapViens
                        join ttt in c.BenhNhans on tt.MaPNV equals ttt.MaBenhNhan
                        where tt.TgNV <= ngay2 && tt.TgNV >= ngay1
                        select new
                        {
                            ttt.TenBN,
                            ttt.HoBN,
                            ttt.MaBenhNhan

                        };

            gridDSTK.DataSource = query.ToList();
        }

    




        private void gridBNNT_Click(object sender, EventArgs e)
        {

        }

        private void gridBNNT_DoubleClick_1(object sender, EventArgs e)
        {
            var rowHandle = gridView1.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView1.GetRowCellValue(rowHandle, "MaBenhNhan");
            txtBN.Text = obj.ToString();
        }

        private void txtBN_TextChanged(object sender, EventArgs e)
        {
            String ma = txtBN.Text;

            String khoa = c.BenhNhans.Where(a => a.MaBenhNhan.Equals(ma)).Select(a => a.Khoa).FirstOrDefault();

            txtKhoa.Text = khoa;
            txtMaPhieu.Text = ma;
        }

        private void txtKhoa_TextChanged(object sender, EventArgs e)
        {
            string khoa = txtKhoa.Text;


            ComboBoxItemCollection item = comboBoxEdit1.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {

                var phong = (from i in c.Phongs
                            where i.Khoa == khoa
                            select i.MaPhong).FirstOrDefault();
                foreach (var i in c.Giuongs.Where(a=>a.Phong==phong &&a.Book!=true).Select(a=>a.MaGiuong))
                {
                    item.Add(i);
                }

            }
            item.EndUpdate();
        }
    }
}