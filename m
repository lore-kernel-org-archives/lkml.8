Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91406C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667462467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580199438;
	bh=TEQGHVlM+iUtlNKv5J23BD/qcWDuX6te8q9DcipmMvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DDHKYNHjGIwf130gpvm1r0DH6yRO6tLpAe8lA95P/iod9BDskLNgyqx7Sgq6Aaqld
	 OGALhRMqMmqSLeGODkfzAiFvQUru85fmE98o3W+buDrpkwoB3h090MgCfMvPdeVr04
	 9OD+/ITOrxmfU9HVwaJGBbfGZ+Fz85FJwc6W0NbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgA1IRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:17:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1IRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:17:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id b2so1483809wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErBG9pYwzWOEtyUstgnFdD6SGk7GMiHGUbPrDMcYEeU=;
        b=XtxZDbjoeVAXn0Arr7+aEHD/9HRBev9fghJGa32LcmFXwl0bgtLcqB/tetrlGLoOMz
         +AtyRK14zPfHA2h9ZAdMy1bb31k8fvMKcNnHUd/ldHwi1Y1vrXmPFR48gl5sxoXcBwKk
         TeWjakO/wqPSbDpDvbZiHF7Fyqz80b7GWVRMQ8C3oDwHl9OIiR56+6rrsBK5rxTtwQ1G
         Iuu/O0mZZIVoDX8gQkspUG4NL/+hMGK2LhC+5dwZSlwFyFIwJvG9wl9LrnsLeW4BbzKR
         oOCRy2N36m1Vub5+xcts6GZ25Sbj2xK0UUqpLKiKX3GCJ/fVWZjOHKjP4uw1zDrubPPb
         Uu2Q==
X-Gm-Message-State: APjAAAXzwlNj4liU9LuJ4n+EUR7Db6wczljNlW1V6NuqDO/MacpvRq4T
        19PVuCNVL2Z9E2zDbt2TXew=
X-Google-Smtp-Source: APXvYqwXWJpXhgy7c1nfP/EKf5EVnl3p5sYU2vtnW1V3WfMDC+uDDqbqvAMsrM9dNr2cOskc/aNjZA==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr3486794wmf.106.1580199434739;
        Tue, 28 Jan 2020 00:17:14 -0800 (PST)
Received: from localhost (37-48-13-185.nat.epc.tmcz.cz. [37.48.13.185])
        by smtp.gmail.com with ESMTPSA id n10sm24167762wrt.14.2020.01.28.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 00:17:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:17:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128081712.GA18145@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127190653.GA8708@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
> On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > 
> > > > cycles:ppp:
> > > >         ffffffffa72963db mem_cgroup_iter
> > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > >         ffffffffa7298c15 try_charge
> > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > >         ffffffffa7312ddb iomap_readpages_actor
> > > >         ffffffffa73133f7 iomap_apply
> > > >         ffffffffa73135da iomap_readpages
> > > >         ffffffffa722062e read_pages
> > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > >         ffffffffa7210554 filemap_fault
> > > >         ffffffffc039e41f __xfs_filemap_fault
> > > >         ffffffffa724f5e7 __do_fault
> > > >         ffffffffa724c5f2 __handle_mm_fault
> > > >         ffffffffa724cbc6 handle_mm_fault
> > > >         ffffffffa70a313e __do_page_fault
> > > >         ffffffffa7a00dfe page_fault
> > > > 
> > > > But I don't see how it could be, the only possible case is when
> > > > mem_cgroup_oom() returns OOM_SUCCESS. However I can't
> > > > find any clue in dmesg pointing to OOM. These processes in the
> > > > same memcg are either running or sleeping (that is not exiting or
> > > > coredump'ing), I don't see how and why they could be selected as
> > > > a victim of OOM killer. I don't see any signal pending either from
> > > > their /proc/X/status.
> > > 
> > > I think this is a situation where we might end up with a genuine deadlock
> > > if we're not trylocking the pages.  readahead allocates a batch of
> > > locked pages and adds them to the pagecache.  If it has allocated,
> > > say, 5 pages, successfully inserted the first three into i_pages, then
> > > needs to allocate memory to insert the fourth one into i_pages, and
> > > the process then attempts to migrate the pages which are still locked,
> > > they will never come unlocked because they haven't yet been submitted
> > > to the filesystem for reading.
> > 
> > Just to make sure I understand. Do you mean this?
> > lock_page(A)
> > alloc_pages
> >   try_to_compact_pages
> >     compact_zone_order
> >       compact_zone(MIGRATE_SYNC_LIGHT)
> >         migrate_pages
> > 	  unmap_and_move
> > 	    __unmap_and_move
> > 	      lock_page(A)
> 
> Yes.  There's a little more to it than that, eg slab is involved, but
> you have it in a nutshell.

I am not deeply familiar with the readahead code. But is there really a
high oerder allocation (order > 1) that would trigger compaction in the
phase when pages are locked?

Btw. the compaction rejects to consider file backed pages when __GFP_FS
is not present AFAIR.

-- 
Michal Hocko
SUSE Labs
