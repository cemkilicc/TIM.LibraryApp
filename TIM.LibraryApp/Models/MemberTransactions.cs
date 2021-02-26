using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TIM.LibraryApp.Models
{
    public class MemberTransactions
    {
        public string MemberName { get; set; }
        public string MemberSurname { get; set; }
        public string BookName { get; set; }
        public long ISBN { get; set; }
        public DateTime RequestDate { get; set; }
        public DateTime DueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public double Penalty { get; set; }
    }
}