Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB8C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 23:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D3C20702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 23:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e7f4srva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgAZXjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 18:39:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgAZXjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 18:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HccNVAHYrxwNOkvIoab6izWsFUr3C25PEsIHXLsrgR4=; b=e7f4srvaUcflIy2OBKV4jiVAa
        Xflq/gHQssAbiSP2cMCfQBp+q6DHKlAbn/oTmfEUT80aAcuGTNs56GsICd+pberT7qMe25EjTGxVc
        r2QTBigxocuowetyeS2VqQ4SIdyy7BjrXHVjlgtwFDRW370aHY/qaQevdFJ+efChT/GmmBrgd24rE
        rAntuXZAwE5XCDxXuiwNursoCUR3Bjse+feleS/rnwoisvXpiGf1/m2J4DOSBGIK6zWXqqEdtxoZg
        FT7gSA/NkLl74qIni8PdoUTurXIOD/dxsgTC0l581Ol++Wrdo9H/vNKGutSrGyZas9tu31WxwEG82
        lXxgvH7Rw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivrV9-0006zd-BA; Sun, 26 Jan 2020 23:39:35 +0000
Date:   Sun, 26 Jan 2020 15:39:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200126233935.GA11536@bombadil.infradead.org>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > > too:
> >
> > So it seems that you are condending on the page lock. It is really
> > unexpected that the reclaim would take that long though. Please try to
> > enable more vmscan tracepoints to see where the time is spent.
> 
> I suspect the process gets stuck in the retry loop in try_charge(), as
> the _shortest_ stacktrace of the perf samples indicated:
> 
> cycles:ppp:
>         ffffffffa72963db mem_cgroup_iter
>         ffffffffa72980ca mem_cgroup_oom_unlock
>         ffffffffa7298c15 try_charge
>         ffffffffa729a886 mem_cgroup_try_charge
>         ffffffffa720ec03 __add_to_page_cache_locked
>         ffffffffa720ee3a add_to_page_cache_lru
>         ffffffffa7312ddb iomap_readpages_actor
>         ffffffffa73133f7 iomap_apply
>         ffffffffa73135da iomap_readpages
>         ffffffffa722062e read_pages
>         ffffffffa7220b3f __do_page_cache_readahead
>         ffffffffa7210554 filemap_fault
>         ffffffffc039e41f __xfs_filemap_fault
>         ffffffffa724f5e7 __do_fault
>         ffffffffa724c5f2 __handle_mm_fault
>         ffffffffa724cbc6 handle_mm_fault
>         ffffffffa70a313e __do_page_fault
>         ffffffffa7a00dfe page_fault
> 
> But I don't see how it could be, the only possible case is when
> mem_cgroup_oom() returns OOM_SUCCESS. However I can't
> find any clue in dmesg pointing to OOM. These processes in the
> same memcg are either running or sleeping (that is not exiting or
> coredump'ing), I don't see how and why they could be selected as
> a victim of OOM killer. I don't see any signal pending either from
> their /proc/X/status.

I think this is a situation where we might end up with a genuine deadlock
if we're not trylocking the pages.  readahead allocates a batch of
locked pages and adds them to the pagecache.  If it has allocated,
say, 5 pages, successfully inserted the first three into i_pages, then
needs to allocate memory to insert the fourth one into i_pages, and
the process then attempts to migrate the pages which are still locked,
they will never come unlocked because they haven't yet been submitted
to the filesystem for reading.

Or is this enough?

static inline gfp_t readahead_gfp_mask(struct address_space *x)
        return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;

