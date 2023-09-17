using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using QuanLyThueXe.Models;
namespace QuanLyThueXe.Controllers
{
    public class UserController : Controller
    {
        QLTXDataContext da = new QLTXDataContext("Data Source=.;Initial Catalog=QLTX;Integrated Security=True");
        public ActionResult ListUser()
        {            
            List<login> listuser = da.logins.ToList();
            return View(listuser);
        }
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(UserModel user)
        {
            if (IsValid(user.Username, user.Password))
            {
                FormsAuthentication.SetAuthCookie(user.Username, false);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                TempData["ErrorMessage"] = "Đăng nhập thất bại";
            }
            return View(user);
        }
        private bool IsValid(string username, string password)
        {
            var user = GetUserByUsername(username);
            if (user != null)
            {
                if (user.Password == password)
                {
                    return true;
                }
            }
            return false;
        }
        private UserModel GetUserByUsername(string username)
        {
            var user = da.logins.FirstOrDefault(u => u.Username == username);
            if (user != null)
            {
                var userModel = new UserModel
                {
                    Username = user.Username,
                    Password = user.Password
                };
                return userModel;
            }
            return null;
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(UserModel model)
        {
            if (ModelState.IsValid)
            {
                if (!IsUsernameUnique(model.Username))
                {
                    TempData["ErrorMessage"] = "Đăng ký thất bại, tên người dùng đã tồn tại!";
                    return View(model);
                }
                CreateUser(model);
                FormsAuthentication.SetAuthCookie(model.Username, false);
                TempData["SuccessMessage"] = "Đăng ký thành công!";
                return RedirectToAction("Register", "User");
            }
            return View(model);
        }
        private bool IsUsernameUnique(string username)
        {
            var existingUser = GetUserByUsername(username);
            return existingUser == null;
        }
        private void CreateUser(UserModel model)
        {
            var user = new login
            {
                Username = model.Username,
                Password = model.Password
            };
            da.logins.InsertOnSubmit(user);
            da.SubmitChanges();
        }
    }
}