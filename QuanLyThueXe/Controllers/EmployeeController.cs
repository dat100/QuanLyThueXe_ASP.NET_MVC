using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyThueXe.Controllers
{
    public class EmployeeController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public ActionResult ListEmployee()
        {
            List<employee> listemployee = da.employees.ToList();
            return View(listemployee);
        }

        public ActionResult Details(int id)
        {
            employee p = da.employees.Where(q => q.EmployeeID == id).FirstOrDefault();
            return View(p);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(employee employee, FormCollection collection)
        {
            try
            {
                employee p = employee;
                da.employees.InsertOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListEmployee");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            employee p = da.employees.First(s => s.EmployeeID == id);
            return View(p);
        }

        [HttpPost]
        public ActionResult Edit(employee  employee, int id)
        {
            try
            {
                employee p = da.employees.First(s => s.EmployeeID == id);
                p.EmployeeID =  employee.EmployeeID;
                p.EmployeeName = employee.EmployeeName;
                p.Gender = employee.Gender;
                p.Country = employee.Country;
                da.SubmitChanges();
                return RedirectToAction("ListEmployee");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            employee p = da.employees.FirstOrDefault(s => s.EmployeeID == id);
            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                employee p = da.employees.First(s => s.EmployeeID == id);
                da.employees.DeleteOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListEmployee");
            }
            catch
            {
                return View();
            }
        }
    }
}