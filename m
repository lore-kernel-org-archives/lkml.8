Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A8C2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71B02078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDvQetHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgC3Sio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:38:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39728 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgC3Sio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:38:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so21999999edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auR3E1Pbe5ms+A8CKWhsPDMUJpxtg8PJQEwEFgJ+SYk=;
        b=YDvQetHR48Kn7wAbs6+f366X+rtfGTaImZR8UdL4UiZmZw8o49rMkiAOh4Jo3CxvdM
         xUK9JGKpkYiZvehaQVqrm3XwwSzQvVtJkWMcaAN5S+aTqSGcHYmYuAG120pSdrcGErE2
         G9nrHY8fsrc3e9zeHmVOSvIHMtKZfd5T5B0DP1jIs/NDncc588BP8b3+rC0GUWj5+fsq
         vQVt+10p6vdLW/1ZtKcHHRRmCYU/BhSQ+4/l9UVTqFMZUojCANzYT0h6hAitTW0gzjEM
         WeGYZxnunGRDm+FptRrOzq2oETQxNY+UsqHzY6ZPNzTt1hsURa4AA4z+E/pIpN9GWEg0
         NUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auR3E1Pbe5ms+A8CKWhsPDMUJpxtg8PJQEwEFgJ+SYk=;
        b=PYnby/T8d0KgkBu6jnDFb/Bv5mpIAiziYw8pVOwjqtnIjIzBJnyH7byjOWzBX44pNz
         s5V1cM8dR4TTBje0USwCYV5Ufpq5sl0UPdN0nUpxDOKJBHPvqoNjGCt/TZcJbnV+iEiE
         Nat+cNKzqw0poRtnjLsFp7ki/4K0oU95eLnUJfWRn+PrSqY/F1pahylxlMyQwt2+W188
         H5neXLlb/EAS5WtiJVtmG9QmAJXLAwodNjnALr39wr7SBsnaoEy9JNy8j74FVsPJrLCm
         KNbx6AfhW/Jw7BnGRmbMJDR/byGu8GSRtUPiuX+8vz23NbXXWPQQT1cvKWKPZt21m+t+
         LgBA==
X-Gm-Message-State: ANhLgQ3sso/3px+jJkAE+hE3F+jHYizUdEZUwVV3U5Fm/1M/r2II28jw
        5Fm1D7xxXj7r3BPUhsw7SjeMN3PA9SoQCkmAzW+MkhE2kgI=
X-Google-Smtp-Source: ADFU+vtvIuLBIin0OCR6AZtwlv5OzR4Fkkt0xu3NAZHRjPzPO3kHQZGwQw6sqK74czIBQ8WcqeI62BinT2x8ajjcVzg=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr12486683edf.372.1585593522745;
 Mon, 30 Mar 2020 11:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
 <20200328003424.kusu2xnhnlbmnfzl@box> <CAHbLzkpV7=EGQVeEEZ_jhpWa-nnVkiZ4_Qa=0KoZCRntprWhgg@mail.gmail.com>
 <20200328122735.nzius2ikvnyvpf2f@box>
In-Reply-To: <20200328122735.nzius2ikvnyvpf2f@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Mar 2020 11:38:30 -0700
Message-ID: <CAHbLzkr+=rKvt4wTocFR2FoY+2EB9qctTPj0QD58tugMYTc3NQ@mail.gmail.com>
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

On Sat, Mar 28, 2020 at 5:27 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Mar 27, 2020 at 06:09:38PM -0700, Yang Shi wrote:
> > On Fri, Mar 27, 2020 at 5:34 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Fri, Mar 27, 2020 at 11:53:57AM -0700, Yang Shi wrote:
> > > > On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> > > > <kirill@shutemov.name> wrote:
> > > > >
> > > > > We can collapse PTE-mapped compound pages. We only need to avoid
> > > > > handling them more than once: lock/unlock page only once if it's present
> > > > > in the PMD range multiple times as it handled on compound level. The
> > > > > same goes for LRU isolation and putpack.
> > > > >
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > ---
> > > > >  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
> > > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index b47edfe57f7b..c8c2c463095c 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
> > > > >
> > > > >  static void release_pte_page(struct page *page)
> > > > >  {
> > > > > +       /*
> > > > > +        * We need to unlock and put compound page on LRU only once.
> > > > > +        * The rest of the pages have to be locked and not on LRU here.
> > > > > +        */
> > > > > +       VM_BUG_ON_PAGE(!PageCompound(page) &&
> > > > > +                       (!PageLocked(page) && PageLRU(page)), page);
> > > > > +
> > > > > +       if (!PageLocked(page))
> > > > > +               return;
> > > > > +
> > > > > +       page = compound_head(page);
> > > > >         dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> > > >
> > > > We need count in the number of base pages. The same counter is
> > > > modified by vmscan in base page unit.
> > >
> > > Is it though? Where?
> >
> > __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken) in
> > vmscan.c, here nr_taken is nr_compound(page), so if it is THP the
> > number would be 512.
>
> Could you point a particular codepath?

shrink_inactive_list ->
        nr_taken = isolate_lru_pages()
        __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);

Then in isolate_lru_pages() :
        nr_pages = compound_nr(page);
        ...
        switch (__isolate_lru_page(page, mode)) {
                case 0:
                        nr_taken += nr_pages;

>
> > So in both inc and dec path of collapse PTE mapped THP, we should mod
> > nr_compound(page) too.
>
> I disagree. Compound page is represented by single entry on LRU, so it has
> to be counted once.

It was not a problem without THP swap. But with THP swap we saw
pgsteal_{kswapd|direct} may be greater than pgscan_{kswapd|direct} if
we count THP as one page.

Please refer to the below commit:

commit 98879b3b9edc1604f2d1a6686576ef4d08ed3310
Author: Yang Shi <yang.shi@linux.alibaba.com>
Date:   Thu Jul 11 20:59:30 2019 -0700

    mm: vmscan: correct some vmscan counters for THP swapout

    Commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped
    out"), THP can be swapped out in a whole.  But, nr_reclaimed and some
    other vm counters still get inc'ed by one even though a whole THP (512
    pages) gets swapped out.

    This doesn't make too much sense to memory reclaim.

    For example, direct reclaim may just need reclaim SWAP_CLUSTER_MAX
    pages, reclaiming one THP could fulfill it.  But, if nr_reclaimed is not
    increased correctly, direct reclaim may just waste time to reclaim more
    pages, SWAP_CLUSTER_MAX * 512 pages in worst case.

    And, it may cause pgsteal_{kswapd|direct} is greater than
    pgscan_{kswapd|direct}, like the below:

    pgsteal_kswapd 122933
    pgsteal_direct 26600225
    pgscan_kswapd 174153
    pgscan_direct 14678312

    nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
    break some page reclaim logic, e.g.

    vmpressure: this looks at the scanned/reclaimed ratio so it won't change
    semantics as long as scanned & reclaimed are fixed in parallel.

    compaction/reclaim: compaction wants a certain number of physical pages
    freed up before going back to compacting.

    kswapd priority raising: kswapd raises priority if we scan fewer pages
    than the reclaim target (which itself is obviously expressed in order-0
    pages).  As a result, kswapd can falsely raise its aggressiveness even
    when it's making great progress.

    Other than nr_scanned and nr_reclaimed, some other counters, e.g.
    pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed too
    since they are user visible via cgroup, /proc/vmstat or trace points,
    otherwise they would be underreported.

    When isolating pages from LRUs, nr_taken has been accounted in base page,
    but nr_scanned and nr_skipped are still accounted in THP.  It doesn't make
    too much sense too since this may cause trace point underreport the
    numbers as well.

    So accounting those counters in base page instead of accounting THP as one
    page.

    nr_dirty, nr_unqueued_dirty, nr_congested and nr_writeback are used by
    file cache, so they are not impacted by THP swap.

    This change may result in lower steal/scan ratio in some cases since THP
    may get split during page reclaim, then a part of tail pages get reclaimed
    instead of the whole 512 pages, but nr_scanned is accounted by 512,
    particularly for direct reclaim.  But, this should be not a significant
    issue.


So, since we count THP in base page unit in vmscan path, so the same
counter should be updated in base page unit in other path as well
IMHO.


>
> --
>  Kirill A. Shutemov
