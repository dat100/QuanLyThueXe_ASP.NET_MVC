using QuanLyThueXe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyThueXe.Controllers
{
    public class CartController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        private List<CartModel> GetListCarts()
        {
            List<CartModel> carts = Session["CartModel"] as List<CartModel>;
            if (carts == null)
            {
                carts = new List<CartModel>();
                Session["CartModel"] = carts;
            }
            return carts;
        }
        public ActionResult ListCarts()
        {
            List<CartModel> carts = GetListCarts();
            return View(carts);
        }
        public ActionResult AddCart(int id)
        {
            CartModel c = new CartModel(id);
            List<CartModel> carts = GetListCarts();
            carts.Add(c);
            return RedirectToAction("ListCarts");
        }
        public RedirectToRouteResult DelCartItem(int id)
        {          
            List<CartModel> cart = Session["CartModel"] as List<CartModel>;
            CartModel item = cart.FirstOrDefault(m => m.ProductID == id);
            if (item != null)
            {
                cart.Remove(item);
                Session["CartModel"] = cart;
            }
            return RedirectToAction("ListCarts");
        }

        public ActionResult OrderProduct()
        {
            Random random = new Random();           
            List<CartModel> carts = GetListCarts();
            foreach (CartModel item in GetListCarts())
            {
                int nextOrderID = da.orders.Max(o => (int?)o.OrderID) ?? 0;
                nextOrderID++;
                order od = new order();
                od.OrderID = nextOrderID;
                od.OrderDate = DateTime.Now;
                od.CustomerID = random.Next(1, 8);
                od.EmployeeID = random.Next(1, 5);
                od.ProductID = item.ProductID;
                od.Quantity = item.Quantity;
                da.orders.InsertOnSubmit(od);
                
                da.SubmitChanges();
            }
            Session["CartModel"] = null;
            return RedirectToAction("ListOrder", "Order");
        }
    }
}