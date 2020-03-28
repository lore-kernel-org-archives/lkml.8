Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20551C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7742071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fNWCum4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgC1Akd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:40:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45416 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Akd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:40:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so12087236ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+FisWhjqWo1PYA76QaCjNqAm84UyJGPrz4RPzV+5jag=;
        b=fNWCum4iIucDNFNtaTAo0xyU7ZzsBFF0ZNjfREajSDxvAovepQrRxQ0saZ/XgCWkaU
         tnuW7wFXQR2Y9XxPZpELDCckaiVYPBnY4nQQGaSS3BRlnZH78CZgqpKWvWpJZZIMtnEz
         iT9iBXzUFfwfxNCZuJBjWo5ZlPYbqOA0vosq+N/9nb6JJGC30WkDeVBsMRoYXNJRitMw
         WLgjIwj8icmlQk8trvjGNFNYRYTo5iZ9A4mvdD2CGey9ss0+/lNXTlzL6BCaJi7vmhdc
         lMo+uJpiAlKK8j08RMaUFJfD0fuJbJnQ0OkqMP/0O0Hu/LL5gLdGps8E/kJV9/KD45ar
         WWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+FisWhjqWo1PYA76QaCjNqAm84UyJGPrz4RPzV+5jag=;
        b=WX7aGcVs2BEnWpNBwMkoBVjd5DeysrN7rZBUXZxLBE1fguiyEfcwqfIfg5mf9VgLgC
         au07jXlAAPGKzQghD+DYM+ESXO23ghMCzUvYLxAJwvtInHk/IizIqc2bhryT+CjHBYRz
         bvr6wgrBNiA6KCam2g1TnkqJ1ER9JGpfkTGdl7IRgN++a2C7WfN1YOdJHoRASS9Kf28s
         ezBnDu6gJal93tV1azetwBtQ9nHImLJ/2NxVX73Bdsj0/6TbkTMrXImWWvNHDwf1inzz
         wD9n5PFj75KIZe8zmV0f4dA9CNkpasalQZDvf5x/XVWnbTXIVZVMf/Qh951ZabQ0iH4V
         /i1Q==
X-Gm-Message-State: AGi0PuZ2ZewyHyt7gUrpbfZi4qUxMdpgmKpPvz3VB/lj1AOiBP7lY8/X
        typCAzcyIVlKwuLJ8z0Bm2q3gQ==
X-Google-Smtp-Source: APiQypKII5PlcD+0XsbaFHGaLwcnfoyhNCINWx5abcH54LdNV/gY6lDr0VV7H7Glunh971IwSqNGmw==
X-Received: by 2002:a2e:b4cc:: with SMTP id r12mr889019ljm.50.1585356030580;
        Fri, 27 Mar 2020 17:40:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w29sm4119341lfq.27.2020.03.27.17.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:40:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7A757101C38; Sat, 28 Mar 2020 03:40:34 +0300 (+03)
Date:   Sat, 28 Mar 2020 03:40:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200328004034.jhzpqlv4riid27mh@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <CAHbLzkrc_QuAw2S0nNrTLRRx+EOkLodsf6W2czOFpNkryydcNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrc_QuAw2S0nNrTLRRx+EOkLodsf6W2czOFpNkryydcNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 01:45:55PM -0700, Yang Shi wrote:
> On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > We can collapse PTE-mapped compound pages. We only need to avoid
> > handling them more than once: lock/unlock page only once if it's present
> > in the PMD range multiple times as it handled on compound level. The
> > same goes for LRU isolation and putpack.
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
> > +       /*
> > +        * We need to unlock and put compound page on LRU only once.
> > +        * The rest of the pages have to be locked and not on LRU here.
> > +        */
> > +       VM_BUG_ON_PAGE(!PageCompound(page) &&
> > +                       (!PageLocked(page) && PageLRU(page)), page);
> > +
> > +       if (!PageLocked(page))
> > +               return;
> > +
> > +       page = compound_head(page);
> >         dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> >         unlock_page(page);
> >         putback_lru_page(page);
> 
> BTW, wouldn't this unlock the whole THP and put it back to LRU?

It is the intention.

> Then we may copy the following PTE mapped pages with page unlocked and
> on LRU. I don't see critical problem, just the pages might be on and off
> LRU by others, i.e. vmscan, compaction, migration, etc. But no one could
> take the page away since try_to_unmap() would fail, but not very
> productive.
> 
> 
> > @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >         pte_t *_pte;
> >         int none_or_zero = 0, result = 0, referenced = 0;
> >         bool writable = false;
> > +       LIST_HEAD(compound_pagelist);
> >
> >         for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
> >              _pte++, address += PAGE_SIZE) {
> > @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >                         goto out;
> >                 }
> >
> > -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> > +               VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +
> >                 if (PageCompound(page)) {
> > -                       result = SCAN_PAGE_COMPOUND;
> > -                       goto out;
> > -               }
> > +                       struct page *p;
> > +                       page = compound_head(page);
> >
> > -               VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +                       /*
> > +                        * Check if we have dealt with the compount page
> > +                        * already
> > +                        */
> > +                       list_for_each_entry(p, &compound_pagelist, lru) {
> > +                               if (page ==  p)
> > +                                       break;
> > +                       }
> > +                       if (page ==  p)
> > +                               continue;
> > +               }
> >
> >                 /*
> >                  * We can do it before isolate_lru_page because the
> > @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >                     page_is_young(page) || PageReferenced(page) ||
> >                     mmu_notifier_test_young(vma->vm_mm, address))
> >                         referenced++;
> > +
> > +               if (PageCompound(page))
> > +                       list_add_tail(&page->lru, &compound_pagelist);
> >         }
> >         if (likely(writable)) {
> >                 if (likely(referenced)) {
> > @@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
> >                         goto out_unmap;
> >                 }
> >
> > -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> > -               if (PageCompound(page)) {
> > -                       result = SCAN_PAGE_COMPOUND;
> > -                       goto out_unmap;
> > -               }
> > +               page = compound_head(page);
> >
> >                 /*
> >                  * Record which node the original page is from and save this
> > --
> > 2.26.0
> >
> >

-- 
 Kirill A. Shutemov
