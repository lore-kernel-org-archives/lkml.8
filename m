Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D8E2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLBvHkLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgEWNzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbgEWNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:55:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA2C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:55:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so564304ioe.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0hCwA7JT4X1b7+zad20E8g0U+y7W7iuywlvSyNnvCU=;
        b=jLBvHkLrjVGhDJAT27jK7QCt/N3HEh2eL7QU0V+B5Jn0WlyR/s+jOq+sN9bviIaHLu
         ekGjNj0X9+pI2jwqEt4twdP910Gb7pZ47jgDKUOVGHvwr8Uo525eTRaQXnCv2AcYT+uM
         moi4SMIcOkFZxnI2GpJSyImmQaJ+0CRgnaODi/fUNo4FCgiND77oKAQJ24Xf0hkDOXxP
         nm00cUAZI4AaQL12TdVs00lFdNbwZJn4Svd2ZvD1E17CfM2fikrVOSgk5VL9xUWeMJds
         W/eESM2TtfWzLJRLwdnP5n91i5laW1ZekL2Snq0iVm2BkHvSQQNqEIY1ENHiBrvyATKU
         ZnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0hCwA7JT4X1b7+zad20E8g0U+y7W7iuywlvSyNnvCU=;
        b=TcgwB4qIZbf5eJSw+hFJEYRwTYDjPVTwFRzOSEUMhnXKZ3CE0fCSEj+G/391tT1l4a
         aTIUnCxEPZfO1YFilIjOLkMS7kHc9h26SzdQ17m+2YqHSsS2brnMS8e9xyvlEzMUFhzS
         yW5ejftpRls9gADf2De44nmbv0B8pvrvcQ4wBHS35m94xuTLifTkTxu2DsIkvTm/r0p4
         UrB49xrpbGxqKrV6eU1vnL7RlRRrx6DYx/VMyyN0z0g4SqhyYvS2xW9MBmbwgspLcQG/
         8g5sMy7IztBQLNh/A4sa1cSYOGnGk0WkE1stRPsynEWOmZKcWptrX08AI7SNBwMmWOuA
         QFsg==
X-Gm-Message-State: AOAM530uyGx0nC0SCxNNfhFdmKi8uX7zF+Z8p0Pr/DQjz44G4aOkj5MK
        fvCT7WGemM7iIIGpx08qfMrMz4mJsiz8sTQ1QEg=
X-Google-Smtp-Source: ABdhPJz3FNaa1tUxEm72nt/SVvmaXMw5WY9PwFDKcasixhxBQig7eWsF+uutnrChp8XvwH+HFHXcYgYtVM7DNuv0TOw=
X-Received: by 2002:a05:6638:bc4:: with SMTP id g4mr12353671jad.55.1590242111991;
 Sat, 23 May 2020 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <158937872515.474360.5066096871639561424.stgit@buzz> <20200522183421.7c52ba9650a2ad11cec2be8d@linux-foundation.org>
In-Reply-To: <20200522183421.7c52ba9650a2ad11cec2be8d@linux-foundation.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 23 May 2020 16:55:30 +0300
Message-ID: <CALYGNiMGsfBe50MEvV9Cd+e=z6Zc9sgFG4dE3iY=Ekv8fP5s7w@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in page_mapcount()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 4:34 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 May 2020 17:05:25 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>
> > Function isolate_migratepages_block() runs some checks out of lru_lock
> > when choose pages for migration. After checking PageLRU() it checks extra
> > page references by comparing page_count() and page_mapcount(). Between
> > these two checks page could be removed from lru, freed and taken by slab.
> >
> > As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> > Race window is tiny. For certain workload this happens around once a year.
> >
> >
> >  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
> >  flags: 0x500000000008100(slab|head)
> >  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
> >  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
> >  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
> >  ------------[ cut here ]------------
> >  kernel BUG at ./include/linux/mm.h:628!
> >  invalid opcode: 0000 [#1] SMP NOPTI
> >  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
> >  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
> >  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> >
> >
> > To fix just opencode page_mapcount() in racy check for 0-order case and
> > recheck carefully under lru_lock when page cannot escape from lru.
> >
> > Also add checking extra references for file pages and swap cache.
>
> I dunno, this code looks quite nasty.  I'm more thinking we should
> revert and rethink David's 119d6d59dcc0980dcd58 ("mm, compaction: avoid
> isolating pinned pages").
>
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >               }
> >
> >               /*
> > -              * Migration will fail if an anonymous page is pinned in memory,
> > +              * Migration will fail if an page is pinned in memory,
> >                * so avoid taking lru_lock and isolating it unnecessarily in an
> > -              * admittedly racy check.
> > +              * admittedly racy check simplest case for 0-order pages.
> > +              *
> > +              * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
> > +              * Page could have extra reference from mapping or swap cache.
> >                */
> > -             if (!page_mapping(page) &&
> > -                 page_count(page) > page_mapcount(page))
> > +             if (!PageCompound(page) &&
> > +                 page_count(page) > atomic_read(&page->_mapcount) + 1 +
> > +                             (!PageAnon(page) || PageSwapCache(page)))
> >                       goto isolate_fail;
>
> OK, we happened to notice this because we happened to trigger a
> !PageSlab assertion.  But if this page has been freed and reused for
> slab, it could have been reused for *anything*?  Perhaps it was reused
> as a migratable page which we'll go ahead and migrate even though we no
> longer should.  There are various whacky parts of the kernel which
> (ab)use surprising struct page fields in surprising ways - how do we
> know it isn't one of those which now happens to look like a migratable
> page?

Here we just optimistically skip as much unwanted pages as possible.

This code rechecks PageLRU and other tests later, under lru_lock.
lru_lock blocks freeing path which should acquire it to remove from lru.

>
> I also worry about the next test:
>
>                 /*
>                  * Only allow to migrate anonymous pages in GFP_NOFS context
>                  * because those do not depend on fs locks.
>                  */
>                 if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>                         goto isolate_fail;
>
> This page isn't PageLocked(), is it?  It could be a recycled page which
> is will be getting its ->mapping set one nanosecond hence.

Yes, it's racy. I don't see how compaction rechecks  this later.
So it could try to unmap and migrate file page if race here with recycle.

Probably nobody starts direct-compaction without GFP_FS.

>
>
> >               /*
> > @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >                               low_pfn += compound_nr(page) - 1;
> >                               goto isolate_fail;
> >                       }
> > +
> > +                     /* Recheck page extra references under lock */
> > +                     if (page_count(page) > page_mapcount(page) +
> > +                                 (!PageAnon(page) || PageSwapCache(page)))
> > +                             goto isolate_fail;
> >               }
> >
> >               lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >
>
