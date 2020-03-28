Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA1DC2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8603E2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dPqibDBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1AjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:39:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1AjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:39:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so12060521ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ROVVm02F2mPkayCz7uQ6Dt9NevyTnSqVmIYy5v5l5Jo=;
        b=dPqibDBOUmASG5925G2ZlgjrRvuC2qrI228mL0pONlSIkjTZVmjRNI10vxw6i0+RtS
         mMp9hKI1cI7ktHlWzwwXBAn5utTfvn4sxIfc9m4PWyerh18JD3RigwK56fqr+0LpHMGm
         IYiI30XcYa7xLkVj4KfKQFWmOEJZ9mqXjZrizI+aywolJvreeLt06WeyLEQV1ayO4iI7
         IlOtAXKThyYguyIRozcWty4AqG7PYgqg9RQBFD6ruMffEC4KELmyvQme/yDuyaajd4M1
         gTaroYmiU0bCEvMkCuHyhLCuou/zn3sVW6HReVPpuyZy9kUINsqkNtL+c+t6pgKuNHuz
         vlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ROVVm02F2mPkayCz7uQ6Dt9NevyTnSqVmIYy5v5l5Jo=;
        b=lAFC0/O/FrSLp2az0nYkuRZ0InoZVSqKrbHCtvOnCitdMhIGt3NuZOaSlUSQq8Q1MI
         YtXin/iWSWAf0acRfkGZBSwXZt0D4I7K1eoO25d8AapItbaqbBT9gKWvcVqqlykU7iKj
         218l106LwoRnI8rFXkJftH5qmsi5afx9OhQaBNy6hcHdj3r9ozCLODjykZLAhvqUBMi9
         wZkIC+6dzPdwKFhZR7XDW/bHCfcdomdyg0KzV6EVIaY6R6lcJehR/RGmQLPrE0A5oolQ
         iQjeSARqxwR7MxpJnbgHGRtAFnTT8qjd3veT/FScFMSTmQWS51+Dgxe7vyNcS/NIbuhU
         R8XQ==
X-Gm-Message-State: AGi0PuY9N3LcdrhtAiT8ANxZGqi4G+3IRG1yjJW42bTvSfLeA3ETQRYn
        Idv92PuYYrj2XG3PJyAwEtY2qA==
X-Google-Smtp-Source: APiQypIjWcZmokSE8JnEIwfVDD63eD3JlED/W7CxFSGEv7rcd/wJ5hISLbAVMoOnxciWUNr43dpM9g==
X-Received: by 2002:a2e:b4e9:: with SMTP id s9mr892429ljm.108.1585355956345;
        Fri, 27 Mar 2020 17:39:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z5sm3608240lfq.71.2020.03.27.17.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:39:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2CFD1101C38; Sat, 28 Mar 2020 03:39:20 +0300 (+03)
Date:   Sat, 28 Mar 2020 03:39:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200328003920.xvkt3hp65uccsq7b@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 02:55:06PM -0400, Zi Yan wrote:
> On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:
> 
> > We can collapse PTE-mapped compound pages. We only need to avoid
> > handling them more than once: lock/unlock page only once if it's present
> > in the PMD range multiple times as it handled on compound level. The
> > same goes for LRU isolation and putpack.
> 
> s/putpack/putback/
> 
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b47edfe57f7b..c8c2c463095c 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
> >
> >  static void release_pte_page(struct page *page)
> >  {
> > +	/*
> > +	 * We need to unlock and put compound page on LRU only once.
> > +	 * The rest of the pages have to be locked and not on LRU here.
> > +	 */
> > +	VM_BUG_ON_PAGE(!PageCompound(page) &&
> > +			(!PageLocked(page) && PageLRU(page)), page);
> It only checks base pages.

That's the point.

> Add
> 
> VM_BUG_ON_PAGE(PageCompound(page) && PageLocked(page) && PageLRU(page), page);
> 
> to check for compound pages.

The compound page may be locked here if the function called for the first
time for the page and not locked after that (becouse we've unlocked it we
saw it the first time). The same with LRU.

> > +
> > +	if (!PageLocked(page))
> > +		return;
> > +
> > +	page = compound_head(page);
> >  	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> >  	unlock_page(page);
> >  	putback_lru_page(page);
> > @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >  	pte_t *_pte;
> >  	int none_or_zero = 0, result = 0, referenced = 0;
> >  	bool writable = false;
> > +	LIST_HEAD(compound_pagelist);
> >
> >  	for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
> >  	     _pte++, address += PAGE_SIZE) {
> > @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >  			goto out;
> >  		}
> >
> > -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> > +		VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +
> >  		if (PageCompound(page)) {
> > -			result = SCAN_PAGE_COMPOUND;
> > -			goto out;
> > -		}
> > +			struct page *p;
> > +			page = compound_head(page);
> >
> > -		VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +			/*
> > +			 * Check if we have dealt with the compount page
> 
> s/compount/compound/
> 

Thanks.

> > +			 * already
> > +			 */
> > +			list_for_each_entry(p, &compound_pagelist, lru) {
> > +				if (page ==  p)
> > +					break;
> > +			}
> > +			if (page ==  p)
> > +				continue;
> > +		}
> >
> >  		/*
> >  		 * We can do it before isolate_lru_page because the
> > @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >  		    page_is_young(page) || PageReferenced(page) ||
> >  		    mmu_notifier_test_young(vma->vm_mm, address))
> >  			referenced++;
> > +
> > +		if (PageCompound(page))
> > +			list_add_tail(&page->lru, &compound_pagelist);
> >  	}
> >  	if (likely(writable)) {
> >  		if (likely(referenced)) {
> 
> Do we need a list here? There should be at most one compound page we will see here, right?

Um? It's outside the pte loop. We get here once per PMD range.

'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:
it's just the last page handled in the loop.

> 
> If a compound page is seen here, can we bail out the loop early? I guess not,
> because we can a partially mapped compound page at the beginning or the end of a VMA, right?
> 
> > @@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
> >  			goto out_unmap;
> >  		}
> >
> > -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> > -		if (PageCompound(page)) {
> > -			result = SCAN_PAGE_COMPOUND;
> > -			goto out_unmap;
> > -		}
> > +		page = compound_head(page);
> >
> >  		/*
> >  		 * Record which node the original page is from and save this
> > -- 
> > 2.26.0
> 
> 
> —
> Best Regards,
> Yan Zi



-- 
 Kirill A. Shutemov
