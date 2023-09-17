using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyThueXe.Controllers
{
    public class CustomerController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public ActionResult ListCustomer()
        {
            List<customer> listcustomer = da.customers.ToList();
            return View(listcustomer);
        }

        public ActionResult Details(int id)
        {
            customer p = da.customers.Where(q => q.CustomerID == id).FirstOrDefault();
            return View(p);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(customer customer, FormCollection collection)
        {
            try
            {
                customer p = customer;
                da.customers.InsertOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListCustomer");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            customer p = da.customers.First(s => s.CustomerID == id);
            return View(p);
        }

        [HttpPost]
        public ActionResult Edit(customer customer, int id)
        {
            try
            {
                customer p = da.customers.First(s => s.CustomerID == id);
                p.CustomerID = customer.CustomerID;
                p.CustomerName = customer.CustomerName;
                p.Gender = customer.Gender;
                p.Country = customer.Country;
                da.SubmitChanges();
                return RedirectToAction("ListCustomer");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            customer p = da.customers.FirstOrDefault(s => s.CustomerID == id);
            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                customer p = da.customers.First(s => s.CustomerID == id);
                da.customers.DeleteOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListCustomer");
            }
            catch
            {
                return View();
            }
        }
    }
}