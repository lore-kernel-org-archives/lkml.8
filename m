Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385DBC2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B132073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mU9ZKIun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgC1AeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:34:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42446 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgC1AeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:34:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so9336117lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3yPrNifDefU0IFJdETWJaD75V/HE4NsiLg4PeOLg+pA=;
        b=mU9ZKIunZTIWCrvB71sJG/cnS7xx/lt4diC09Q+VCL5wmBu4ORkFKbgK0yvsCC2Ipv
         g4E5FLrgFsMBnS1vCo+0pLUKy2Bbm+tm65gDfSeJfUdh/e2dFDOmQgIr98L50LV+QlNo
         yYMQ9/CUHz7B/5BTuXBBmThdxhZasKbYOZok+qFNWUSxNHyDV58WCnpcfhvTSepAYMCs
         AhtzneLAyI8kz7HlHgr7xWRX5Xz0Mn5BoAYpChNyFydhAbBEESbevLK3PjMnQSZJmMZF
         YnXBB7lgLg3j/Z9+uhhAjGNIoRH5U5DAvoUkD73mSu0NUW97AA96gSPajhuEtTS5Nnxr
         ++Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yPrNifDefU0IFJdETWJaD75V/HE4NsiLg4PeOLg+pA=;
        b=K7CqPzU+wQ0UrlWCwfbHn1mNrRottCFz+IVo+xLMkUY90U7u4Kwl+5AW2XOEnxrJiW
         6/HCzJioKuWe0zHZAHDO2TOL7ONlDrrAKGvCLEfI4++++GUrP6bArCRpZRN1fbJ5b2Pm
         P6f6cgBC15ssdgJj657BZv5Ft0AA//c4655U8eAJNuzMKd+pvg8XXXWxqKwdYY6p72uq
         Yx1P5FNfATtmUrdb5R+p/jDUQ1z2efjvUcGShtAS0KVCdfISavft3Qizux4JmQIZg1m8
         28KDmIy/CVnbwxSCqPpS92SqpzZ0VlGIJ/dm9CnQrO9BLQHK967i3M4RatnDnGeuXTQg
         Nn8g==
X-Gm-Message-State: AGi0PuZ0tqkFk7dOrDvt5R6wOsKbDRPLWkte7VaZfFIo/UBORGqNgOEg
        DL8EI5mp6SVbgwZ7HRK+/xNebw==
X-Google-Smtp-Source: APiQypIvqujSGnChOUDlJCVYwMYwtFjGQnPmjCgQijowxE6ZMwmyX2G46YKaTwuq5mHrWBRBYROo/A==
X-Received: by 2002:ac2:4433:: with SMTP id w19mr1136860lfl.53.1585355660840;
        Fri, 27 Mar 2020 17:34:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f9sm1297991ljp.88.2020.03.27.17.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:34:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 96A28101C38; Sat, 28 Mar 2020 03:34:24 +0300 (+03)
Date:   Sat, 28 Mar 2020 03:34:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200328003424.kusu2xnhnlbmnfzl@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:53:57AM -0700, Yang Shi wrote:
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
> 
> We need count in the number of base pages. The same counter is
> modified by vmscan in base page unit.

Is it though? Where?

> Also need modify the inc path.

Done already.

> >         unlock_page(page);
> >         putback_lru_page(page);
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
> 
> s/compount/compound

Thanks.

> > +                        * already
> > +                        */
> > +                       list_for_each_entry(p, &compound_pagelist, lru) {
> > +                               if (page ==  p)
> > +                                       break;
> > +                       }
> > +                       if (page ==  p)
> > +                               continue;
> 
> I don't quite understand why we need the above check. My understanding
> is when we scan the ptes, once the first PTE mapped subpage is found,
> then the THP would be added into compound_pagelist, then the later
> loop would find the same THP on the list then just break the loop. Did
> I miss anything?

We skip the iteration and look at the next pte. We've already isolated the
page. Nothing to do here.

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
