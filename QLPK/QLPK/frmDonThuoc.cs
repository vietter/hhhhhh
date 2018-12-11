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
    public partial class frmDonThuoc : DevExpress.XtraEditors.XtraForm
    {
        qlpk1Entities2 c = new qlpk1Entities2();

        private string ma;
        public string MA
        {
            set { ma = value; }
        }
        public frmDonThuoc()
        {
            InitializeComponent();
        }

        private void frmDonThuoc_Load(object sender, EventArgs e)
        {
            // txtBN.Text = ma;
            loadBN();
        }

        private void txtSMa_TextChanged(object sender, EventArgs e)
        {

        }



        private void simpleButton3_Click(object sender, EventArgs e)
        {
            txtMaPhieu.ReadOnly = false;
            cbBN.ReadOnly = false;


        }
        void loadBN()
        {
            gridControl2.DataSource = c.Thuocs.Select(a => a).ToList();

            ComboBoxItemCollection item = cbBN.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {

                foreach (var i in c.usp_BNChuaDT().ToList())
                {
                    item.Add(i);
                }

            }
            item.EndUpdate();
            gridControl1.DataSource = c.usp_ShowDT().ToList();
            txtMaPhieu.ReadOnly = true;
            cbBN.ReadOnly = true;
            kt = false;
        }

        private void txtBN_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBoxEdit2_TextChanged(object sender, EventArgs e)
        {
            string ten = txtTenT.Text;

        }

        private void comboBoxEdit1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }



        private void gridControl2_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView4.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView4.GetRowCellValue(rowHandle, "MaThuoc");
            txtTenT.Text = obj.ToString();

        }

        private void gridControl2_Click(object sender, EventArgs e)
        {

        }
        bool kt = false;
        private void simpleButton2_Click(object sender, EventArgs e)
        {
            if (txtSL.Text == "" || txtMaPhieu.Text == "" || cbBN.Text == "")
            {
                MessageBox.Show("Thiếu thông tin! ");

            }
            else
            {
                string ma = txtTenT.Text;
                int sl = Convert.ToInt32(txtSL.Text);

                var tr = c.Thuocs.Where(a => a.MaThuoc == ma).Select(a => a.SL).FirstOrDefault();

                if (sl > tr)
                {
                    MessageBox.Show("Số lượng thuốc hết");
                }
                kt = true;

            }

        }

        private void gridControl1_Click(object sender, EventArgs e)
        {

        }

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView3.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView3.GetRowCellValue(rowHandle, "MaDT");
            txtMaPhieu.Text = obj.ToString();
            var bn = gridView3.GetRowCellValue(rowHandle, "BenhNhan");

            cbBN.Text = bn.ToString();
        }

        private void barButtonItem2_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if(kt==true)
            {

                    string mdt = txtMaPhieu.Text;
                    string bn = cbBN.Properties.GetDisplayText(cbBN).ToString();
                    string mat = txtTenT.Text;
                    int slg = Convert.ToInt32(txtSL.Text);
                    string gc = txtGhiChu.Text;
                    c.usp_insert_DT(mdt, slg, gc, mat, bn);
                    c.SaveChanges();
                    loadBN();
                
            }
        }

        private void barButtonItem3_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barButtonItem4_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barDockControlTop_Click(object sender, EventArgs e)
        {

        }

        private void barDockControlBottom_Click(object sender, EventArgs e)
        {

        }

        private void barDockControlLeft_Click(object sender, EventArgs e)
        {

        }

        private void barDockControlRight_Click(object sender, EventArgs e)
        {

        }

        private void dockPanel1_Click(object sender, EventArgs e)
        {

        }

        private void dockPanel1_Container_Paint(object sender, PaintEventArgs e)
        {

        }

        private void layoutControl2_Click(object sender, EventArgs e)
        {

        }

        private void gridControlDS_Click(object sender, EventArgs e)
        {

        }

        private void simpleButton1_Click(object sender, EventArgs e)
        {

        }

        private void dtE_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void glk_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void dtS_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void labelControl2_Click(object sender, EventArgs e)
        {

        }

        private void labelControl1_Click(object sender, EventArgs e)
        {

        }

        private void barButtonItem1_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barButtonItem5_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barButtonItem6_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barCheckItem1_CheckedChanged(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barCheckItem2_CheckedChanged(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void barCheck_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {

        }

        private void groupControl1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void layoutControl1_Click(object sender, EventArgs e)
        {

        }

        private void gridLookUpEdit1_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void txtMaPhieu_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void txtGhiChu_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void txtTenT_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void txtSL_EditValueChanged(object sender, EventArgs e)
        {

        }
    }
}