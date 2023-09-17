using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace QuanLyThueXe.Controllers
{
    public class ProductController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public ActionResult ListProduct(string sortProduct, int? page, string SearchString = "")
        {
            IQueryable<product> products = da.products;
            ViewBag.SearchString = SearchString;
            int pageSize = 3;
            int pageNumber = (page ?? 1);
            if (SearchString != "")
            {
                products = products.Where(x => x.ProductName.ToUpper().Contains(SearchString.ToUpper()));
            }
            ViewBag.SortByName = string.IsNullOrEmpty(sortProduct) ? "name_desc" : "";
            ViewBag.SortByPrice = sortProduct == "price" ? "price_desc" : "price";
            switch (sortProduct)
            {
                case "name_desc":
                    products = products.OrderByDescending(s => s.ProductName);
                    break;
                case "price_desc":
                    products = products.OrderByDescending(s => s.UnitPrice);
                    break;
                case "price":
                    products = products.OrderBy(s => s.UnitPrice);
                    break;
                default:
                    products = products.OrderBy(s => s.ProductName);
                    break;
            }
            IPagedList<product> pagedList = products.ToPagedList(pageNumber, pageSize);
            return View(pagedList);
        }

        public ActionResult Details(int id)
        {
            product p = da.products.Where(q => q.ProductID == id).FirstOrDefault();
            return View(p);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(product product, FormCollection collection)
        {
            try
            {
                product p = product;
                da.products.InsertOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListProduct");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            product p = da.products.First(s => s.ProductID == id);
            return View(p);
        }

        [HttpPost]
        public ActionResult Edit(product product, int id)
        {
            try
            {
                product p = da.products.First(s => s.ProductID == id);
                p.ProductName = product.ProductName;
                p.UnitPrice = product.UnitPrice;
                da.SubmitChanges();
                return RedirectToAction("ListProduct");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            product p = da.products.FirstOrDefault(s => s.ProductID == id);
            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                product p = da.products.First(s => s.ProductID == id);
                da.products.DeleteOnSubmit(p);
                da.SubmitChanges();
                return RedirectToAction("ListProduct");
            }
            catch
            {
                return View();
            }
        }
    }
}