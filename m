Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1316C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3B824673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCCBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:30:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:22374 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgCCBad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:30:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 17:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="258195400"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 17:30:28 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
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
        <871rqf850z.fsf@yhuang-dev.intel.com>
        <20200228095048.GK3771@dhcp22.suse.cz>
        <87d09u7sm2.fsf@yhuang-dev.intel.com>
        <20200302142549.GO4380@dhcp22.suse.cz>
Date:   Tue, 03 Mar 2020 09:30:28 +0800
In-Reply-To: <20200302142549.GO4380@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 2 Mar 2020 15:25:49 +0100")
Message-ID: <874kv66x8r.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Mon 02-03-20 22:12:53, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
> [...]
>> > And MADV_FREE pages are a kind of cache as well. If the target node is
>> > short on memory then those will be reclaimed as a cache so a
>> > pro-active freeing sounds counter productive as you do not have any
>> > idea whether that cache is going to be used in future. In other words
>> > you are not going to free a clean page cache if you want to use that
>> > memory as a migration target right? So you should make a clear case
>> > about why MADV_FREE cache is less important than the clean page cache
>> > and ideally have a good justification backed by real workloads.
>> 
>> Clean page cache still have valid contents, while clean MADV_FREE pages
>> has no valid contents.  So penalty of discarding the clean page cache is
>> reading from disk, while the penalty of discarding clean MADV_FREE pages
>> is just page allocation and zeroing.
>
> And "just page allocation and zeroing" overhead is the primary
> motivation to keep the page in memory. It is a decision of the workload
> to use MADV_FREE because chances are that this will speed things up. All
> that with a contract that the memory goes away under memory pressure so
> with a good workload/memory sizing you do not really lose that
> optimization. Now you want to make decision on behalf of the consumer of
> the MADV_FREE memory.

I understand that MADV_FREE helps in some situations.  And if the
application want to keep the "contract" after migration, they should
have a way to do that.

>> I understand that MADV_FREE is another kind of cache and has its value.
>> But in the original implementation, during migration, we have already
>> freed the original "cache", then reallocate the cache elsewhere and
>> copy.  This appears more like all pages are populated in mmap() always.
>> I know there's value to populate all pages in mmap(), but does that need
>> to be done always by default?
>
> It is not. You have to explicitly request MAP_POPULATE to initialize
> mmap.

Yes.  mmap() can control whether to populate the underlying physical
pages.  But for migrating MADV_FREE pages, there's no control, all pages
will be populated again always by default.  Maybe we should avoid to do
that in some situations too.

Best Regards,
Huang, Ying
