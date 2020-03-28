Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A03C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9C1206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWtvDPul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1BMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:12:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgC1BMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:12:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so13594977edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 18:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNo3FndSyfgarKuL3MCerw7v/TlJBnMEpF3pRFegZd8=;
        b=tWtvDPulZTijBQTjNmE7bkdsRPhUcHte5hyy3c8P2W4w2wTvIPMLBmpbrc7qq3zQz/
         n8mKnFt7gwbUSKWrjiPX5hzOCXlquyHcU4imjvsNXSmXfx4N+pCb3AA1BwpyRT7WtRFB
         Qabnk6WQjtGOrkOjawTXG9AgidQFq3lp8Qmf1oVNzexRSnOg4PiTKv0Cx5DoDQ5vcMVd
         lGg9MYX+G+h+CTyzVzBXQ7MYvk3G9gzmSgG/alDuTA1jk49StTfbGYZ6eYLVrMbYO8iV
         VElIrplPuphAxfofFuo5VPPV840b0TtPzCrdoeu87k2p3mChJpbv0cwTBR11IsPvpIUt
         tlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNo3FndSyfgarKuL3MCerw7v/TlJBnMEpF3pRFegZd8=;
        b=KOCFsuT7LrIifU5QTUQNoIVME7dQHq1VfCtlOuzXu24cb8xNALNvRCojdidusUjDc/
         N728Gq1qlsNcWfzAAuVyFZmyVT/gQU82z9KYddqcJs8pib9TUemNfOLGCC6261msDRIM
         usZslkiEpz4SegVV3BO5LtVXge0j7IYAmD56C2iRrFLkrn3pIDNrFV3xZzWL0heV/B+H
         fVecCYcdETXmxBIl5HKcyv1ktdhXJ9tohcxPE9qppeQU10CSb9odEPfw5TLCcCSyHTXO
         opGRiOXVFDsgeNcXj0PwD7SEBmqGEbevO1sSCLn/s19L1CXRGnkx5paDxHViDBeMetM1
         itAA==
X-Gm-Message-State: ANhLgQ169Zt2xZpsR3uJk9/g2rY1tfALsQyasGgUmccotMeP+W85lR+C
        WXkcsWpKWSr4AcQpyC04KXEISx5jRhOWV5rp1Kk=
X-Google-Smtp-Source: ADFU+vsjkkjozkJZ/73vwdd9BT1pIEGMorPAdKeDZoa88lo1RTqQNuR1BOz9ZdZVzpaADcK0S0BRZVAFKhwKE36NQto=
X-Received: by 2002:a50:c948:: with SMTP id p8mr1883047edh.200.1585357960413;
 Fri, 27 Mar 2020 18:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <CAHbLzkrc_QuAw2S0nNrTLRRx+EOkLodsf6W2czOFpNkryydcNQ@mail.gmail.com>
 <20200328004034.jhzpqlv4riid27mh@box>
In-Reply-To: <20200328004034.jhzpqlv4riid27mh@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 18:12:28 -0700
Message-ID: <CAHbLzkrtCAi+uKSR77PZc8_gWGE1RjrgMZvQUNXBwt0ZHGk67Q@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 5:40 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Mar 27, 2020 at 01:45:55PM -0700, Yang Shi wrote:
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
> > >         unlock_page(page);
> > >         putback_lru_page(page);
> >
> > BTW, wouldn't this unlock the whole THP and put it back to LRU?
>
> It is the intention.

Yes, understood. Considering the below case:

Subpages 0, 1, 2, 3 are PTE mapped. Once subpage 0 is copied
release_pte_page() would be called then the whole THP would be
unlocked and putback to lru, then the loop would iterate to subpage 1,
2 and 3, but the page is not locked and on lru already. Is it
intentional?

>
> > Then we may copy the following PTE mapped pages with page unlocked and
> > on LRU. I don't see critical problem, just the pages might be on and off
> > LRU by others, i.e. vmscan, compaction, migration, etc. But no one could
> > take the page away since try_to_unmap() would fail, but not very
> > productive.
> >
> >
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
> > > +                        * already
> > > +                        */
> > > +                       list_for_each_entry(p, &compound_pagelist, lru) {
> > > +                               if (page ==  p)
> > > +                                       break;
> > > +                       }
> > > +                       if (page ==  p)
> > > +                               continue;
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
