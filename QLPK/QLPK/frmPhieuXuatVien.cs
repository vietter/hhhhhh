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
    public partial class frmPhieuXuatVien : DevExpress.XtraEditors.XtraForm
    { qlpk1Entities2 c = new qlpk1Entities2();

        private string ma;
        public string MA
        {
            set
            {
                ma = value;
            }
        }
        public frmPhieuXuatVien()
        {
            InitializeComponent();
        }

        private void frmPhieuXuatVien_Load(object sender, EventArgs e)
        {
            load();
        }
        void load()
        {
            MessageBox.Show(ma);
            gridControl1.DataSource = c.usp_ShowPNV(ma);

        }
      
        private void gridControl1_Click(object sender, EventArgs e)
        {
            var rowHandle = gridView1.FocusedRowHandle;

            var obj = gridView1.GetRowCellValue(rowHandle, "MaPNV");

            if (DialogResult.Yes == MessageBox.Show("Nó sẽ xóa phiếu nhập viện, đồng ý", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                try
                {
                    qlpk1Entities2 c = new qlpk1Entities2();
                    c.usp__Delete__PNV(obj.ToString());
                    c.SaveChanges();
                }
                catch
                {
                    MessageBox.Show("Giường đã trống");
                }
            }


        }
    }
}