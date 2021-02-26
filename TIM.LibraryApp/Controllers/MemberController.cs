using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TIM.LibraryApp.Entities;
using TIM.LibraryApp.Models;

namespace TIM.LibraryApp.Controllers
{
    public class MemberController : Controller
    {
        // GET: Member
        public ActionResult Members()
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var members = LibraryContext.Members.ToList();
                members.OrderBy(i => i.Name).ToList();

                return View(members);
            }
        }

        public ActionResult AddMember()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateMember(string Name, string Surname)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                Members members = new Members();

                members.Name = Name;
                members.Surname = Surname;

                if (ModelState.IsValid)
                {
                    LibraryContext.Members.Add(members);
                    LibraryContext.SaveChanges();

                    return RedirectToAction("/Members");
                }
                return View(members);
            }
        }

        [HttpGet]
        public ActionResult EditMember(int id)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                Members member = LibraryContext.Members.Find(id);

                if (member == null)
                {
                    return HttpNotFound();
                }
                return View(member);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateMember(int id, string Name, string Surname)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                Members members = new Members();

                members.Id = id;
                members.Name = Name;
                members.Surname = Surname;

                if (ModelState.IsValid)
                {
                    LibraryContext.Entry(members).State = EntityState.Modified;
                    LibraryContext.SaveChanges();

                    return RedirectToAction("/Members");
                }
                return View(members);
            }
        }

        [HttpPost]
        public JsonResult DeleteMember(int? id)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var member = LibraryContext.Members.Where(i => i.Id == id).FirstOrDefault();
                var transaction = LibraryContext.BookTransactions.Where(i => i.MemberId == id).FirstOrDefault();
                var completedTransaction = LibraryContext.CompletedTransactions.Where(i => i.MemberId == id).FirstOrDefault();

                if (id == null)
                    return Json("False");

                if (member != null)
                {
                    if (transaction != null)
                        LibraryContext.BookTransactions.Remove(transaction);

                    if (completedTransaction != null)
                        LibraryContext.CompletedTransactions.Remove(completedTransaction);

                    LibraryContext.Members.Remove(member);
                    LibraryContext.SaveChanges();

                    return Json("Success");
                }
                else
                    return Json("False");
            }
        }

        public ActionResult ShowTransactions(int? id)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                List<MemberTransactions> memberTransactions = new List<MemberTransactions>();

                if (id == null)
                {
                    return RedirectToAction("/Members");
                }
                else
                {
                    var member = LibraryContext.Members.Where(i => i.Id == id).FirstOrDefault();

                    memberTransactions = (from bt in LibraryContext.BookTransactions
                                         join b in LibraryContext.Books on bt.ISBN equals b.ISBN into booklist
                                         from bl in booklist.DefaultIfEmpty()
                                         where bt.MemberId == id
                                         select new MemberTransactions
                                         {
                                             MemberName = member.Name,
                                             MemberSurname = member.Surname,
                                             BookName = bl.Name,
                                             ISBN = bl.ISBN,
                                             RequestDate = bt.RequestDate,
                                             DueDate = bt.DueDate,
                                             ReturnDate = (DateTime?)null,
                                             Penalty = bt.Penalty
                                         }).ToList();

                    memberTransactions.AddRange((from ct in LibraryContext.CompletedTransactions
                                                join b in LibraryContext.Books on ct.ISBN equals b.ISBN into booklist
                                                from bl in booklist.DefaultIfEmpty()
                                                where ct.MemberId == id
                                                select new MemberTransactions
                                                {
                                                    MemberName = member.Name,
                                                    MemberSurname = member.Surname,
                                                    BookName = bl.Name,
                                                    ISBN = bl.ISBN,
                                                    RequestDate = ct.RequestDate,
                                                    DueDate = ct.DueDate,
                                                    ReturnDate = ct.ReturnDate,
                                                    Penalty = ct.Penalty
                                                }).ToList());
                    memberTransactions.OrderBy(i => i.DueDate).ToList();

                    return View(memberTransactions);
                }
            }
        }
    }
}