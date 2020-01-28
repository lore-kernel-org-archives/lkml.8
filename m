Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D451EC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD2D2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b80p22Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgA1BZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:25:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38584 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1BZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:25:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id p23so4124295edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 17:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1W1vkWaZeQl3eUiDWaI95F64UnK7GsVRNE+cevZnQQ=;
        b=b80p22TeebE8zkZVbGzkhSVQQ02zgFmoIUBVH/UbmNIVGoYbJgUZjMauRgDNPIuZMM
         HXnjIVw3u80cNvFgdOSdrBdrYPtP5kPHoknfAdfHBwGAONB/aMwdVIA9akdkIYJnbVSV
         T7r4RF8hPlekyEJMzRe7oAf/Gkc0DmbF4fp8d7ZYQFLKzNvZm4hIYjYsotvJxvE3lrI/
         mVHt/BWXKz4gzKGQJYnfL+bwJ5sJzD4Gr/zKqAvnPTZlNf7iU/5nkWdFYtWAehz8pHqV
         qSDQ+xn4Msu8ca5jwl6LC7Qfx9EQI6ETRn+Pc9SJl6qXPRi1dJrENEUfHacaXG3zfGKr
         78TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1W1vkWaZeQl3eUiDWaI95F64UnK7GsVRNE+cevZnQQ=;
        b=mAJcLITHlHktYhDpRoBNfDBWCIExxJI6V5KNDNa3Vg5c0f3moge6z55eYhtClTopAs
         LVQQDGE/5KMRSl0jpAu7Xq0nd7gMW5MFhvkX4vona/zLqaSx0vTDpFJi4RaZ3OCB0Q2f
         oATVre1V8Rm1KncmuUEgkA8KVzkN+8vu2QnFywOWuQgMSpghhsFsV+Csd9WrEmOG4zyk
         TdtIAXu9SXeJhL5yUyP62SivavqpCUUQf55JXjqY+Cnq8UiGAem9Rc6QEnE13EhaImQe
         l2tcNwU3scFX96bgFAnMG7MsF8nrLSABR75/p8wThJovsT5svH/QvWN3fgMmYvjE/eY5
         aGoA==
X-Gm-Message-State: APjAAAVxNg6gNLxDKIjjryTSOlMhcVMqxdqFLiIBwZGbqsCV/25SyTNU
        6Mjn+3DkZolDKFTmFicxG6Jpl3BWf4MvXhx82Jo=
X-Google-Smtp-Source: APXvYqyX5Eq6ax4ecrdIbwxGZFUpz2ikNUcEF2wuI7ph9RtTO7wJ5MBCP1ZWLlD7v0HO/qIGerTaNBk1N+adYzUT3uU=
X-Received: by 2002:a50:decd:: with SMTP id d13mr1345389edl.372.1580174728463;
 Mon, 27 Jan 2020 17:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz> <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz> <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org> <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
In-Reply-To: <20200127190653.GA8708@bombadil.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 27 Jan 2020 17:25:13 -0800
Message-ID: <CAHbLzkoiYKEEzek9=84jTB8QVgE=uNjvi+gHR2CwVo0yK0KpBQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:06 AM Matthew Wilcox <willy@infradead.org> wrote:
>
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
> >         unmap_and_move
> >           __unmap_and_move
> >             lock_page(A)
>
> Yes.  There's a little more to it than that, eg slab is involved, but
> you have it in a nutshell.

But, how compact could get blocked for readahead page if it is not on LRU?

The page is charged before adding to LRU, so if kernel just retry
charge or reclaim forever, the page should be not on LRU, so it should
not block compaction.

>
