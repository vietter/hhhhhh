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
    public partial class frmBacSi : DevExpress.XtraEditors.XtraForm
    {
        qlpk1Entities2 c = new qlpk1Entities2();
        public frmBacSi()
        {
            InitializeComponent();
        }

        private void simpleButton1_Click(object sender, EventArgs e)
        {
            string tenbs = textEdit2.Text;
            string nhomm = glkNhom.EditValue.ToString();
            string khoa = glkKhoa.EditValue.ToString();
            string mabs = txtMaBacSi.Text;
            string diachi = txtDiaChi.Text;
            string sdt = textEdit4.Text;
            string hobs = textEdit1.Text;
            int gt = Convert.ToInt32(comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1).ToString());
            decimal luong =Convert.ToDecimal(txtLuong.Text);

            bool gioitinh;
            if (gt == 0)
            {
                gioitinh = true;
            }
            else
            {
                gioitinh = false;
            }

            String sinh = Convert.ToDateTime(dateSinh.Text).ToString("yyyy-MM-dd");
            DateTime a = Convert.ToDateTime(sinh);
            c.usp_Insert_BacSi(mabs, hobs, tenbs, diachi, a, gioitinh,sdt, nhomm, luong, khoa);
            MessageBox.Show("Thành công");
        }

        private void frmBacSi_Load(object sender, EventArgs e)
        {
            ShowNhom();
        }
        void ShowNhom()
        {
            glkNhom.Properties.DataSource = c.usp_Select_Nhom();
            glkNhom.Properties.DisplayMember = "TenNhom";
            glkNhom.Properties.ValueMember = "MaNhom";

            glkKhoa.Properties.DataSource = c.usp_Select_Khoa();
            glkKhoa.Properties.DisplayMember = "TenKhoa";
            glkKhoa.Properties.ValueMember = "MaKhoa";

      

        }

        private void groupControl1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void groupControl1_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void comboBoxEdit1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void labelControl6_Click(object sender, EventArgs e)
        {

        }

        private void dateSinh_EditValueChanged(object sender, EventArgs e)
        {

        }
    }
}