using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TIM.LibraryApp.Entities;
using TIM.LibraryApp.Helper;
using TIM.LibraryApp.Models;

namespace TIM.LibraryApp.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetBookList()
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var books = (from b in LibraryContext.Books
                             join t in LibraryContext.BookTransactions on b.ISBN equals t.ISBN into list
                             from l in list.DefaultIfEmpty()
                             orderby b.Name
                             select new BookListModel
                             {
                                 Name = b.Name,
                                 Author = b.Author,
                                 ISBN = b.ISBN,
                                 DueDate = l.DueDate != null ? l.DueDate : (DateTime?)null,
                                 Issued = l.Issued != null ? l.Issued : 0,
                             }).ToList();

                return PartialView("BookListPartialView", books);
            }
        }

        public ActionResult SearchBookPartial(string Name, string Author, string ISBN)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var books = LibraryContext.sp_SearchBook(Name, Author, ISBN).ToList();

                return PartialView("BookListPartialView", books);
            }
        }

        [HttpGet]
        public ActionResult IssueBook(long isbn)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                List<SelectListItem> list = new List<SelectListItem>();

                var books = (from b in LibraryContext.Books
                             join t in LibraryContext.BookTransactions on b.ISBN equals t.ISBN into list1
                             from l in list1.DefaultIfEmpty()
                             select new BookListModel
                             {
                                 Name = b.Name,
                                 Author = b.Author,
                                 ISBN = b.ISBN,
                                 DueDate = l.DueDate != null ? l.DueDate : (DateTime?)null,
                                 Issued = l.Issued != null ? l.Issued : 0,
                             }).ToList();

                var book = books.Where(i => i.ISBN == isbn)
                                .Select(k => new BookListModel()
                                {
                                    Name = k.Name,
                                    Author = k.Author,
                                    ISBN = k.ISBN
                                }).FirstOrDefault();

                var members = LibraryContext.Members.ToList();

                foreach (var item in members)
                {
                    list.Add(new SelectListItem { Text = item.Name + item.Surname, Value = item.Id.ToString() });
                }

                ViewBag.members = list;

                return View(book);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveIssue(long ISBN, int memberID, string dueDate)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                HelperMethods helper = new HelperMethods();
                BookTransactions bt = new BookTransactions();

                bt.ISBN = ISBN;
                bt.MemberId = memberID;
                bt.RequestDate = DateTime.Now;
                
                if (dueDate != "")
                {
                    DateTime mydate = DateTime.ParseExact(dueDate, "dd/MM/yyyy", null);
                    var myDueDate = Convert.ToDateTime(Convert.ToDateTime(mydate, CultureInfo.CurrentCulture).ToString("yyyy-MM-dd HH:mm:ss.fff"));
                    bt.DueDate = myDueDate;
                }
                else
                {
                    bt.DueDate = helper.CalculateDueDate(bt.RequestDate);
                }                    

                bt.Penalty = 0;
                bt.Issued = 1;

                if (ModelState.IsValid)
                {
                    LibraryContext.BookTransactions.Add(bt);
                    LibraryContext.SaveChanges();

                    return RedirectToAction("/Index");
                }
                return View(bt);
            }
        }

        [HttpGet]
        public ActionResult Renew(long isbn)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                List<SelectListItem> list = new List<SelectListItem>();
                BookListModel bookList = new BookListModel();

                var books = (from b in LibraryContext.Books
                             join t in LibraryContext.BookTransactions on b.ISBN equals t.ISBN into list1
                             from l in list1.DefaultIfEmpty()
                             select new BookListModel
                             {
                                 Name = b.Name,
                                 Author = b.Author,
                                 ISBN = b.ISBN,
                                 DueDate = l.DueDate != null ? l.DueDate : (DateTime?)null,
                                 Issued = l.Issued != null ? l.Issued : 0,
                                 MemberID = l.MemberId
                             }).ToList();

                var book = books.Where(i => i.ISBN == isbn &&
                                            i.Issued == 1)
                                .Select(k => new BookListModel()
                                    {
                                        Name = k.Name,
                                        Author = k.Author,
                                        ISBN = k.ISBN,
                                        DueDate = k.DueDate,
                                        MemberID = k.MemberID
                                    }).FirstOrDefault();

                var member = LibraryContext.Members.Where(i => i.Id == book.MemberID).FirstOrDefault();
                var members = LibraryContext.Members.ToList();

                foreach (var item in members)
                {
                    list.Add(new SelectListItem { Text = item.Name + item.Surname, Value = item.Id.ToString() });
                }

                ViewBag.member = member;
                ViewBag.members = list;
                ViewBag.dueDate = book.DueDate;

                return View(book);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SaveRenew(long ISBN, string dueDate)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                HelperMethods helper = new HelperMethods();

                var result = LibraryContext.BookTransactions.SingleOrDefault(i => i.ISBN == ISBN);

                if (dueDate != "")
                {
                    DateTime mydate = DateTime.ParseExact(dueDate, "dd/MM/yyyy", null);
                    var myDueDate = Convert.ToDateTime(Convert.ToDateTime(mydate, CultureInfo.CurrentCulture).ToString("yyyy-MM-dd HH:mm:ss.fff"));
                    result.DueDate = myDueDate;
                }
                else
                {
                    result.DueDate = helper.CalculateDueDate(result.RequestDate);
                }
                LibraryContext.SaveChanges();

                return RedirectToAction("/Index");
            }
        }

        [HttpGet]
        public ActionResult DailyReport()
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                HelperMethods helper = new HelperMethods();

                var bts = LibraryContext.BookTransactions.ToList();

                foreach (var item in bts)
                {
                    helper.CalculatePenalties(item.ISBN, item.DueDate);
                }

                var day = DateTime.Now.AddDays(2);
                var today = DateTime.Now;

                var transactions = (from bt in LibraryContext.BookTransactions
                                    join m in LibraryContext.Members on bt.MemberId equals m.Id into list1
                                    from l1 in list1.DefaultIfEmpty()
                                    join b in LibraryContext.Books on bt.ISBN equals b.ISBN into list2
                                    from l2 in list2.DefaultIfEmpty()
                                    where bt.DueDate <= day
                                    orderby(bt.DueDate)
                                    select new DailyReport
                                    {
                                        MemberID = bt.MemberId,
                                        MemberName = l1.Name + " " + l1.Surname,
                                        BookName = l2.Name,
                                        ReqDate = bt.RequestDate,
                                        DueDate = bt.DueDate,
                                        Penalty = bt.Penalty,
                                        XdayLeft = bt.DueDate.Day - today.Day
                                    }).ToList();

                return View(transactions);
            }
        }

        [HttpPost]
        public JsonResult ReturnBook(long? isbn)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                CompletedTransactions ct = new CompletedTransactions();

                var transaction = LibraryContext.BookTransactions
                                                    .Where(i => i.ISBN == isbn).FirstOrDefault();
                if (isbn == null)
                    return Json("False");
                
                if (transaction != null)
                {
                    ct.ISBN = transaction.ISBN;
                    ct.MemberId = transaction.MemberId;
                    ct.RequestDate = transaction.RequestDate;
                    ct.DueDate = transaction.DueDate;
                    ct.ReturnDate = DateTime.Now;
                    ct.Penalty = transaction.Penalty;
                    ct.IsReturned = 1;

                    LibraryContext.CompletedTransactions.Add(ct);
                    LibraryContext.BookTransactions.Remove(transaction);
                    LibraryContext.SaveChanges();

                    return Json("Success");
                }
                else
                    return Json("False");                
            }
        }

        public ActionResult AddBook()
        {
            ViewBag.Message = TempData["SameISBN"];

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateBook(long ISBN, string Name, string Author)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var bookList = LibraryContext.Books.Where(i => i.ISBN == ISBN).FirstOrDefault();
                Books books = new Books();

                books.ISBN = ISBN;
                books.Name = Name;
                books.Author = Author;

                if (bookList != null)
                {
                    TempData["SameISBN"] = "This isbn code is available!";

                    return RedirectToAction("/AddBook", books);
                }
                else
                {
                    if (ModelState.IsValid)
                    {
                        LibraryContext.Books.Add(books);
                        LibraryContext.SaveChanges();

                        return RedirectToAction("/Index");
                    }
                }
                return RedirectToAction("/AddBook", books);
            }
        }

        [HttpGet]
        public ActionResult EditBook(long isbn)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                if (isbn == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                Books book = LibraryContext.Books.Find(isbn);

                if (book == null)
                {
                    return HttpNotFound();
                }
                return View(book);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateBook(long ISBN, string Name, string Author)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                Books books = new Books();

                books.ISBN = ISBN;
                books.Name = Name;
                books.Author = Author;

                if (ModelState.IsValid)
                {
                    LibraryContext.Entry(books).State = EntityState.Modified;
                    LibraryContext.SaveChanges();

                    return RedirectToAction("/Index");
                }
                return View(books);
            }
        }

        [HttpPost]
        public JsonResult DeleteBook(long? isbn)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var book = LibraryContext.Books.Where(i => i.ISBN == isbn).FirstOrDefault();
                var transaction = LibraryContext.BookTransactions.Where(i => i.ISBN == isbn).FirstOrDefault();
                var completedTransaction = LibraryContext.CompletedTransactions.Where(i => i.ISBN == isbn).FirstOrDefault();

                if (isbn == null)
                    return Json("False");

                if (book != null)
                {
                    if (transaction != null)
                        LibraryContext.BookTransactions.Remove(transaction);

                    if (completedTransaction != null)
                        LibraryContext.CompletedTransactions.Remove(completedTransaction);

                    LibraryContext.Books.Remove(book);
                    LibraryContext.SaveChanges();

                    return Json("Success");
                }
                else
                    return Json("False");
            }
        }
    }
}