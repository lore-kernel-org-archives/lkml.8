Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C432AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94224207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YEzfqnDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgA2XZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:25:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47148 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2XZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5899mwuqENX6lCLwrkX+/AuwqmIviaBAWbid34IwXc0=; b=YEzfqnDmurAxrqvqRBTgtAWzg
        QCmCH4wzo4/pPD/622md4gyEDABLCj7X54aFEM48vK38dMRUDs+z5jQoLxjm9B6zQS58r08Qzp7Vm
        6iKuwW6/YgUSR4HTgXyVThTpM1T2ejQkZrMy+rPyfnnTZjKXZ+k1MOcTIsJOAVlPJqLhUjECvETa5
        qDHuK/m5ajntlS5NciokDKpgb8uSGLjLgMcXWeG4wb6o7WlPdlGTVWAx6tl/m1s4SeqLNctc+iFI9
        Pm4PyR01pSE7b6LfsYF1Yk66efPPJE4KDuvO2oXEtZNjG2UueszhGXK99Sw4Cf1FWER+9JEi7zg5z
        13sf+HWWw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40926)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iwwha-0007v7-O8; Wed, 29 Jan 2020 23:24:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iwwhN-0003n9-7a; Wed, 29 Jan 2020 23:24:41 +0000
Date:   Wed, 29 Jan 2020 23:24:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, akpm@linux-foundation.org,
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
Message-ID: <20200129232441.GI25745@shell.armlinux.org.uk>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200129094738.GE25745@shell.armlinux.org.uk>
 <20200129215745.GA20736@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129215745.GA20736@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 05:57:45AM +0800, Wei Yang wrote:
> On Wed, Jan 29, 2020 at 09:47:38AM +0000, Russell King - ARM Linux admin wrote:
> >On Sun, Jan 26, 2020 at 05:47:57PM +0300, Dmitry Osipenko wrote:
> >> 18.01.2020 02:22, Wei Yang пишет:
> >> > Use the general helper instead of do it by hand.
> >> > 
> >> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> > ---
> >> >  mm/mremap.c | 7 ++-----
> >> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/mm/mremap.c b/mm/mremap.c
> >> > index c2af8ba4ba43..a258914f3ee1 100644
> >> > --- a/mm/mremap.c
> >> > +++ b/mm/mremap.c
> >> > @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >> >  
> >> >  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
> >> >  		cond_resched();
> >> > -		next = (old_addr + PMD_SIZE) & PMD_MASK;
> >> > -		/* even if next overflowed, extent below will be ok */
> >> > +		next = pmd_addr_end(old_addr, old_end);
> >> >  		extent = next - old_addr;
> >> > -		if (extent > old_end - old_addr)
> >> > -			extent = old_end - old_addr;
> >> >  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
> >> >  		if (!old_pmd)
> >> >  			continue;
> >> > @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >> >  
> >> >  		if (pte_alloc(new_vma->vm_mm, new_pmd))
> >> >  			break;
> >> > -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> >> > +		next = pmd_addr_end(new_addr, new_addr + len);
> >> >  		if (extent > next - new_addr)
> >> >  			extent = next - new_addr;
> >> >  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
> >> > 
> >> 
> >> Hello Wei,
> >> 
> >> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
> >> Tegra (ARM32):
> >> 
> >>   BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
> >> 
> >> and eventually kernel hangs.
> >> 
> >> Git's bisection points to this patch and reverting it helps. Please fix,
> >> thanks in advance.
> >
> >The above is definitely wrong - pXX_addr_end() are designed to be used
> >with an address index within the pXX table table and the address index
> >of either the last entry in the same pXX table or the beginning of the
> >_next_ pXX table.  Arbitary end address indicies are not allowed.
> >
> 
> #define pmd_addr_end(addr, end)						\
> ({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
> 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> })
> 
> If my understanding is correct, the definition here align the addr to next PMD
> boundary or end.
> 
> I don't see the possibility to across another PMD. Do I miss something?

Look at the definition of p*_addr_end() that are used when page tables
are rolled up.

> >When page tables are "rolled up" when levels don't exist, it is common
> >practice for these macros to just return their end address index.
> >Hence, if they are used with arbitary end address indicies, then the
> >iteration will fail.
> >
> >The only way to do this is:
> >
> >	next = pmd_addr_end(old_addr,
> >			pud_addr_end(old_addr,
> >				p4d_addr_end(old_addr,
> >					pgd_addr_end(old_addr, old_end))));
> >
> >which gives pmd_addr_end() (and each of the intermediate pXX_addr_end())
> >the correct end argument.  However, that's a more complex and verbose,
> >and likely less efficient than the current code.
> >
> >I'd suggest that there's nothing to "fix" in the v5.5 code wrt this,
> >and trying to "clean it up" will just result in less efficient or
> >broken code.
> >
> >-- 
> >RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> >FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> >According to speedtest.net: 11.9Mbps down 500kbps up
> 
> -- 
> Wei Yang
> Help you, Help me
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
