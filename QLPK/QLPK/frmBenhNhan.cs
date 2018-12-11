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
using DevExpress.XtraEditors.Mask;
using System.Collections;
using DevExpress.XtraGrid.Views.Grid;
using System.Data.Entity;

namespace QLPK
{

    public partial class frmBenhNhan : DevExpress.XtraEditors.XtraForm
    {
        public frmBenhNhan()
        {
            InitializeComponent();
        }
       
        private string name;
        public string NAME
        {
            set
            {
                name = value;
            }
        }

        private void groupControl1_Paint(object sender, PaintEventArgs e)
        {

        }
        private void nhom()
        {
            ComboBoxItemCollection item = comboBoxEdit1.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {

                foreach (var i in c.NhomDoiTuongs.Select(a => a.MaNhom))
                {
                    item.Add(i);
                }

            }
            item.EndUpdate();
        }


        private void khoa()
        {

            ComboBoxItemCollection item = comboBoxEdit2.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {

                foreach (var i in c.Khoas.Select(a => a.MaKhoa))

                {
                    item.Add(i);
                }

            }
            item.EndUpdate();
        }


        private void frmBenhNhan_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'qlpk1DataSet.BenhNhan' table. You can move, or remove it, as needed.
            khoa();
            nhom();
            show();

            txtDC.ReadOnly = true;
            txtHo.ReadOnly = true;
            txtMa.ReadOnly = true;
            txtSDT.ReadOnly = true;
            txtTen.ReadOnly = true;
            comboBoxEdit1.ReadOnly = true;
            comboBoxEdit2.ReadOnly = true;
            comboBoxEdit3.ReadOnly = true;
            comboBoxEdit4.ReadOnly = true;
            dateSinh.ReadOnly = true;
        }

        private void comboBoxEdit2_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboBoxEdit4.Properties.Items.Clear();

            ComboBoxItemCollection item = comboBoxEdit4.Properties.Items;
            item.BeginUpdate();
            using (qlpk1Entities2 c = new qlpk1Entities2())
            {
                String k = comboBoxEdit2.Properties.GetDisplayText(comboBoxEdit2);
                var query = from e1 in c.BacSis
                            where e1.Khoa.Equals(k)
                            select e1.MaBS;

                foreach (var i in query)

                {
                    item.Add(i);
                }

            }
            item.EndUpdate();

        }
        
        bool them = false;
        private void simpleButton1_Click(object sender, EventArgs e)
        {
            show();
            them = true;
            txtDC.ReadOnly = false;
            txtHo.ReadOnly = false;
            txtMa.ReadOnly = false;
            txtSDT.ReadOnly = false;
            txtTen.ReadOnly = false;
            comboBoxEdit1.ReadOnly = false;
            comboBoxEdit2.ReadOnly = false;
            comboBoxEdit3.ReadOnly = false;
            comboBoxEdit4.ReadOnly = false;
            dateSinh.ReadOnly = false;
        }

        private void show()
        {
            txtDC.ReadOnly = true;
            txtHo.ReadOnly = true;
            txtMa.ReadOnly = true;
            txtSDT.ReadOnly = true;
            txtTen.ReadOnly = true;
            comboBoxEdit1.ReadOnly = true;
            comboBoxEdit2.ReadOnly = true;
            comboBoxEdit3.ReadOnly = true;
            comboBoxEdit4.ReadOnly = true;
            dateSinh.ReadOnly = true;

            txtDC.ResetText();
            txtHo.ResetText();
            txtMa.ResetText();
            txtSDT.ResetText();
            txtTen.ResetText();
            comboBoxEdit1.ResetText();
            comboBoxEdit2.ResetText();
            comboBoxEdit3.ResetText();
            comboBoxEdit4.ResetText();
            dateSinh.Text = "";
            qlpk1Entities2 c = new qlpk1Entities2();
            var q = c.v_Current_BenhNhan;
            gridControl1.DataSource = q.ToList();
            radioBN.SelectedIndex = 0;
        }

        private void gridControl1_Click(object sender, EventArgs e)
        {

        }

        private void contextMenuStrip1_Opening(object sender, CancelEventArgs e)
        {

        }

     




        private void panelControl1_Paint(object sender, PaintEventArgs e)
        {

        }

       

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            var rowHandle = gridView1.FocusedRowHandle;

            // Get the value for the given column - convert to the type you're expecting
            var obj = gridView1.GetRowCellValue(rowHandle, "MaBenhNhan");
            txtMa.Text = obj.ToString();

            String ma = obj.ToString();

            qlpk1Entities2 c = new qlpk1Entities2();
            
            var diachi = from t in c.BenhNhans.AsEnumerable()
                         where t.MaBenhNhan == ma
                         select t.DiaChi;
            StringBuilder dc = new StringBuilder();

            foreach (var s in diachi)
            {
                dc.Append(s + Environment.NewLine);
            }
            txtDC.Text = dc.ToString();


            var ten = from t1 in c.BenhNhans.AsEnumerable()
                         where t1.MaBenhNhan == ma
                         select t1.TenBN;
            StringBuilder tn = new StringBuilder();

            foreach (var s in ten)
            {
                tn.Append(s + Environment.NewLine);
            }
            txtTen.Text = tn.ToString();




            var ho = from t2 in c.BenhNhans.AsEnumerable()
                         where t2.MaBenhNhan == ma
                         select t2.HoBN;
            StringBuilder h = new StringBuilder();

            foreach (var s in ho)
            {
                h.Append(s + Environment.NewLine);
            }
            txtHo.Text = h.ToString();


            var sdt = from t3 in c.BenhNhans.AsEnumerable()
                     where t3.MaBenhNhan == ma
                     select t3.SDT;
            StringBuilder st = new StringBuilder();

            foreach (var s in sdt)
            {
                st.Append(s + Environment.NewLine);
            }
            txtSDT.Text = st.ToString();


            var gt = from g in c.BenhNhans.AsEnumerable()
                     where g.MaBenhNhan == ma
                     select g.GioiTinh;
            StringBuilder gt1 = new StringBuilder();

            foreach (var s in gt)
            {
                gt1.Append(s + Environment.NewLine);
            }
            comboBoxEdit3.Text=gt1.ToString();


            var khoa = from k in c.BenhNhans.AsEnumerable()
                       where k.MaBenhNhan == ma
                       select k.Khoa;
            StringBuilder kh = new StringBuilder();

            foreach (var s in khoa)
            {
                kh.Append(s + Environment.NewLine);
            }
            comboBoxEdit2.Text = kh.ToString();


            var nhom = from n in c.BenhNhans.AsEnumerable()
                       where n.MaBenhNhan == ma
                       select n.Nhom;
            StringBuilder nh = new StringBuilder();

            foreach (var s in nhom)
            {
                nh.Append(s + Environment.NewLine);
            }
            comboBoxEdit1.Text = nh.ToString();


            var bsi = from b in c.BenhNhans.AsEnumerable()
                       where b.MaBenhNhan == ma
                       select b.BacSi;
            StringBuilder bs = new StringBuilder();

            foreach (var s in bsi)
            {
                bs.Append(s + Environment.NewLine);
            }
            comboBoxEdit4.Text = bs.ToString();

            var sinh = from si in c.BenhNhans.AsEnumerable()
                      where si.MaBenhNhan == ma
                      select si.NgaySinh;
            StringBuilder sh = new StringBuilder();

            foreach (var s in sinh)
            {
                sh.Append(s + Environment.NewLine);
            }
            dateSinh.Text = sh.ToString();
        }

        private void simpleButton2_Click(object sender, EventArgs e)
        {
            if(DialogResult.Yes ==MessageBox.Show("Nó sẽ xóa cả bệnh án (nếu có), đồng ý" , "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                try
                {
                    var rowHandle = gridView1.FocusedRowHandle;

                    // Get the value for the given column - convert to the type you're expecting
                    var obj = gridView1.GetRowCellValue(rowHandle, "MaBenhNhan");
                    txtMa.Text = obj.ToString();

                    String ma = obj.ToString();
                    qlpk1Entities2 c = new qlpk1Entities2();
                    var q = c.usp_Delete_BenhNhan(ma);
                    c.SaveChanges();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Đã Xóa bệnh án");
                }
            }
         



        }

        private void simpleButton5_Click(object sender, EventArgs e)
        {
            show();
        }

        

        private void radioBN_SelectedIndexChanged(object sender, EventArgs e)
        {


            if (radioBN.SelectedIndex == 0)    // chua xoa
            {
                gridControl1.BeginUpdate();
                try
                {
                    gridView1.Columns.Clear();

                    show();

                }
                finally
                {
                    gridControl1.EndUpdate();
                }
            }
            if (radioBN.SelectedIndex == 1) // Deleted
            {

                gridControl1.BeginUpdate();
                try
                {
                    qlpk1Entities2 c = new qlpk1Entities2();
                    gridView1.Columns.Clear();
                    gridControl1.DataSource = c.v_Deleted_BenhNhan.ToList();

                }
                finally
                {
                    gridControl1.EndUpdate();
                }
            }
        }

      

        private void btbUndo_Click(object sender, EventArgs e)
        {
            var rowHandle = gridView1.FocusedRowHandle;

            var obj = gridView1.GetRowCellValue(rowHandle, "MaBenhNhan");
            txtMa.Text = obj.ToString();

            String ma = obj.ToString();
            qlpk1Entities2 c = new qlpk1Entities2();
            c.usp_UndoBenhNhan(ma);
            c.SaveChanges();
        }
        bool sua = false;
        private void simpleButton3_Click(object sender, EventArgs e) // update 
        {
            sua = true;

            txtDC.ReadOnly = false;
            txtHo.ReadOnly = false;
            txtSDT.ReadOnly = false;
            txtTen.ReadOnly = false;
            comboBoxEdit1.ReadOnly = false;
            comboBoxEdit2.ReadOnly = false;
            comboBoxEdit3.ReadOnly = false;
            comboBoxEdit4.ReadOnly = false;
            dateSinh.ReadOnly = false;
        }

        private void simpleButton6_Click(object sender, EventArgs e)
        {
            if( them==true)

            {

                qlpk1Entities2 db = new qlpk1Entities2();
                if (txtDC.Text == "" || txtHo.Text == "" || txtTen.Text == "" || txtSDT.Text == "" || txtMa.Text == "" ||
                    comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1).ToString() == "" || comboBoxEdit2.Properties.GetDisplayText(comboBoxEdit2).ToString() == "" ||
                    comboBoxEdit3.Properties.GetDisplayText(comboBoxEdit3).ToString() == "" || comboBoxEdit4.Properties.GetDisplayText(comboBoxEdit4).ToString() == "" || dateSinh.Properties.GetDisplayText(dateSinh).ToString() == ""
                    )
                {
                    MessageBox.Show("Cần thêm thông tin");
                }
                else
                {
                    using (DbContextTransaction trans = db.Database.BeginTransaction())
                    {
                        try
                        {

                            String khoa = comboBoxEdit2.Properties.GetDisplayText(comboBoxEdit2);
                            String nhom = comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1);
                            String bacsi = comboBoxEdit4.Properties.GetDisplayText(comboBoxEdit4);
                            int gt = Convert.ToInt32(comboBoxEdit3.Properties.GetDisplayText(comboBoxEdit3).ToString());
                            bool gioitinh;
                            if (gt == 0)
                            {
                                gioitinh = true;
                            }
                            else
                            {
                                gioitinh = false;
                            }
                            Nullable<int> sdt = Convert.ToInt32(txtSDT.Text);
                            String dc = txtDC.Text;
                            String ma = txtMa.Text;
                            String ten = txtTen.Text;
                            String ho = txtHo.Text;
                            // String kham = Convert.ToDateTime(dateKham.Text).ToString("yyyy-MM-dd");
                            String sinh = Convert.ToDateTime(dateSinh.Text).ToString("yyyy-MM-dd");
                            DateTime a = Convert.ToDateTime(sinh);



                            db.usp_Insert_BenhNhan(ma, ho, ten, dc, gioitinh, khoa, nhom, bacsi, sdt, a);
                            db.SaveChanges();
                            trans.Commit();
                            MessageBox.Show("Thêm thành công");
                        }
                        catch (Exception ex)
                        {
                            trans.Rollback();
                            MessageBox.Show("Lỗi trong quá trình thêm");
                        }
                    }
                }

                them = false;
                txtDC.ReadOnly = true;
                txtHo.ReadOnly = true;
                txtMa.ReadOnly = true;
                txtSDT.ReadOnly = true;
                txtTen.ReadOnly = true;
                comboBoxEdit1.ReadOnly = true;
                comboBoxEdit2.ReadOnly = true;
                comboBoxEdit3.ReadOnly = true;
                comboBoxEdit4.ReadOnly = true;
                dateSinh.ReadOnly = true;

            }

            if(sua==true)
            {
                qlpk1Entities2 db = new qlpk1Entities2();
                if (txtDC.Text == "" || txtHo.Text == "" || txtTen.Text == "" || txtSDT.Text == "" ||
                 comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1).ToString() == "" || comboBoxEdit2.Properties.GetDisplayText(comboBoxEdit2).ToString() == "" ||
                 comboBoxEdit3.Properties.GetDisplayText(comboBoxEdit3).ToString() == "" || comboBoxEdit4.Properties.GetDisplayText(comboBoxEdit4).ToString() == "" || dateSinh.Properties.GetDisplayText(dateSinh).ToString() == ""
                 )
                {
                    MessageBox.Show("Cần thêm thông tin");
                }
                else
                {
                    using (DbContextTransaction trans = db.Database.BeginTransaction())
                    { //  try
                      //{


                        String ma = txtMa.Text;

                        String khoa = comboBoxEdit2.Properties.GetDisplayText(comboBoxEdit2);
                        String nhom = comboBoxEdit1.Properties.GetDisplayText(comboBoxEdit1);
                        String bacsi = comboBoxEdit4.Properties.GetDisplayText(comboBoxEdit4);
                        var gt = (comboBoxEdit3.Properties.GetDisplayText(comboBoxEdit3).ToString());
                        bool gioitinh;
                        if (gt == "0")
                        {
                            gioitinh = true;
                        }
                        else
                        {
                            gioitinh = false;
                        }
                        Nullable<int> sdt = Convert.ToInt32(txtSDT.Text);
                        String dc = txtDC.Text;
                        String ten = txtTen.Text;
                        String ho = txtHo.Text;
                        String sinh = Convert.ToDateTime(dateSinh.Text).ToString("yyyy-MM-dd");
                        DateTime a = Convert.ToDateTime(sinh);


                        db.usp_Update_BenhNhan(ma, ho, ten, dc, gioitinh, khoa, nhom, bacsi, sdt, a);
                        db.SaveChanges();
                        trans.Commit();
                        MessageBox.Show("Sửa thành công");
                        // }
                        //catch (Exception ex)
                        //{
                        //    trans.Rollback();
                        //    MessageBox.Show("Lỗi trong quá trình sửa ");
                        //}
                    }
                }
                sua = false;
                txtDC.ReadOnly = true;
                txtHo.ReadOnly = true;
                txtSDT.ReadOnly = true;
                txtTen.ReadOnly = true;
                comboBoxEdit1.ReadOnly = true;
                comboBoxEdit2.ReadOnly = true;
                comboBoxEdit3.ReadOnly = true;
                comboBoxEdit4.ReadOnly = true;
                dateSinh.ReadOnly = true;
            }
        }

        private void simpleButton4_Click(object sender, EventArgs e)
        {
            frmMain f = new frmMain();
            f.ShowDialog();
            this.Close();
        }

        private void comboBoxEdit3_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void gridControl1_Click_1(object sender, EventArgs e)
        {

        }

        private void comboBoxEdit1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}