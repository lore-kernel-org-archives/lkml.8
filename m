Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219CCC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEAA217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF3nVCry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDQD5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgDQD5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:57:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357CAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:57:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x2so994336qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yjtIAiLRvM4NhRSEzgKLtX4qOU01Sew7tR2ybuq7TBM=;
        b=gF3nVCryJgS7NA0Q7bcrhnJHEbsV4OAlqBMgdFTGO0P9jJdnkTTcVNoBnb3sDiZBdi
         rh9N5EnMMjm5zTWPHOfSNV+91sf97EG86LdM05hsOiPkgM2qXqtmmhvoFqmGeII17BZe
         hRbNuZa0I0X8LRE0jfY2jjm/PSLtfrxDDkKGa82VL2hz08Y3oe8Qad7D7e9L3DqtyZrX
         VrWyWiOcsR/Q1iXd9xj1as4t6qfBAn7gY/MPEfZO08Te+uQRPYUzvVaXoVVqsRcGtmM2
         ccyiD8H9uEEbL97e8hU9uNJi0jCQ6ekWQadgDDszipjEnBqr6hwTgRWXS/k+E4ZIlQXI
         Ns8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yjtIAiLRvM4NhRSEzgKLtX4qOU01Sew7tR2ybuq7TBM=;
        b=N+OekQ1gUZ7HVUOwdVAuVaYeJU60liDDLU5XYf9Uc1tm02NKN+gH/r2HcIpv/SPUVA
         gji8w1PWWHX55YWsuG0ZKPAKNm4UG5UkxlCbZqI/c6uWu6sXaTyo1eCmunCJDVGPRgaa
         mZt/cN/3kv96eWdNW/2vu9NVcnEg3l7EboM3TUULVVys6i7fR998abooTpJ0UXL8oZfH
         iBpmN4lkSNrN83vzFMy28jX1lOb/QByMpWJusEe9By7zpb1JYP7XsGIpdAfGsG5rdFf+
         qfHd3NT5JnV/rvxbCJUWNKl8x5/1HQkVjMnCpY6Y+YlKCJPJQ4F/pYimyUViUPynA4t8
         I27A==
X-Gm-Message-State: AGi0PuY6mOVHu2Ej4UgkWrbwAOUZvIkiy9nGqCLBFCcUmZwENMwSu4WR
        /FM4lPGY3O8ToVxWnQ0SR8ZG8E42DheDM0GrGXY=
X-Google-Smtp-Source: APiQypKkU13IgXX5+0X25ICcUavl/O5CzSKXCNQKMTt5W0YNktF38dQ+Afii6oFv07fHUV+xiHFiumWxG+weZ+AMYos=
X-Received: by 2002:ac8:2ac6:: with SMTP id c6mr1097238qta.35.1587095842162;
 Thu, 16 Apr 2020 20:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200416161133.GA178028@cmpxchg.org> <CAAmzW4M5EBXDarx-Xkryrf+BKgdOJqBr7aBaB=4P3gBRN-v30Q@mail.gmail.com>
 <20200417033116.GJ195132@cmpxchg.org>
In-Reply-To: <20200417033116.GJ195132@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 17 Apr 2020 12:57:11 +0900
Message-ID: <CAAmzW4MWwDwqtXukHZ48g9O40DPJeidJmKdG5pMV4k9TefMfkQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:31, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Apr 17, 2020 at 10:38:53AM +0900, Joonsoo Kim wrote:
> > 2020=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:1=
1, Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > Hello Joonsoo,
> > >
> > > On Fri, Apr 03, 2020 at 02:40:43PM +0900, js1304@gmail.com wrote:
> > > > @@ -112,7 +112,7 @@ void show_swap_cache_info(void)
> > > >   * but sets SwapCache flag and private instead of mapping and inde=
x.
> > > >   */
> > > >  int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > > > -                     gfp_t gfp, void **shadowp)
> > > > +                     struct vm_area_struct *vma, gfp_t gfp, void *=
*shadowp)
> > > >  {
> > > >       struct address_space *address_space =3D swap_address_space(en=
try);
> > > >       pgoff_t idx =3D swp_offset(entry);
> > > > @@ -120,14 +120,26 @@ int add_to_swap_cache(struct page *page, swp_=
entry_t entry,
> > > >       unsigned long i, nr =3D compound_nr(page);
> > > >       unsigned long nrexceptional =3D 0;
> > > >       void *old;
> > > > +     bool compound =3D !!compound_order(page);
> > > > +     int error;
> > > > +     struct mm_struct *mm =3D vma ? vma->vm_mm : current->mm;
> > > > +     struct mem_cgroup *memcg;
> > > >
> > > >       VM_BUG_ON_PAGE(!PageLocked(page), page);
> > > >       VM_BUG_ON_PAGE(PageSwapCache(page), page);
> > > >       VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
> > > >
> > > >       page_ref_add(page, nr);
> > > > +     /* PageSwapCache() prevent the page from being re-charged */
> > > >       SetPageSwapCache(page);
> > > >
> > > > +     error =3D mem_cgroup_try_charge(page, mm, gfp, &memcg, compou=
nd);
> > > > +     if (error) {
> > > > +             ClearPageSwapCache(page);
> > > > +             page_ref_sub(page, nr);
> > > > +             return error;
> > > > +     }
> > > > +
> > > >       do {
> > > >               xas_lock_irq(&xas);
> > > >               xas_create_range(&xas);
> > > > @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_=
entry_t entry,
> > > >               xas_unlock_irq(&xas);
> > > >       } while (xas_nomem(&xas, gfp));
> > > >
> > > > -     if (!xas_error(&xas))
> > > > +     if (!xas_error(&xas)) {
> > > > +             mem_cgroup_commit_charge(page, memcg, false, compound=
);
> > >
> > > Unfortunately you cannot commit here yet because the rmap isn't set u=
p
> > > and that will cause memcg_charge_statistics() to account the page
> > > incorrectly as file. And rmap is only set up during a page fault.
> >
> > I also found this problem a few days ago. In my investigation, what we =
need for
> > anonymous page to make accounting correct is a way to find the type of =
the page,
> > file or anon, since there is no special code to use the rmap. And, I
> > think that it
> > could be done by checking NULL mapping or something else.
>
> page->mapping is NULL for truncated file pages, file pages before they
> are inserted into the page cache, and anon pages before the rmap. It's
> not straight-forward to robustly tell those apart inside memcg.

Okay.

> But fundamentally, it's a silly problem to fix. We only need to tell
> page types apart to maintain the MEMCG_CACHE and MEMCG_RSS
> counters. But these are unnecessary duplicates of the NR_FILE_PAGES
> and NR_ANON_MAPPED vmstat counters - counters for which we already
> have accounting sites in generic code, and that already exist in the
> per-cgroup vmstat arrays. We just need to link them.
>
> So that's what I'm fixing instead: I'm adjusting the charging sequence
> slightly so that page->mem_cgroup is stable when the core VM code
> accounts pages by type. And then I'm hooking into these places with
> mod_lruvec_page_state and friends, and ditching MEMCG_CACHE/MEMCG_RSS.
>
> After that, memcg doesn't have to know about the types of pages at
> all. It can focus on maintaining page_counters and page->mem_cgroup,
> and leave the vmstat breakdown to generic VM code.
>
> Then we can charge pages right after allocation, regardless of type.
>
> [ Eventually, the memcg accounting interface shouldn't be much more
>   than GFP_ACCOUNT (with memalloc_use_memcg() for faults, swap etc.),
>   and the vmstat hooks. My patches don't quite get there, but that's
>   the direction they're pushing. ]

Thanks for explanation! It will help me understand your future patches.

> > Is there anything I missed? And, I cannot find the function,
> > memcg_charge_statistics(). Please let me know the file name of this
> > function.
>
> The correct name is mem_cgroup_charge_statistics(), my apologies.

No problem.

> > > This needs a bit of a rework of the memcg charging code that appears
> > > out of scope for your patches. I'm preparing a series right now to do
> > > just that. It'll also fix the swap ownership tracking problem when th=
e
> > > swap controller is disabled, so we don't have to choose between
> > > charging the wrong cgroup or hampering swap readahead efficiency.
> >
> > Sound good! I also think that these patches are out of scope of my seri=
es.
> > I will wait your patches. Could you let me know when your series is sub=
mitted?
> > I'd like to plan my work schedule based on your patch schedule.
>
> I just finished the first draft of the series a few minutes ago. I'll
> polish it a bit, make sure it compiles etc. ;-), and send it out for
> review, testing and rebasing, hopefully tomorrow or early next week.

Sound good! See you again next week. :)

Thanks.
