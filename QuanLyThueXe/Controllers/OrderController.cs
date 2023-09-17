using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyThueXe.Controllers
{
    public class OrderController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public ActionResult ListOrder()
        {
            List<order> listorder = da.orders.ToList();
            return View(listorder);
        }

        public ActionResult Details(int id)
        {
            order p = da.orders.Where(q => q.OrderID == id).FirstOrDefault();
            return View(p);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(order order, FormCollection collection)
        {
            try
            {
                order p = order;
                da.orders.InsertOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListOrder");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            order p = da.orders.First(s => s.OrderID == id);
            return View(p);
        }

        [HttpPost]
        public ActionResult Edit(order order, int id)
        {
            try
            {
                order p = da.orders.First(s => s.OrderID == id);
                p.CustomerID = order.CustomerID;
                p.EmployeeID = order.EmployeeID;
                p.OrderDate = order.OrderDate;
                p.ProductID = order.ProductID;  
                p.Quantity = order.Quantity;
                da.SubmitChanges();
                return RedirectToAction("ListOrder");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            order p = da.orders.FirstOrDefault(s => s.OrderID == id);
            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                order p = da.orders.First(s => s.OrderID == id);
                da.orders.DeleteOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListOrder");
            }
            catch
            {
                return View();
            }
        }
        public ActionResult TotalNumberOfProductSoldInTheMonth(int month)
        {
            try
            {
                int totalnumberofproductsoldinthemonth = da.orders
                .Where(g => g.OrderDate.Month == month)
                .Sum(g => g.Quantity);
                ViewBag.Thang = month;
                ViewBag.TongSoLuongXeDaThueTrongThang = totalnumberofproductsoldinthemonth;
            }
            catch (Exception)
            {

                return View();
            }
                              
            return View();
        }
    }
}