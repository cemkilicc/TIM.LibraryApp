using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TIM.LibraryApp.Models
{
    public class DailyReport
    {
        public int MemberID { get; set; }
        public string MemberName { get; set; }
        public string BookName { get; set; }
        public DateTime ReqDate { get; set; }
        public DateTime DueDate { get; set; }
        public double Penalty { get; set; }
        public int XdayLeft { get; set; }
    }
}