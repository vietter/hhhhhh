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

namespace QLPK
{
    public partial class frmBenhAn : DevExpress.XtraEditors.XtraForm
    {


        private string name;
        public string NAME
        {
            set
            {
                name = value;
            }
        }

        qlpk1Entities2 c = new qlpk1Entities2();
        public frmBenhAn()
        {
            InitializeComponent();
        }


        void show()
        {
            dateNgayLap.ReadOnly = true;
            memoHuongDT.ReadOnly = true;
            memoKQ.ReadOnly = true;
            memoNoiDung.ReadOnly = true;
            memoTinhTrang.ReadOnly = true;
            txtMaPhieu.ReadOnly = true;
            txtBN.ReadOnly = true;
        }
        void show1()
        {
           // dateNgayLap.ReadOnly = false;
            memoHuongDT.ReadOnly = false;
            memoKQ.ReadOnly = false;
            memoNoiDung.ReadOnly = false;
            memoTinhTrang.ReadOnly = false;
          //  txtMaPhieu.ReadOnly = false;
          //  txtBN.ReadOnly = false;
        }

        private void gridControl1_Click(object sender, EventArgs e)
        {

        }

        private void radioGroup1_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if(radioGroup1.SelectedIndex == 0)
            {
                btnKeThuoc.Enabled = false;

                gridControl1.BeginUpdate();
                try
                {
                    gridView3.Columns.Clear();
                    gridControl1.DataSource = c.usp_Select_BenhAnNull(name).ToList();
                }
                finally
                {
                    gridControl1.EndUpdate();
                }
            }
            if (radioGroup1.SelectedIndex == 1)
            {
                btnKeThuoc.Enabled = true;

                gridControl1.BeginUpdate();
                try
                {

                    gridView3.Columns.Clear();
                    gridControl1.DataSource = c.usp_Select_BenhAnNotNull(name).ToList();

                }
                finally
                {
                    gridControl1.EndUpdate();
                }
            }
        }

        private void frmBenhAn_Load_1(object sender, EventArgs e)
        {
            show();
            btnKeThuoc.Enabled = false;
        }
       
        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView3.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView3.GetRowCellValue(rowHandle, "MaBA");
            txtBN.Text = obj.ToString();

            String ma = obj.ToString();
            txtMaPhieu.Text = obj.ToString();

            var tt = gridView3.GetRowCellValue(rowHandle, "TinhTrang");
            memoTinhTrang.Text = tt.ToString();

            var ngay = gridView3.GetRowCellValue(rowHandle, "NgayLap");
            dateNgayLap.Text = ngay.ToString();
            var kqdt = gridView3.GetRowCellValue(rowHandle, "KqDieuTri");
            memoKQ.Text = kqdt.ToString();

            var kham = gridView3.GetRowCellValue(rowHandle, "NoiDungKham");
            memoNoiDung.Text = kham.ToString();
            var huongdt= gridView3.GetRowCellValue(rowHandle, "HuongDieuTri");
            memoHuongDT.Text = huongdt.ToString();
            
        }

        private void gridControl1_Click_1(object sender, EventArgs e)
        {

        }

        private void barButtonItem4_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barButtonItem7_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            show1();
        }

        private void barButtonItem2_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {


            String ma = txtMaPhieu.Text;
          

            
            String tinhtrang = memoTinhTrang.Text;

            string kq =memoKQ.Text;

            string noidung = memoNoiDung.Text;
            string hdt = memoHuongDT.Text;
            c.usp_Update_BenhAn(ma, kq, noidung, tinhtrang, hdt);
            c.SaveChanges();
            show();
        }

        private void barButtonItem3_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            radioGroup1.SelectedIndex = 1;
            show();
        }

        private void btnKeThuoc_Click(object sender, EventArgs e)
        {
            if(txtBN.Text==null )
            {
                MessageBox.Show("Chưa chọn Bệnh Nhân");
         
            }
            else
            {
                frmDonThuoc f = new frmDonThuoc();

                f.MA = txtBN.Text;
                f.Show();
            }
       
        }
    }
}