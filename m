Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BE8C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2124685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIujI3As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1Iaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:30:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgA1Iaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+/gVAvYBlL8oa7wpkNriFT1H6VzmpxQUtsVLdvG6Cc=; b=aIujI3AsJjriPqpzupdhhnRXz
        UUFvER1bBH0La9gdj+2YsNdKPPdu5iTfbBwnk4y4a5cFNSqAnxRejXiLkOyBL26hZgudMUFTlSUWQ
        +rTsPIKpNWClT3HHWFb69fqVW1cau4wR7Ym5zYCkQEmGwVhy3EWKQ9Ri7v06pdv6XaztcYOnRG24+
        V7A5m+eNM3V4zV7a3ZWCjSvcGaj+rc1zaL4nvo04uzpWEK/IptxmJrr2aMEz4CCEFAK/LTGoSbggw
        K/20Pr0Jj0ZyWT0LamCAsMj8+pwW7//aI7F457wwSG0vjTBsm/6+QXHA7vbROW2MpSvI9lQA9fnxz
        P0aMTF4OA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwMGi-00068o-Tb; Tue, 28 Jan 2020 08:30:44 +0000
Date:   Tue, 28 Jan 2020 00:30:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128083044.GB6615@bombadil.infradead.org>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128081712.GA18145@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:17:12AM +0100, Michal Hocko wrote:
> On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
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
> > > 	  unmap_and_move
> > > 	    __unmap_and_move
> > > 	      lock_page(A)
> > 
> > Yes.  There's a little more to it than that, eg slab is involved, but
> > you have it in a nutshell.
> 
> I am not deeply familiar with the readahead code. But is there really a
> high oerder allocation (order > 1) that would trigger compaction in the
> phase when pages are locked?

Thanks to sl*b, yes:

radix_tree_node    80890 102536    584   28    4 : tunables    0    0    0 : slabdata   3662   3662      0

so it's allocating 4 pages for an allocation of a 576 byte node.

> Btw. the compaction rejects to consider file backed pages when __GFP_FS
> is not present AFAIR.

Ah, that would save us.
