using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyThueXe.Models
{
    public class CartModel
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public decimal? UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal? Total { get { return UnitPrice * Quantity; } }
        public CartModel(int productID)
        {
            product p = da.products.FirstOrDefault(s => s.ProductID == productID);
            this.ProductID = p.ProductID;
            this.ProductName = p.ProductName;
            this.UnitPrice = p.UnitPrice;
            this.Quantity = 1;
        }
    }
}