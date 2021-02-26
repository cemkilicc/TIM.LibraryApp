using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TIM.LibraryApp.Models
{
    public class BookListModel
    {
        public string Name { get; set; }
        public string Author { get; set; }
        public long ISBN { get; set; }
        public DateTime? DueDate { get; set; }
        public int Issued { get; set; }
        public int? MemberID { get; set; }
    }
}