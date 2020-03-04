Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8175B20709
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbgCDLP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:15:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:35703 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbgCDLP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:15:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 03:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="263571586"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2020 03:15:21 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@suse.de>, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
        <871rqf850z.fsf@yhuang-dev.intel.com> <20200228094954.GB3772@suse.de>
        <87h7z76lwf.fsf@yhuang-dev.intel.com> <20200302151607.GC3772@suse.de>
        <87zhcy5hoj.fsf@yhuang-dev.intel.com>
        <20200303080945.GX4380@dhcp22.suse.cz>
        <87o8td4yf9.fsf@yhuang-dev.intel.com>
        <20200303085805.GB4380@dhcp22.suse.cz>
        <87ftep4pzy.fsf@yhuang-dev.intel.com>
        <20200304095802.GE16139@dhcp22.suse.cz>
Date:   Wed, 04 Mar 2020 19:15:20 +0800
In-Reply-To: <20200304095802.GE16139@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 4 Mar 2020 10:58:02 +0100")
Message-ID: <87blpc2wxj.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 03-03-20 19:49:53, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>> > On Tue 03-03-20 16:47:54, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@kernel.org> writes:
>> >> 
>> >> > On Tue 03-03-20 09:51:56, Huang, Ying wrote:
>> >> >> Mel Gorman <mgorman@suse.de> writes:
>> >> >> > On Mon, Mar 02, 2020 at 07:23:12PM +0800, Huang, Ying wrote:
>> >> >> >> If some applications cannot tolerate the latency incurred by the memory
>> >> >> >> allocation and zeroing.  Then we cannot discard instead of migrate
>> >> >> >> always.  While in some situations, less memory pressure can help.  So
>> >> >> >> it's better to let the administrator and the application choose the
>> >> >> >> right behavior in the specific situation?
>> >> >> >> 
>> >> >> >
>> >> >> > Is there an application you have in mind that benefits from discarding
>> >> >> > MADV_FREE pages instead of migrating them?
>> >> >> >
>> >> >> > Allowing the administrator or application to tune this would be very
>> >> >> > problematic. An application would require an update to the system call
>> >> >> > to take advantage of it and then detect if the running kernel supports
>> >> >> > it. An administrator would have to detect that MADV_FREE pages are being
>> >> >> > prematurely discarded leading to a slowdown and that is hard to detect.
>> >> >> > It could be inferred from monitoring compaction stats and checking
>> >> >> > if compaction activity is correlated with higher minor faults in the
>> >> >> > target application. Proving the correlation would require using the perf
>> >> >> > software event PERF_COUNT_SW_PAGE_FAULTS_MIN and matching the addresses
>> >> >> > to MADV_FREE regions that were freed prematurely. That is not an obvious
>> >> >> > debugging step to take when an application detects latency spikes.
>> >> >> >
>> >> >> > Now, you could add a counter specifically for MADV_FREE pages freed for
>> >> >> > reasons other than memory pressure and hope the administrator knows about
>> >> >> > the counter and what it means. That type of knowledge could take a long
>> >> >> > time to spread so it's really very important that there is evidence of
>> >> >> > an application that suffers due to the current MADV_FREE and migration
>> >> >> > behaviour.
>> >> >> 
>> >> >> OK.  I understand that this patchset isn't a universal win, so we need
>> >> >> some way to justify it.  I will try to find some application for that.
>> >> >> 
>> >> >> Another thought, as proposed by David Hildenbrand, it's may be a
>> >> >> universal win to discard clean MADV_FREE pages when migrating if there are
>> >> >> already memory pressure on the target node.  For example, if the free
>> >> >> memory on the target node is lower than high watermark?
>> >> >
>> >> > This is already happening because if the target node is short on memory
>> >> > it will start to reclaim and if MADV_FREE pages are at the tail of
>> >> > inactive file LRU list then they will be dropped. Please note how that
>> >> > follows proper aging and doesn't introduce any special casing. Really
>> >> > MADV_FREE is an inactive cache for anonymous memory and we treat it like
>> >> > inactive page cache. This is not carved in stone of course but it really
>> >> > requires very good justification to change.
>> >> 
>> >> If my understanding were correct, the newly migrated clean MADV_FREE
>> >> pages will be put at the head of inactive file LRU list instead of the
>> >> tail.  So it's possible that some useful file cache pages will be
>> >> reclaimed.
>> >
>> > This is the case also when you migrate other pages, right? We simply
>> > cannot preserve the aging.
>> 
>> So you consider the priority of the clean MADV_FREE pages is same as
>> that of page cache pages?
>
> This is how MADV_FREE has been implemented, yes. See f7ad2a6cb9f7 ("mm:
> move MADV_FREE pages into LRU_INACTIVE_FILE list") for the
> justification.

Thanks for information.  It's really helpful!

>> Because the penalty difference is so large, I
>> think it may be a good idea to always put clean MADV_FREE pages at the
>> tail of the inactive file LRU list?
>
> You are again making assumptions without giving any actual real
> examples. Reconstructing MADV_FREE pages cost can differ a lot.

In which situation the cost to reconstruct MADV_FREE pages can be higher
than the cost to allocate file cache page and read from disk?  Heavy
contention on mmap_sem?

> This really depends on the specific usecase. Moving pages to the tail
> of LRU would make them the primary candidate for the reclaim with a
> strange LIFO semantic. Adding them to the head might be not the
> universal win but it will at least provide a reasonable FIFO
> semantic. I also find it much more easier to reason about MADV_FREE as
> an inactive cache.

Yes.  FIFO is more reasonable than LIFO.

Best Regards,
Huang, Ying
