Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55217C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E14246B0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB1JuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:50:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:36304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgB1JuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:50:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 093F6B2D4;
        Fri, 28 Feb 2020 09:50:01 +0000 (UTC)
Date:   Fri, 28 Feb 2020 09:49:54 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200228094954.GB3772@suse.de>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <871rqf850z.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 04:55:40PM +0800, Huang, Ying wrote:
> > E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
> > report currently free pages to the hypervisor, which will MADV_FREE the
> > reported memory. As long as there is no memory pressure, there is no
> > need to actually free the pages. Once the guest reuses such a page, it
> > could happen that there is still the old page and pulling in in a fresh
> > (zeroed) page can be avoided.
> >
> > AFAIKs, after your change, we would get more pages discarded from our
> > guest, resulting in more fresh (zeroed) pages having to be pulled in
> > when a guest touches a reported free page again. But OTOH, page
> > migration is speed up (avoiding to migrate these pages).
> 
> Let's look at this problem in another perspective.  To migrate the
> MADV_FREE pages of the QEMU process from the node A to the node B, we
> need to free the original pages in the node A, and (maybe) allocate the
> same number of pages in the node B.  So the question becomes
> 
> - we may need to allocate some pages in the node B
> - these pages may be accessed by the application or not
> - we should allocate all these pages in advance or allocate them lazily
>   when they are accessed.
> 
> We thought the common philosophy in Linux kernel is to allocate lazily.
> 

I also think there needs to be an example of a real application that
benefits from this new behaviour. Consider the possible sources of page
migration

1. NUMA balancing -- The application has to read/write the data for this
   to trigger. In the case of write, MADV_FREE is cancelled and it's
   mostly likely going to be a write unless it's an application bug.
2. sys_movepages -- the application has explictly stated the data is in
   use on a particular node yet any MADV_FREE page gets discarded
3. Compaction -- there may be no memory pressure at all but the
   MADV_FREE memory is discarded prematurely

In the first case, the data is explicitly in use, most likely due to
a write in which case it's inappropriate to discard. Discarding and
reallocating a zero'd page is not expected. In second case, the data is
likely in use or else why would the system call be used? In the third case
the timing of when MADV_FREE pages disappear is arbitrary as it can happen
without any actual memory pressure.  This may or may not be problematic but
it leads to unpredictable latencies for applications that use MADV_FREE
for a quick malloc/free implementation.  Before, as long as there is no
pressure, the reuse of a MADV_FREE incurs just a small penalty but now
with compaction it does not matter if the system avoids memory pressure
because they may still incur a fault to allocate and zero a new page.

There is a hypothetical fourth case which I only mention because of your
email address. If persistent memory is ever used for tiered memory then
MADV_FREE pages that migrate from dram to pmem gets discarded instead
of migrated. When it's reused, it gets reallocated from dram regardless
of whether that region is hot or not.  This may lead to an odd scenario
whereby applications occupy dram prematurely due to a single reference
of a MADV_FREE page.

It's all subtle enough that we really should have an example application
in mind that benefits so we can weigh the benefits against the potential
risks.

-- 
Mel Gorman
SUSE Labs
