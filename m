Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF8C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B2B2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m2rW2+a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgA1Ks7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:48:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1Ks7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CNzsEssv2U2BQoZ0e4P2mdfZ/WHkr2kZtAUOWkDXCNQ=; b=m2rW2+a8mL4KRYTAsWcx1j7fw
        e3NPpzDimNhAUDZ+MRcWP+PGxRghb8bvBratooFlxaiVaIjUl+ifcXG4aIkAwFIFB+yFJs+STiqMx
        hRpPPu9JMQullMsYfFDl1khUbqKBLSBciKo8h30y+XPR/1wkewFlto3AKByVqBmVkcEiNTZfmxKdt
        osE5oCdW2uVSSOG14peWoJT5IdgsQg0JRBo8aU3Wi1LZvR5BY5bUNHR7ctHnvZuoveQ38hOnDsESV
        OLbFKWfymwepmkL/j4uO5HZSp2W8bLJ1H/OU6ns8W+Qe75IjrjpCgkzULEZZeNeiRtNkI7+YAqVbq
        tiYAH+Y+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwOQT-0008Mh-IC; Tue, 28 Jan 2020 10:48:57 +0000
Date:   Tue, 28 Jan 2020 02:48:57 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128104857.GC6615@bombadil.infradead.org>
References: <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128091352.GC18145@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:13:52AM +0100, Michal Hocko wrote:
> On Tue 28-01-20 00:30:44, Matthew Wilcox wrote:
> > On Tue, Jan 28, 2020 at 09:17:12AM +0100, Michal Hocko wrote:
> > > On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
> > > > On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > > > > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > > > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > > > > 
> > > > > > > cycles:ppp:
> > > > > > >         ffffffffa72963db mem_cgroup_iter
> > > > > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > > > > >         ffffffffa7298c15 try_charge
> > > > > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > > > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > > > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > > > > >         ffffffffa7312ddb iomap_readpages_actor
> > > > > > >         ffffffffa73133f7 iomap_apply
> > > > > > >         ffffffffa73135da iomap_readpages
> > > > > > >         ffffffffa722062e read_pages
> > > > > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > > > > >         ffffffffa7210554 filemap_fault
> > > > > > >         ffffffffc039e41f __xfs_filemap_fault
> > > > > > >         ffffffffa724f5e7 __do_fault
> > > > > > >         ffffffffa724c5f2 __handle_mm_fault
> > > > > > >         ffffffffa724cbc6 handle_mm_fault
> > > > > > >         ffffffffa70a313e __do_page_fault
> > > > > > >         ffffffffa7a00dfe page_fault
> > > 
> > > I am not deeply familiar with the readahead code. But is there really a
> > > high oerder allocation (order > 1) that would trigger compaction in the
> > > phase when pages are locked?
> > 
> > Thanks to sl*b, yes:
> > 
> > radix_tree_node    80890 102536    584   28    4 : tunables    0    0    0 : slabdata   3662   3662      0
> > 
> > so it's allocating 4 pages for an allocation of a 576 byte node.
> 
> I am not really sure that we do sync migration for costly orders.

Doesn't the stack trace above indicate that we're doing migration as
the result of an allocation in add_to_page_cache_lru()?

> > > Btw. the compaction rejects to consider file backed pages when __GFP_FS
> > > is not present AFAIR.
> > 
> > Ah, that would save us.
> 
> So the NOFS comes from the mapping GFP mask, right? That is something I
> was hoping to get rid of eventually :/ Anyway it would be better to have
> an explicit NOFS with a comment explaining why we need that. If for
> nothing else then for documentation.

I'd also like to see the mapping GFP mask go away, but rather than seeing
an explicit GFP_NOFS here, I'd rather see the memalloc_nofs API used.
I just don't understand the whole problem space well enough to know
where to put the call for best effect.
