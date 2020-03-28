Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC9DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4B206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovFSqBoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgC1BJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:09:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44062 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgC1BJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:09:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id i16so12643703edy.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oywFlXkpECcbU8r3G346Xkwhx0P/bQHXz/zk7kN32ng=;
        b=ovFSqBoKd0wRBeT84kbfutSS9+6vH+PbxJ/vACOA/FZ1t+Rp4BhunGNaWhJzQGuzwJ
         JWNNdgm33e+wttmPMBUz17vrltb5C7Itb1U/nHB75Mqhj+INEt4LHR3CvEKlmbHewsCe
         l/+H5DASwMZr9Q/sn9MWL8Cr8rKxwMlQlbFH1Wcn8njzh+OvXbAugr88jucEDaIfx8cU
         jk8CCulyyr9s06hXqg0cSUxjJPzPoX9lla88cSK6QToyBrLpCtZPZ88uNZLlNWTqk/a0
         wBeERsYVNjlWw+f50GEEUDvE/mDTlwXzOm3DVRw1AqbDZriv+f0+qzKjbLcBQkivw9+/
         WTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oywFlXkpECcbU8r3G346Xkwhx0P/bQHXz/zk7kN32ng=;
        b=A8Ok19xQeKxLPJhu/hs3bmthInWxF3L6TM9ujdg7S+bfwIt6uXvzWLpDpVj4NfQzRi
         ow/PsoUhdaMUTidjSBm9ony2cusvLf8rAQKm9CD03t1KBonL6NgwbuKSMGF5plGC+A5g
         r6GpKU0iO2YQ+kVANljLR9RCO+EsHCpmApXh4UlFCNiW2Z4LZfi8UqB+xeiUMlo23xbK
         JLw5Nub31efvM5fXYlUJSEnM/6DwR4kbmH4AkPtXtEV4Hi6LGXcpDyvkO7mQR8YbJshm
         5GoLoj6cvwRPBjZKeMT1krt8JGGix1F/2t5fvyOEznRxOt+RB7yQ2BDNrDJZno6alDt3
         ceIQ==
X-Gm-Message-State: ANhLgQ09ufvusdu3c+fCXHE9qpzrzSIUIAKPLy0lYlPHlNQhSaGwAGwz
        +XpjFnb46gWJGCNNlQCEPdQnSXwqORvx+0k2HUg=
X-Google-Smtp-Source: ADFU+vv3peC08Yn2tgacy2h+ClB4pfZzrudknI0uEuZ0N4TWCRPQEwOvHlo2PNRSPch9lbRA1a1BlPt0gjd85Mg2mvM=
X-Received: by 2002:a50:930e:: with SMTP id m14mr1738617eda.256.1585357790797;
 Fri, 27 Mar 2020 18:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
 <20200328003424.kusu2xnhnlbmnfzl@box>
In-Reply-To: <20200328003424.kusu2xnhnlbmnfzl@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 18:09:38 -0700
Message-ID: <CAHbLzkpV7=EGQVeEEZ_jhpWa-nnVkiZ4_Qa=0KoZCRntprWhgg@mail.gmail.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 5:34 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Mar 27, 2020 at 11:53:57AM -0700, Yang Shi wrote:
> > On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > >
> > > We can collapse PTE-mapped compound pages. We only need to avoid
> > > handling them more than once: lock/unlock page only once if it's present
> > > in the PMD range multiple times as it handled on compound level. The
> > > same goes for LRU isolation and putpack.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
> > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index b47edfe57f7b..c8c2c463095c 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
> > >
> > >  static void release_pte_page(struct page *page)
> > >  {
> > > +       /*
> > > +        * We need to unlock and put compound page on LRU only once.
> > > +        * The rest of the pages have to be locked and not on LRU here.
> > > +        */
> > > +       VM_BUG_ON_PAGE(!PageCompound(page) &&
> > > +                       (!PageLocked(page) && PageLRU(page)), page);
> > > +
> > > +       if (!PageLocked(page))
> > > +               return;
> > > +
> > > +       page = compound_head(page);
> > >         dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> >
> > We need count in the number of base pages. The same counter is
> > modified by vmscan in base page unit.
>
> Is it though? Where?

__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken) in
vmscan.c, here nr_taken is nr_compound(page), so if it is THP the
number would be 512.

So in both inc and dec path of collapse PTE mapped THP, we should mod
nr_compound(page) too.

>
> > Also need modify the inc path.
>
> Done already.
>
> > >         unlock_page(page);
> > >         putback_lru_page(page);
> > > @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >         pte_t *_pte;
> > >         int none_or_zero = 0, result = 0, referenced = 0;
> > >         bool writable = false;
> > > +       LIST_HEAD(compound_pagelist);
> > >
> > >         for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
> > >              _pte++, address += PAGE_SIZE) {
> > > @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >                         goto out;
> > >                 }
> > >
> > > -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> > > +               VM_BUG_ON_PAGE(!PageAnon(page), page);
> > > +
> > >                 if (PageCompound(page)) {
> > > -                       result = SCAN_PAGE_COMPOUND;
> > > -                       goto out;
> > > -               }
> > > +                       struct page *p;
> > > +                       page = compound_head(page);
> > >
> > > -               VM_BUG_ON_PAGE(!PageAnon(page), page);
> > > +                       /*
> > > +                        * Check if we have dealt with the compount page
> >
> > s/compount/compound
>
> Thanks.
>
> > > +                        * already
> > > +                        */
> > > +                       list_for_each_entry(p, &compound_pagelist, lru) {
> > > +                               if (page ==  p)
> > > +                                       break;
> > > +                       }
> > > +                       if (page ==  p)
> > > +                               continue;
> >
> > I don't quite understand why we need the above check. My understanding
> > is when we scan the ptes, once the first PTE mapped subpage is found,
> > then the THP would be added into compound_pagelist, then the later
> > loop would find the same THP on the list then just break the loop. Did
> > I miss anything?
>
> We skip the iteration and look at the next pte. We've already isolated the
> page. Nothing to do here.

I got your point. Thanks.

>
> > > +               }
> > >
> > >                 /*
> > >                  * We can do it before isolate_lru_page because the
> > > @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >                     page_is_young(page) || PageReferenced(page) ||
> > >                     mmu_notifier_test_young(vma->vm_mm, address))
> > >                         referenced++;
> > > +
> > > +               if (PageCompound(page))
> > > +                       list_add_tail(&page->lru, &compound_pagelist);
> > >         }
> > >         if (likely(writable)) {
> > >                 if (likely(referenced)) {
> > > @@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
> > >                         goto out_unmap;
> > >                 }
> > >
> > > -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> > > -               if (PageCompound(page)) {
> > > -                       result = SCAN_PAGE_COMPOUND;
> > > -                       goto out_unmap;
> > > -               }
> > > +               page = compound_head(page);
> > >
> > >                 /*
> > >                  * Record which node the original page is from and save this
> > > --
> > > 2.26.0
> > >
> > >
>
> --
>  Kirill A. Shutemov
