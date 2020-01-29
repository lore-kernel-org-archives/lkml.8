Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DAC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6BB20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yfEDN2R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgA2JsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:48:18 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38148 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tdgu2B6VkKjHr97Y8fC+KukdGL6S2alhGVcqAPRvCZ8=; b=yfEDN2R2+5z1iS5UobX7oGhu6
        uQKOGb5MnqvVJgW7JMSmK6eQAw4mz7g0Xudql/QY7FFhPD/YR8r5MTJeQdLIbHNfm1F03x2l/qEq+
        VQFxR5CZ3SfJtiMdN4qC4Py6u7vn2ywU462tPtLL/Ew9DNP2BqCs6I8mhnWM8gPx9RKtfs/ki37kc
        AtuHlG0LYlQxtymcRYsiRW6LwtxEEdySYS92j9bavLUwEz9R9/2yNnc58PE81jlRH6Hppdqts7fnc
        4qNos28VZmis7T/XlTTA6JuaPXYCADMUrhkB008zKP21S9VUwufI2LZU9jfkXTCJLnN+tlqFQ09r+
        gNT1jw3qg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40686)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iwjwo-0004cD-0g; Wed, 29 Jan 2020 09:47:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iwjwg-0003Id-Df; Wed, 29 Jan 2020 09:47:38 +0000
Date:   Wed, 29 Jan 2020 09:47:38 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
Message-ID: <20200129094738.GE25745@shell.armlinux.org.uk>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 05:47:57PM +0300, Dmitry Osipenko wrote:
> 18.01.2020 02:22, Wei Yang пишет:
> > Use the general helper instead of do it by hand.
> > 
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  mm/mremap.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c2af8ba4ba43..a258914f3ee1 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  
> >  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
> >  		cond_resched();
> > -		next = (old_addr + PMD_SIZE) & PMD_MASK;
> > -		/* even if next overflowed, extent below will be ok */
> > +		next = pmd_addr_end(old_addr, old_end);
> >  		extent = next - old_addr;
> > -		if (extent > old_end - old_addr)
> > -			extent = old_end - old_addr;
> >  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
> >  		if (!old_pmd)
> >  			continue;
> > @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  
> >  		if (pte_alloc(new_vma->vm_mm, new_pmd))
> >  			break;
> > -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> > +		next = pmd_addr_end(new_addr, new_addr + len);
> >  		if (extent > next - new_addr)
> >  			extent = next - new_addr;
> >  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
> > 
> 
> Hello Wei,
> 
> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
> Tegra (ARM32):
> 
>   BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
> 
> and eventually kernel hangs.
> 
> Git's bisection points to this patch and reverting it helps. Please fix,
> thanks in advance.

The above is definitely wrong - pXX_addr_end() are designed to be used
with an address index within the pXX table table and the address index
of either the last entry in the same pXX table or the beginning of the
_next_ pXX table.  Arbitary end address indicies are not allowed.

When page tables are "rolled up" when levels don't exist, it is common
practice for these macros to just return their end address index.
Hence, if they are used with arbitary end address indicies, then the
iteration will fail.

The only way to do this is:

	next = pmd_addr_end(old_addr,
			pud_addr_end(old_addr,
				p4d_addr_end(old_addr,
					pgd_addr_end(old_addr, old_end))));

which gives pmd_addr_end() (and each of the intermediate pXX_addr_end())
the correct end argument.  However, that's a more complex and verbose,
and likely less efficient than the current code.

I'd suggest that there's nothing to "fix" in the v5.5 code wrt this,
and trying to "clean it up" will just result in less efficient or
broken code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
