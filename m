Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E157C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7187820829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMICasEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgG1Rm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbgG1RmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:42:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:42:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so22107243lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+tfDSCx6joFpVNbWriwZ+nE5IIT2DzkqrVvcYVEnWw=;
        b=BMICasEXZwxvtksCsFf+27H958vekOxWwnaVUI2eOzdFoa1J6Fxax4D0LTGeodE6Fj
         Ar2QKrOLwTIyuBpVy5fVJzZBqoDe2g4n5fSEHduv7TswquLoEf59GEQVOjHZ9nwa46oz
         b+OjwAQO57Edln/dFSs4H1RaOJrcZxq1bjSALwWTsQFGNJ1aYxcL85NGd1H65D2UA9dz
         vK/8PKDGGipeMdG8T8S/ORyHnvjIoDwTQqnNpYMU9wtxboW6Duhd28cDyZgQjMrQ7+zL
         Ue/yl4nXhK3Q2tAYAmnkFp+g9Dyr+vmuytpjp53nOZrMAaOprvnbqLMSP5xJmtvU8B5v
         cYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+tfDSCx6joFpVNbWriwZ+nE5IIT2DzkqrVvcYVEnWw=;
        b=YvQVIcpEhvZ4DQv8u2KTd8+f9hSlJKFX3oV0wOZP8RyJTsUvbOv39CdUXUN+6L+Hfy
         raX6lwaWgKuokIuY8KrIShL9VBc6AhOmPwiDBdRmaDskDs8o329veJ5xea2UWYOVIPUe
         ythf87IdYjK6XRqBngkdhp3lS6q3XPympFtQXLUpmAsLQGi2PXjCTdOUYikUni5SkndR
         us8SWktECxP0tLghcrMzF+fqQI8wSIDKhMPyVOKmXsUPdlqtQEm8onSlAWjq8H/30tdD
         m9n+wN08KIuKWJWFPOmhLFZrkeHgxf7vwPrIKGqss595oiS0B/qFls/fKw1NF+WEzPVf
         b3pA==
X-Gm-Message-State: AOAM531uB7DWUVIn9KYxokrQN3dTve+5aTJ4EfAYSYE7hAoUEXX6DFec
        62bJEez+S5sZ1NZpXWcyBG6e/FRkh6Jx36s4y+PlHg==
X-Google-Smtp-Source: ABdhPJwoqKeJok0Ocly2uIrd3wWDwCT4v41zG8jePtLabHiW4Rgj2jUC1qqZqwkHGrTYHLkTcf6ovgvDIb9qDZK8EZ4=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr12140486ljb.192.1595958143475;
 Tue, 28 Jul 2020 10:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <xr934kpt76n5.fsf@gthelen.svl.corp.google.com> <20200727090255.24114-1-sjpark@amazon.com>
In-Reply-To: <20200727090255.24114-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jul 2020 10:42:11 -0700
Message-ID: <CALvZod7fsGJMKC_oKbr6z_+N_WeGXYBSnMUx7xGxG8KrjY6a0Q@mail.gmail.com>
Subject: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the
 virtual memory address spaces
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 2:03 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Mon, 27 Jul 2020 00:34:54 -0700 Greg Thelen <gthelen@google.com> wrote:
>
> > SeongJae Park <sjpark@amazon.com> wrote:
> >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > This commit introduces a reference implementation of the address space
> > > specific low level primitives for the virtual address space, so that
> > > users of DAMON can easily monitor the data accesses on virtual address
> > > spaces of specific processes by simply configuring the implementation to
> > > be used by DAMON.
> [...]
> > > diff --git a/mm/damon.c b/mm/damon.c
> > > index b844924b9fdb..386780739007 100644
> > > --- a/mm/damon.c
> > > +++ b/mm/damon.c
> > > @@ -9,6 +9,9 @@
> [...]
> > > +/*
> > > + * Functions for the access checking of the regions
> > > + */
> > > +
> > > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +   pte_t *pte = NULL;
> > > +   pmd_t *pmd = NULL;
> > > +   spinlock_t *ptl;
> > > +
> > > +   if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > +           return;
> > > +
> > > +   if (pte) {
> > > +           if (pte_young(*pte)) {
> > > +                   clear_page_idle(pte_page(*pte));
> > > +                   set_page_young(pte_page(*pte));
> >
> > While this compiles without support for PG_young and PG_idle, I assume
> > it won't work well because it'd clear pte.young without setting
> > PG_young.  And this would mess with vmscan.
>
> You're right, thanks for catching this up!  This definitely need to be fixed in
> the next spin.
>
> >
> > So this code appears to depend on PG_young and PG_idle, which are
> > currently only available via CONFIG_IDLE_PAGE_TRACKING.  DAMON could
> > depend on CONFIG_IDLE_PAGE_TRACKING via Kconfig.  But I assume that
> > CONFIG_IDLE_PAGE_TRACKING and CONFIG_DAMON cannot be concurrently used
> > because they'll stomp on each other's use of pte.young, PG_young,
> > PG_idle.
> > So I suspect we want:
> > 1. CONFIG_DAMON to depend on !CONFIG_IDLE_PAGE_TRACKING and vise-versa.
> > 2. PG_young,PG_idle and related helpers to depend on
> >    CONFIG_DAMON||CONFIG_IDLE_PAGE_TRACKING.
>
> Awesome insights and suggestions, thanks!
>
> I would like to note that DAMON could be interfered by IDLE_PAGE_TRACKING and
> vmscan, but not vice versa, as DAMON respects PG_idle and PG_young.  This
> design came from the weak goal of DAMON.  DAMON aims to provide not perfect
> monitoring but only best effort accuracy that would be sufficient for
> performance-centric DRAM level memory management.  So, at that time, I thought
> being interfered by IDLE_PAGE_TRACKING and the reclaim logic would not be a
> real problem but letting IDLE_PAGE_TRACKING coexist is somehow beneficial.
> That said, I couldn't find a real benefit of the coexistance yet, and the
> problem of being interference now seems bigger as we will support more cases
> including the page granularity.
>
> Maybe we could make IDLE_PAGE_TRACKING and DAMON coexist but mutual exclusive
> in runtime, if the beneficial of coexistance turns out big.  However, I would
> like to make it simple first and optimize the case later if real requirement
> found.

If you are planning to have support for tracking at page granularity
and physical memory monitoring in DAMON then I don't see any benefit
of coexistence of DAMON with IDLE_PAGE_TRACKING. Though I will not
push you to go that route if the code with coexistence is simple
enough.
