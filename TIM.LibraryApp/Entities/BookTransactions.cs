//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TIM.LibraryApp.Entities
{
    using System;
    using System.Collections.Generic;
    
    public partial class BookTransactions
    {
        public int Id { get; set; }
        public long ISBN { get; set; }
        public int MemberId { get; set; }
        public System.DateTime RequestDate { get; set; }
        public System.DateTime DueDate { get; set; }
        public double Penalty { get; set; }
        public int Issued { get; set; }
    
        public virtual Books Books { get; set; }
        public virtual Members Members { get; set; }
    }
}
