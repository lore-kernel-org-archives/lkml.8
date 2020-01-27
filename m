Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102BBC35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B320842
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580093994;
	bh=Xxe6e1RbtGn4/jUYrlDkK2iVd7wbKVCAUBJPGAeGEvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GErZHlq9siHyKrwjYbvqERcvciLME7/IyWU8KlEuuPw8C+XhhSWEkCHxTPriccABr
	 UlvHrclQQvUzulQRmnG2AjrRyinrpTaS0y/RPSB2g055nDXqHF87YKRNCVcdqQXkEs
	 cyiWtlEEHoLRl4CcMBCGfbYk82xVVqPF2/e8o5gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgA0C7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgA0C7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:59:53 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6934F20720;
        Mon, 27 Jan 2020 02:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580093992;
        bh=Xxe6e1RbtGn4/jUYrlDkK2iVd7wbKVCAUBJPGAeGEvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pkR1ldAGILY7ByaZeZKE51wQBHl8Rev9VIgD1Rt2qUp2zzEeiDsmpCWuBmo3k3K/K
         zT01gJcoa9jeN+LW5t1rUwsYtJ8ULwZKlofyZvEhLrdRV9bcfQ3ZSiC39VrgC+r3vt
         SzwnOuNGl0WXlnG1/ar5Gqf5ncnnydrUK59NBVg4=
Date:   Sun, 26 Jan 2020 18:59:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
Message-Id: <20200126185951.c9246349befcccce210a4ab8@linux-foundation.org>
In-Reply-To: <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
        <20200117232254.2792-4-richardw.yang@linux.intel.com>
        <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020 17:47:57 +0300 Dmitry Osipenko <digetx@gmail.com> wrote:

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

Thanks.  I had these tagged for 5.7-rc1 anyway, so I'll drop all five
patches.

