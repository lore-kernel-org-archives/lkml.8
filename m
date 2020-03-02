Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C352166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCBLXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:23:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:43477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgCBLXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:23:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="233126317"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2020 03:23:13 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        "Alexander Duyck" <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <20200228033819.3857058-1-ying.huang@intel.com>
        <20200228034248.GE29971@bombadil.infradead.org>
        <87a7538977.fsf@yhuang-dev.intel.com>
        <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
        <871rqf850z.fsf@yhuang-dev.intel.com> <20200228094954.GB3772@suse.de>
Date:   Mon, 02 Mar 2020 19:23:12 +0800
In-Reply-To: <20200228094954.GB3772@suse.de> (Mel Gorman's message of "Fri, 28
        Feb 2020 09:49:54 +0000")
Message-ID: <87h7z76lwf.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Mel Gorman <mgorman@suse.de> writes:

> On Fri, Feb 28, 2020 at 04:55:40PM +0800, Huang, Ying wrote:
>> > E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
>> > report currently free pages to the hypervisor, which will MADV_FREE the
>> > reported memory. As long as there is no memory pressure, there is no
>> > need to actually free the pages. Once the guest reuses such a page, it
>> > could happen that there is still the old page and pulling in in a fresh
>> > (zeroed) page can be avoided.
>> >
>> > AFAIKs, after your change, we would get more pages discarded from our
>> > guest, resulting in more fresh (zeroed) pages having to be pulled in
>> > when a guest touches a reported free page again. But OTOH, page
>> > migration is speed up (avoiding to migrate these pages).
>> 
>> Let's look at this problem in another perspective.  To migrate the
>> MADV_FREE pages of the QEMU process from the node A to the node B, we
>> need to free the original pages in the node A, and (maybe) allocate the
>> same number of pages in the node B.  So the question becomes
>> 
>> - we may need to allocate some pages in the node B
>> - these pages may be accessed by the application or not
>> - we should allocate all these pages in advance or allocate them lazily
>>   when they are accessed.
>> 
>> We thought the common philosophy in Linux kernel is to allocate lazily.
>> 
>
> I also think there needs to be an example of a real application that
> benefits from this new behaviour. Consider the possible sources of page
> migration
>
> 1. NUMA balancing -- The application has to read/write the data for this
>    to trigger. In the case of write, MADV_FREE is cancelled and it's
>    mostly likely going to be a write unless it's an application bug.
> 2. sys_movepages -- the application has explictly stated the data is in
>    use on a particular node yet any MADV_FREE page gets discarded
> 3. Compaction -- there may be no memory pressure at all but the
>    MADV_FREE memory is discarded prematurely
>
> In the first case, the data is explicitly in use, most likely due to
> a write in which case it's inappropriate to discard. Discarding and
> reallocating a zero'd page is not expected.

If my understanding were correct, NUMA balancing will not try to migrate
clean MADV_FREE pages most of the times.  Because the lazily freed pages
may be zeroed at any time, it makes almost no sense to read them.  So,
the first access after being freed lazily should be writing.  That will
make the page dirty MADV_FREE, so will not be discarded.  And the first
writing access in a new node will not trigger migration usually because
of the two-stage filter in should_numa_migrate_memory().  So current
behavior in case 1 will not change most of the times after the patchset.

> In second case, the data is likely in use or else why would the system
> call be used?

If the pages were in use, they shouldn't be clean MADV_FREE pages.  So
no behavior change after this patchset.

There is at least one use case to move the clean MADV_FREE pages (that
is, not in use), when we move an application from one node to another
node via something like /usr/bin/migratepages.  I think this is kind of
NUMA balancing by hand.  It appears reasonable to discard clean
MADV_FREE pages at least in some situations.

> In the third case the timing of when MADV_FREE pages disappear is
> arbitrary as it can happen without any actual memory pressure.  This
> may or may not be problematic but it leads to unpredictable latencies
> for applications that use MADV_FREE for a quick malloc/free
> implementation.  Before, as long as there is no pressure, the reuse of
> a MADV_FREE incurs just a small penalty but now with compaction it
> does not matter if the system avoids memory pressure because they may
> still incur a fault to allocate and zero a new page.

Yes.  This is a real problem.  Previously we thought that the migration
is kind of

- unmap and free the old pages
- map the new pages

If we can allocate new pages lazily in mmap(), why cannot we allocate
new pages lazily in migrating pages too if possible (for clean
MADV_CLEAN pages) because its second stage is kind of mmap() too.  But
you remind us that there are some differences,

- mmap() is called by the application directly, so its effect is
  predictable.  While some migration like that in the compaction isn't
  called by the application, so may have unpredictable behavior.
- With mmap(), the application can choose to allocate new pages lazily
  or eagerly.  But we lacks the same mechanism in this patchset.

So, maybe we can make the mechanism more flexible.  That is, let the
administrator or the application choose the right behavior for them, via
some system level configuration knob or API flags.  For example, if the
memory allocation latency isn't critical for the workloads, the
administrator can choose to discard clean MADV_FREE pages to make
compaction quicker and easier?

> There is a hypothetical fourth case which I only mention because of your
> email address. If persistent memory is ever used for tiered memory then
> MADV_FREE pages that migrate from dram to pmem gets discarded instead
> of migrated. When it's reused, it gets reallocated from dram regardless
> of whether that region is hot or not.

Thanks for mentioning this use case because we are working on this too.

Firstly, the memory writing bandwidth of the persistent memory is much
less than its reading bandwidth, so it is very valuable to avoid writing
persistent memory unnecessarily.  Discarding instead of migrating here
can help saving the memory writing bandwidth of the persistent memory.

Secondly, we will always allocate pages in DRAM before knowing they are
hot or cold if possible, and only demote the known cold pages to the
persistent memory.  Only when the accessing pattern of these cold pages
changes to be hot, we will promote them back to DRAM.  In this way, the
always hot pages can be kept in DRAM from begin to end.  After
MADV_FREE, the contents may be zeroed, so its access pattern changes to
be unknown too (e.g. free an object, then allocate a different object).
If we want to follow the above rule, we should put the new page with
unknown temperature in DRAM to give it an opportunity.

> This may lead to an odd scenario whereby applications occupy dram
> prematurely due to a single reference of a MADV_FREE page.

The better way to deal with this is to enhance mem_cgroup to limit DRAM
usage in a memory tiering system?

> It's all subtle enough that we really should have an example application
> in mind that benefits so we can weigh the benefits against the potential
> risks.

If some applications cannot tolerate the latency incurred by the memory
allocation and zeroing.  Then we cannot discard instead of migrate
always.  While in some situations, less memory pressure can help.  So
it's better to let the administrator and the application choose the
right behavior in the specific situation?

Best Regards,
Huang, Ying
