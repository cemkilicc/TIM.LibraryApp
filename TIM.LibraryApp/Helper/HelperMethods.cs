using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TIM.LibraryApp.Entities;

namespace TIM.LibraryApp.Helper
{
    public class HelperMethods
    {
        private const double c = 0.2;

        public DateTime CalculateDueDate(DateTime startDate)
        {
            int i = 1;

            while (i <= 30)
            {
                var day = CultureInfo.GetCultureInfo("tr-TR").DateTimeFormat.DayNames[(int)startDate.DayOfWeek];

                if (CheckPublicHolidays(startDate))
                {
                    startDate = startDate.AddDays(1);
                }
                else if(!CheckPublicHolidays(startDate))
                {
                    if (day == "Cumartesi" || day == "Pazar")
                    {
                        startDate = startDate.AddDays(1);
                    }
                    else
                    {
                        startDate = startDate.AddDays(1);
                        i++;
                    }
                }
            }
            return startDate;
        }

        public bool CheckPublicHolidays(DateTime day)
        {
            using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
            {
                var publicHolidays = LibraryContext.PublicHolidays.ToList().Where(i => i.Date == day).FirstOrDefault();

                if (publicHolidays != null)
                    return true;
                else
                    return false;
            }
        }

        public void CalculatePenalties(long isbn, DateTime dueDate)
        {
            double penalty = 0;
            var today = DateTime.Now;

            if(dueDate < today)
            {
                for(int i = 1; i <= today.Day - dueDate.Day; i++)
                {
                    penalty += FibonacciSeries(i) * c;
                }
                //penalty = FibonacciSeries(today.Day - dueDate.Day) * c;

                using (LibraryAppEntities LibraryContext = new LibraryAppEntities())
                {
                    var transaction = LibraryContext.BookTransactions.Where(i => i.ISBN == isbn).FirstOrDefault();

                    transaction.Penalty = penalty;
                    LibraryContext.SaveChanges();
                }
            }
        }

        public int FibonacciSeries(int day)
        {
            List<int> list = new List<int>();
            if(day == 1)
            {
                list.Add(0);
            }
            else
            {
                int x = 0;
                int y = 1, z;

                list.Add(x);
                list.Add(y);

                for (int i = 0; i < day - 2; i++)
                {
                    z = x + y;
                    list.Add(z);
                    x = y;
                    y = z;
                }
            }

            if (list.Count > 0)
            {
                var lastindex = list[list.Count - 1];
                return lastindex;
            }
            else
                return 0;
        }
    }
}