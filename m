Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE9C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC922522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mc3mUiwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgA1GDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:03:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgA1GDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eiy4vZNsRLqD8F6sU+rjqr6HzK/2uGJED4ZdYTS3tUA=; b=Mc3mUiwpVUEDqWqbXFCUqIFFn
        b2R2iWmVJSGoAbUQoPSdPEMSpYuDn0yzivIRExpce5dUHQT8Zex4H2ThoWQks4/2CLvjGr3DeAIxf
        Suy8WqkEFjlIHA/jfLdcFY7jM5xcu4rzE2ycSfXo8a+w4dqRUMUaS8Dp/lqlfZ5has09IqpWhVpWo
        o0V8OpDddhp86HH6bumobgCFEAnDwTyQVIA0cIVdefEHh52gYR2n+EU27jNohPuZVvxakjh3o2LEM
        pIhu6oh6klPbfr2Cy1EFNkp3E1HIo+zTvnCGAihNOFQlWdrJbglsjGEcLgycUnw/4SguzKcgG0235
        QHqasIYpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwJxo-00072H-8O; Tue, 28 Jan 2020 06:03:04 +0000
Date:   Mon, 27 Jan 2020 22:03:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128060304.GA6615@bombadil.infradead.org>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <CAHbLzkoiYKEEzek9=84jTB8QVgE=uNjvi+gHR2CwVo0yK0KpBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoiYKEEzek9=84jTB8QVgE=uNjvi+gHR2CwVo0yK0KpBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 05:25:13PM -0800, Yang Shi wrote:
> On Mon, Jan 27, 2020 at 11:06 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > >
> > > > > cycles:ppp:
> > > > >         ffffffffa72963db mem_cgroup_iter
> > > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > > >         ffffffffa7298c15 try_charge
> > > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > > >         ffffffffa7312ddb iomap_readpages_actor
> > > > >         ffffffffa73133f7 iomap_apply
> > > > >         ffffffffa73135da iomap_readpages
> > > > >         ffffffffa722062e read_pages
> > > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > > >         ffffffffa7210554 filemap_fault
> > > > >         ffffffffc039e41f __xfs_filemap_fault
> > > > >         ffffffffa724f5e7 __do_fault
> > > > >         ffffffffa724c5f2 __handle_mm_fault
> > > > >         ffffffffa724cbc6 handle_mm_fault
> > > > >         ffffffffa70a313e __do_page_fault
> > > > >         ffffffffa7a00dfe page_fault
> > > > >
> > > > > But I don't see how it could be, the only possible case is when
> > > > > mem_cgroup_oom() returns OOM_SUCCESS. However I can't
> > > > > find any clue in dmesg pointing to OOM. These processes in the
> > > > > same memcg are either running or sleeping (that is not exiting or
> > > > > coredump'ing), I don't see how and why they could be selected as
> > > > > a victim of OOM killer. I don't see any signal pending either from
> > > > > their /proc/X/status.
> > > >
> > > > I think this is a situation where we might end up with a genuine deadlock
> > > > if we're not trylocking the pages.  readahead allocates a batch of
> > > > locked pages and adds them to the pagecache.  If it has allocated,
> > > > say, 5 pages, successfully inserted the first three into i_pages, then
> > > > needs to allocate memory to insert the fourth one into i_pages, and
> > > > the process then attempts to migrate the pages which are still locked,
> > > > they will never come unlocked because they haven't yet been submitted
> > > > to the filesystem for reading.
> > >
> > > Just to make sure I understand. Do you mean this?
> > > lock_page(A)
> > > alloc_pages
> > >   try_to_compact_pages
> > >     compact_zone_order
> > >       compact_zone(MIGRATE_SYNC_LIGHT)
> > >         migrate_pages
> > >         unmap_and_move
> > >           __unmap_and_move
> > >             lock_page(A)
> >
> > Yes.  There's a little more to it than that, eg slab is involved, but
> > you have it in a nutshell.
> 
> But, how compact could get blocked for readahead page if it is not on LRU?
> 
> The page is charged before adding to LRU, so if kernel just retry
> charge or reclaim forever, the page should be not on LRU, so it should
> not block compaction.

The five pages are allocated ABCDE, then they are added one at a time to
both the LRU list and i_pages.  Once ABCDE have been added to the page
cache, they are submitted to the filesystem in a batch.  The sceanrio
here is that once ABC have been added, we need to allocate memory to
add D.  The page migration code then attempts to migrate A.  Deadlock;
it will never come unlocked.

This kind of problem can occur in any filesystem in either readpages or
readpage.  Once the page is locked and on the LRU list, if the filesystem
attempts to allocate memory (and many do), this kind of deadlock can
occur.  It's avoided if the filesystem uses a mempool to avoid memory
allocation in this path, but they certainly don't all do that.

This specific deadlock can be avoided if we skip !PageUptodate pages.
But I don't know what other situations there are where we allocate memory
while holding a page locked that is on the LRU list.
