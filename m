Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614C720708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgA3V5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:57:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:18902 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgA3V5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:57:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 13:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="233109286"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2020 13:57:12 -0800
Date:   Fri, 31 Jan 2020 05:57:27 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, yang.shi@linux.alibaba.com,
        thellstrom@vmware.com, Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
Message-ID: <20200130215727.GA11373@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200129094738.GE25745@shell.armlinux.org.uk>
 <20200129215745.GA20736@richard>
 <20200129232441.GI25745@shell.armlinux.org.uk>
 <20200130013000.GA5137@richard>
 <20200130141505.GK25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130141505.GK25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:15:05PM +0000, Russell King - ARM Linux admin wrote:
>On Thu, Jan 30, 2020 at 09:30:00AM +0800, Wei Yang wrote:
>> On Wed, Jan 29, 2020 at 11:24:41PM +0000, Russell King - ARM Linux admin wrote:
>> >On Thu, Jan 30, 2020 at 05:57:45AM +0800, Wei Yang wrote:
>> >> On Wed, Jan 29, 2020 at 09:47:38AM +0000, Russell King - ARM Linux admin wrote:
>> >> >On Sun, Jan 26, 2020 at 05:47:57PM +0300, Dmitry Osipenko wrote:
>> >> >> 18.01.2020 02:22, Wei Yang пишет:
>> >> >> > Use the general helper instead of do it by hand.
>> >> >> > 
>> >> >> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> >> > ---
>> >> >> >  mm/mremap.c | 7 ++-----
>> >> >> >  1 file changed, 2 insertions(+), 5 deletions(-)
>> >> >> > 
>> >> >> > diff --git a/mm/mremap.c b/mm/mremap.c
>> >> >> > index c2af8ba4ba43..a258914f3ee1 100644
>> >> >> > --- a/mm/mremap.c
>> >> >> > +++ b/mm/mremap.c
>> >> >> > @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>> >> >> >  
>> >> >> >  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>> >> >> >  		cond_resched();
>> >> >> > -		next = (old_addr + PMD_SIZE) & PMD_MASK;
>> >> >> > -		/* even if next overflowed, extent below will be ok */
>> >> >> > +		next = pmd_addr_end(old_addr, old_end);
>> >> >> >  		extent = next - old_addr;
>> >> >> > -		if (extent > old_end - old_addr)
>> >> >> > -			extent = old_end - old_addr;
>> >> >> >  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>> >> >> >  		if (!old_pmd)
>> >> >> >  			continue;
>> >> >> > @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>> >> >> >  
>> >> >> >  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>> >> >> >  			break;
>> >> >> > -		next = (new_addr + PMD_SIZE) & PMD_MASK;
>> >> >> > +		next = pmd_addr_end(new_addr, new_addr + len);
>> >> >> >  		if (extent > next - new_addr)
>> >> >> >  			extent = next - new_addr;
>> >> >> >  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>> >> >> > 
>> >> >> 
>> >> >> Hello Wei,
>> >> >> 
>> >> >> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
>> >> >> Tegra (ARM32):
>> >> >> 
>> >> >>   BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
>> >> >> 
>> >> >> and eventually kernel hangs.
>> >> >> 
>> >> >> Git's bisection points to this patch and reverting it helps. Please fix,
>> >> >> thanks in advance.
>> >> >
>> >> >The above is definitely wrong - pXX_addr_end() are designed to be used
>> >> >with an address index within the pXX table table and the address index
>> >> >of either the last entry in the same pXX table or the beginning of the
>> >> >_next_ pXX table.  Arbitary end address indicies are not allowed.
>> >> >
>> >> 
>> >> #define pmd_addr_end(addr, end)						\
>> >> ({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
>> >> 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
>> >> })
>> >> 
>> >> If my understanding is correct, the definition here align the addr to next PMD
>> >> boundary or end.
>> >> 
>> >> I don't see the possibility to across another PMD. Do I miss something?
>> >
>> >Look at the definition of p*_addr_end() that are used when page tables
>> >are rolled up.
>> >
>> 
>> Sorry, I don't get your point.
>> 
>> What's the meaning of "roll up" here?
>> 
>> Would you mind giving me an example? I see pmd_addr_end() is not used in many
>> places in core kernel. By glancing those usages, all the places use it like
>> pmd_addr_end(addr, end). Seems no specially handing on the end address.
>> 
>> Or you mean the case when pmd_addr_end() is defined to return "end" directly? 
>
>Not all hardware has five levels of page tables.  When hardware does not
>have five levels, it is common to "roll up" some of the page tables into
>others.
>
>There are generic ways to implement this, which include using:
>
>include/asm-generic/pgtable-nop4d.h
>include/asm-generic/pgtable-nopud.h
>include/asm-generic/pgtable-nopmd.h
>
>and then there's architecture ways to implement this.  32-bit ARM takes
>its implementation for PMD not from the generic version, which
>post-dates 32-bit ARM, but from how page table roll-up was implemented
>back at the time when the current ARM scheme was devised.  The generic
>scheme is unsuitable for 32-bit ARM since we do more than just roll-up
>page tables, but this is irrelevent for this discussion.
>
>All three of the generic implementations, and 32-bit ARM, define the
>pXX_addr_end() macros thusly:
>
>include/asm-generic/pgtable-nop4d.h:#define p4d_addr_end(addr, end) (end)
>include/asm-generic/pgtable-nopmd.h:#define pmd_addr_end(addr, end) (end)
>include/asm-generic/pgtable-nopud.h:#define pud_addr_end(addr, end) (end)
>arch/arm/include/asm/pgtable-2level.h:#define pmd_addr_end(addr,end) (end)
>
>since, as I stated, pXX_addr_end() expects its "end" argument to be
>the address index of the next entry in the immediately upper page
>table level, or the address index of the last entry we wish to
>process, which ever is smaller.
>
>If it's larger than the address index of the next entry in the
>immediately upper page table level, then the effect of all these
>macros will be to walk off the end of the current level of page
>table.
>
>To see how they _should_ be used, see the loops in free_pgd_range()
>and the free_pXX_range() functions called from there and below.
>
>In all cases when the pXX_addr_end() macro was introduced, what I state
>above holds true - and I believe still holds true today, until this
>patch that has reportedly caused issues.
>

Thanks for your patience in explaining this for me.

I got your point. This is my fault in understanding the code.

>-- 
>RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Wei Yang
Help you, Help me
