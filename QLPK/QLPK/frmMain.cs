using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraBars;
using DevExpress.XtraEditors;

namespace QLPK
{
    public partial class frmMain : DevExpress.XtraBars.Ribbon.RibbonForm
    {

        private string role;
        public string ROLE
        {
            set
            {
                role = value;
            }
        }

        private string name;

        public string NAME
        {
            set
            {
                name = value;
            }
        }

        public frmMain()
        {
            InitializeComponent();
        }

        bool CheckForm(XtraForm form)
        {
            foreach (var item in MdiChildren)
            {
                if (item.Name == form.Name)
                {
                    item.Activate();
                    return true;
                }
            }
            return false;
        }
        private void barButtonItem4_ItemClick(object sender, ItemClickEventArgs e)
        {
            var f = new frmCategory();
            if (CheckForm(f)) return;
            f.MdiParent = this;
            f.Show();
        }

        private void barButtonItem5_ItemClick(object sender, ItemClickEventArgs e)
        {
            var f = new frmBenhNhan();
            if (CheckForm(f)) return;
            f.MdiParent = this;
            f.Show();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            lbWelcome.Visible = false;
            if (this.role == "1")
            {
                lbWelcome.Visible = true;

                barBtbDN.Enabled = false;
                lbWelcome.Text ="Xin chào nhân viên "+ name.ToString();
                pnDN.Visible = false;
                barbtnBacSi.Enabled = false;
            }
            if(this.role=="2")
            {
                lbWelcome.Visible = true;

                barBtbDN.Enabled = false;
            //    lbWelcome.Text = "Xin chào bác sĩ " + name.ToString();
                pnDN.Visible = false;
                barbtnBenhNhan.Enabled = false;
                barbtnBacSi.Enabled = false;


            }
        }

        private void simpleButton1_Click(object sender, EventArgs e)
        {
            try
            {
                qlpk1Entities2 c = new qlpk1Entities2();
                string ten = txtTen.Text.Trim();
                string mk = txtMK.Text.Trim();
             Boolean b = Convert.ToBoolean(c.usp_DangNhap(ten, mk).SingleOrDefault());



                if (b == true)
                {
                    var user = c.Users.Where(a => a.UsersName==ten).Select(a => a.UsersName).FirstOrDefault();

                    this.Hide();
                    frmMain f = new frmMain();
                    f.role = "1";
                    f.NAME = user;
                    f.ShowDialog();

                    this.Close();
                }
                else
                {
                    var user = c.BacSis.Where(a => a.TenBS == ten).Select(a => a.MaBS).FirstOrDefault();

                    this.Hide();
                    frmMain f = new frmMain();
                    f.role = "2";
                    f.NAME = user;
                    f.ShowDialog();
                }
            }
            catch
            {

            }
        }

        private void ribbonControl1_Click(object sender, EventArgs e)
        {

        }

        private void barBtbDN_ItemClick(object sender, ItemClickEventArgs e)
        {
            
                    pnDN.Visible = true;
             
        }

        private void pnDN_MouseClick(object sender, MouseEventArgs e)
        {
            pnDN.Visible = false;
        }

        private void lbWelcome_Click(object sender, EventArgs e)
        {

        }

        private void barButtonItem13_ItemClick(object sender, ItemClickEventArgs e)
        {
            frmPhieuNhapVien f = new frmPhieuNhapVien();

            f.NAME = name;
            if (CheckForm(f)) return;
            f.MdiParent = this;
            f.Show();
        }

        private void barButtonItem19_ItemClick(object sender, ItemClickEventArgs e)
        {
            frmBenhAn f = new frmBenhAn();

            f.NAME = name;
            if (CheckForm(f)) return;
            f.MdiParent = this;
            f.Show();
        }
    }
}