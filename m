Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA5E21744
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgCDK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:56:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgCDK4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:56:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D54F9B080;
        Wed,  4 Mar 2020 10:56:14 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:56:07 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200304105607.GF3772@suse.de>
References: <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228094954.GB3772@suse.de>
 <87h7z76lwf.fsf@yhuang-dev.intel.com>
 <20200302151607.GC3772@suse.de>
 <87zhcy5hoj.fsf@yhuang-dev.intel.com>
 <20200303080945.GX4380@dhcp22.suse.cz>
 <87o8td4yf9.fsf@yhuang-dev.intel.com>
 <20200303085805.GB4380@dhcp22.suse.cz>
 <87ftep4pzy.fsf@yhuang-dev.intel.com>
 <20200304095802.GE16139@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200304095802.GE16139@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:58:02AM +0100, Michal Hocko wrote:
> > >> If my understanding were correct, the newly migrated clean MADV_FREE
> > >> pages will be put at the head of inactive file LRU list instead of the
> > >> tail.  So it's possible that some useful file cache pages will be
> > >> reclaimed.
> > >
> > > This is the case also when you migrate other pages, right? We simply
> > > cannot preserve the aging.
> > 
> > So you consider the priority of the clean MADV_FREE pages is same as
> > that of page cache pages?
> 
> This is how MADV_FREE has been implemented, yes. See f7ad2a6cb9f7 ("mm:
> move MADV_FREE pages into LRU_INACTIVE_FILE list") for the
> justification.
> 
> > Because the penalty difference is so large, I
> > think it may be a good idea to always put clean MADV_FREE pages at the
> > tail of the inactive file LRU list?
> 
> You are again making assumptions without giving any actual real
> examples. Reconstructing MADV_FREE pages cost can differ a lot. This
> really depends on the specific usecase. Moving pages to the tail of LRU
> would make them the primary candidate for the reclaim with a strange
> LIFO semantic. Adding them to the head might be not the universal win
> but it will at least provide a reasonable FIFO semantic. I also find
> it much more easier to reason about MADV_FREE as an inactive cache.

I tend to agree, that would make MADV_FREE behave more like a
PageReclaim page that gets tagged for immediate reclaim when writeback
completes. Immediate reclaim is in response to heavy memory pressure where
there is trouble finding clean file pages to reclaim and dirty/writeback
pages are getting artifically preserved over hot-but-clean file
pages. That is a clear inversion of the order pages should be reclaimed
and is justified.  While there *might* be a basis for reclaiming MADV_FREE
sooner rather than later, there would have to be some evidence of a Page
inversion problem where a known hot page was getting reclaimed before
MADV_FREE pages. For example, it could easily be considered a bug to free
MADV_FREE pages over a page that was last touched at boot time.

About the only real concern I could find about MADV_FREE is that it
keeps RSS artifically high relative to MADV_DONTNEED in the absense of
memory pressure. In some cases userspace provided a way of switching to
MADV_DONTNEED at startup time to determine if there is a memory leak or
just MADV_FREE keeping pages resident. They probably would have benefitted
from a counter noting the number of MADV_FREE pages in the system as
opposed to the vmstat event or some other way of distinguishing real RSS
from MADV_FREE.

However, I can't find a bug report indicating that MADV_FREE pages were
pushing hot pages out to disk (be it file-backed or anonymous).

-- 
Mel Gorman
SUSE Labs
