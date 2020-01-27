Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB9C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3230120720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580137230;
	bh=MTqtn9fZNO6Hxr0A3zfWGtjG+3DkBXeytLBEdCBtE30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NA0SrBB8rnTdoMOxZcC0Zolk+vBfUeVqZmCXZrB8uYMK7td80Qv6JJybo2wUyKwkD
	 QHLTda+SYUe04aB8JNu1qeH+LdKQLfChtdBfqAzRGnRt6zC+PqhYo4XvgA+VrXWZJM
	 Q/q+isD3U+Ozed4Xp4upB4MKZjanxOMGN6vCdh/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgA0PA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:00:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA0PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:00:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so11658660wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPyJz022JuT6nWadTd9aeXgqhFJalpTc13NsnVwngMg=;
        b=rK9f/Z4HWkd5rGhZNPpHT5NiGf/DPpasq6jFgB9IssqMeB3vrXFkXobU5Sp6zRaFlW
         LSGF0OSmIEnBBk6ufLeKfks6RVgl6QluZOa754C8UaZ9xncCp/OyEgV0ydIMLPI6mjmm
         n+SP32GpG/al9nyPrBbxasVhmUbFsPSNPq2JTZO1Hb9kI3dbfm1p6n9/6/l/I1RveKhK
         jkRQq26yrsOPIKVs9E+k7JpiVTJ04i3N9NeVthwid6XA+/TPdYM7GKhWu4vzVyB1rg2s
         cA1pxGIQVDk8oqRAg3ThuD75jerKiG0iuYaSY3+jlZqE0a02WNnQAJzMli4vmqWcA3cD
         U5tA==
X-Gm-Message-State: APjAAAU38RH0XtqBwHpAZjtyNBLGs+drkFjnxiWOcAj3apX5f6LjnvvZ
        z5PJeaYIJtMmwZT4uT2mTSI=
X-Google-Smtp-Source: APXvYqz27KTaDhfMesbzgiDyVLK2MXuK2H8DrJuSl0WAcL8wm9ZEsn879LIR3Do094GYGWkHi8gmjA==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr22186112wrt.70.1580137226712;
        Mon, 27 Jan 2020 07:00:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d14sm22645106wru.9.2020.01.27.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:25 -0800 (PST)
Date:   Mon, 27 Jan 2020 16:00:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200127150024.GN1183@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126233935.GA11536@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > > > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > > > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > > > too:
> > >
> > > So it seems that you are condending on the page lock. It is really
> > > unexpected that the reclaim would take that long though. Please try to
> > > enable more vmscan tracepoints to see where the time is spent.
> > 
> > I suspect the process gets stuck in the retry loop in try_charge(), as
> > the _shortest_ stacktrace of the perf samples indicated:
> > 
> > cycles:ppp:
> >         ffffffffa72963db mem_cgroup_iter
> >         ffffffffa72980ca mem_cgroup_oom_unlock
> >         ffffffffa7298c15 try_charge
> >         ffffffffa729a886 mem_cgroup_try_charge
> >         ffffffffa720ec03 __add_to_page_cache_locked
> >         ffffffffa720ee3a add_to_page_cache_lru
> >         ffffffffa7312ddb iomap_readpages_actor
> >         ffffffffa73133f7 iomap_apply
> >         ffffffffa73135da iomap_readpages
> >         ffffffffa722062e read_pages
> >         ffffffffa7220b3f __do_page_cache_readahead
> >         ffffffffa7210554 filemap_fault
> >         ffffffffc039e41f __xfs_filemap_fault
> >         ffffffffa724f5e7 __do_fault
> >         ffffffffa724c5f2 __handle_mm_fault
> >         ffffffffa724cbc6 handle_mm_fault
> >         ffffffffa70a313e __do_page_fault
> >         ffffffffa7a00dfe page_fault
> > 
> > But I don't see how it could be, the only possible case is when
> > mem_cgroup_oom() returns OOM_SUCCESS. However I can't
> > find any clue in dmesg pointing to OOM. These processes in the
> > same memcg are either running or sleeping (that is not exiting or
> > coredump'ing), I don't see how and why they could be selected as
> > a victim of OOM killer. I don't see any signal pending either from
> > their /proc/X/status.
> 
> I think this is a situation where we might end up with a genuine deadlock
> if we're not trylocking the pages.  readahead allocates a batch of
> locked pages and adds them to the pagecache.  If it has allocated,
> say, 5 pages, successfully inserted the first three into i_pages, then
> needs to allocate memory to insert the fourth one into i_pages, and
> the process then attempts to migrate the pages which are still locked,
> they will never come unlocked because they haven't yet been submitted
> to the filesystem for reading.

Just to make sure I understand. Do you mean this?
lock_page(A)
alloc_pages
  try_to_compact_pages
    compact_zone_order
      compact_zone(MIGRATE_SYNC_LIGHT)
        migrate_pages
	  unmap_and_move
	    __unmap_and_move
	      lock_page(A)
-- 
Michal Hocko
SUSE Labs
