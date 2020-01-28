Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E4C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904D324684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580202837;
	bh=jvCXGmvU3e/zioy6hqXrLNtJ3S+zOI0WT86/a2JWoeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zJzz+x9MyIOV2pzXBzFfiNl5d1nfHQtaFOI3lIKkjC6zeitORGRK8TYyWX0hRTeO9
	 iArHCy0UWevYERmUNKhly6Nat+wSWjLWu6YkaP3rMX9UtmMuML1o6vx946KS95wCwU
	 V/KRYY7bK+aScLjMNIDnaxWxdbEhk5aLT8+vbd68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1JN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:13:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1JN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:13:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so15078858wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 01:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=saosZuV2/eYI88dYpQg2/qi+lKEe+LY8ew7q+xeqRVM=;
        b=ni9YHtlRM/IhzD35Ci05DnsQnvOIxQRX6AuLHHP6duWaHpAO+B4EKKn/VojbAFjXkY
         TIjvaV/prVfwSqgpguRHwOC/+2dXIuZ6SUKu3h4fQelRdolQNuCTVbiZdaKJpAPdkR3L
         BenobmhbBH5DOvifuVGYVwTFOdaknfLHriBroPVVjI3FlBoR6BSChkYmd+C5s8tIDzDm
         LqOOB6YS94Os0jkByNUXyNeNvtgiZiWu4sXSRe8WnBG6TM0DKlexKFO7111fhhShAXBd
         lRpVQzI3lK0lMvpYPtn6qe3kA27tegCdVvP+/91Zm3vCu0bRQHuo8FYDWEuHP4vauYLe
         lCAw==
X-Gm-Message-State: APjAAAVI1kvGciGAzs/4SvP6b/o2JPUXNMDrbzAL4PX3VC21b03YbPuR
        IvalGim6T41+BE74Bekjnr472VWr
X-Google-Smtp-Source: APXvYqw+9rgxxkOI0vC5B0xvXCdd9UulHflV0RPlqpbJx4CRBHCbkl8ZavyTPuFzhm0nnOhOvTD1/Q==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr27344759wru.395.1580202834577;
        Tue, 28 Jan 2020 01:13:54 -0800 (PST)
Received: from localhost (37-48-13-185.nat.epc.tmcz.cz. [37.48.13.185])
        by smtp.gmail.com with ESMTPSA id z19sm2073489wmi.35.2020.01.28.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 01:13:53 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:13:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128091352.GC18145@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128083044.GB6615@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-01-20 00:30:44, Matthew Wilcox wrote:
> On Tue, Jan 28, 2020 at 09:17:12AM +0100, Michal Hocko wrote:
> > On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
> > > On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > > > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > > > 
> > > > > > cycles:ppp:
> > > > > >         ffffffffa72963db mem_cgroup_iter
> > > > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > > > >         ffffffffa7298c15 try_charge
> > > > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > > > >         ffffffffa7312ddb iomap_readpages_actor
> > > > > >         ffffffffa73133f7 iomap_apply
> > > > > >         ffffffffa73135da iomap_readpages
> > > > > >         ffffffffa722062e read_pages
> > > > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > > > >         ffffffffa7210554 filemap_fault
> > > > > >         ffffffffc039e41f __xfs_filemap_fault
> > > > > >         ffffffffa724f5e7 __do_fault
> > > > > >         ffffffffa724c5f2 __handle_mm_fault
> > > > > >         ffffffffa724cbc6 handle_mm_fault
> > > > > >         ffffffffa70a313e __do_page_fault
> > > > > >         ffffffffa7a00dfe page_fault
> > > > > > 
> > > > > > But I don't see how it could be, the only possible case is when
> > > > > > mem_cgroup_oom() returns OOM_SUCCESS. However I can't
> > > > > > find any clue in dmesg pointing to OOM. These processes in the
> > > > > > same memcg are either running or sleeping (that is not exiting or
> > > > > > coredump'ing), I don't see how and why they could be selected as
> > > > > > a victim of OOM killer. I don't see any signal pending either from
> > > > > > their /proc/X/status.
> > > > > 
> > > > > I think this is a situation where we might end up with a genuine deadlock
> > > > > if we're not trylocking the pages.  readahead allocates a batch of
> > > > > locked pages and adds them to the pagecache.  If it has allocated,
> > > > > say, 5 pages, successfully inserted the first three into i_pages, then
> > > > > needs to allocate memory to insert the fourth one into i_pages, and
> > > > > the process then attempts to migrate the pages which are still locked,
> > > > > they will never come unlocked because they haven't yet been submitted
> > > > > to the filesystem for reading.
> > > > 
> > > > Just to make sure I understand. Do you mean this?
> > > > lock_page(A)
> > > > alloc_pages
> > > >   try_to_compact_pages
> > > >     compact_zone_order
> > > >       compact_zone(MIGRATE_SYNC_LIGHT)
> > > >         migrate_pages
> > > > 	  unmap_and_move
> > > > 	    __unmap_and_move
> > > > 	      lock_page(A)
> > > 
> > > Yes.  There's a little more to it than that, eg slab is involved, but
> > > you have it in a nutshell.
> > 
> > I am not deeply familiar with the readahead code. But is there really a
> > high oerder allocation (order > 1) that would trigger compaction in the
> > phase when pages are locked?
> 
> Thanks to sl*b, yes:
> 
> radix_tree_node    80890 102536    584   28    4 : tunables    0    0    0 : slabdata   3662   3662      0
> 
> so it's allocating 4 pages for an allocation of a 576 byte node.

I am not really sure that we do sync migration for costly orders.

> > Btw. the compaction rejects to consider file backed pages when __GFP_FS
> > is not present AFAIR.
> 
> Ah, that would save us.

So the NOFS comes from the mapping GFP mask, right? That is something I
was hoping to get rid of eventually :/ Anyway it would be better to have
an explicit NOFS with a comment explaining why we need that. If for
nothing else then for documentation.
-- 
Michal Hocko
SUSE Labs
