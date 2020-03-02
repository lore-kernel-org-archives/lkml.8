Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2699F2080C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCBOM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:12:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:58061 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgCBOM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:12:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="233168478"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2020 06:12:54 -0800
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
Date:   Mon, 02 Mar 2020 22:12:53 +0800
In-Reply-To: <20200228095048.GK3771@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 28 Feb 2020 10:50:48 +0100")
Message-ID: <87d09u7sm2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 28-02-20 16:55:40, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
> [...]
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
>
> The common philosophy is to cache as much as possible.

Yes.  This is another common philosophy.  And MADV_FREE pages is
different from caches such as the page caches because it has no valid
contents.  And this patchset doesn't disable MADV_FREE mechanism.  It
just change the migration behavior.  So MADV_FREE pages will be kept
until reclaiming most of the times.

> And MADV_FREE pages are a kind of cache as well. If the target node is
> short on memory then those will be reclaimed as a cache so a
> pro-active freeing sounds counter productive as you do not have any
> idea whether that cache is going to be used in future. In other words
> you are not going to free a clean page cache if you want to use that
> memory as a migration target right? So you should make a clear case
> about why MADV_FREE cache is less important than the clean page cache
> and ideally have a good justification backed by real workloads.

Clean page cache still have valid contents, while clean MADV_FREE pages
has no valid contents.  So penalty of discarding the clean page cache is
reading from disk, while the penalty of discarding clean MADV_FREE pages
is just page allocation and zeroing.

I understand that MADV_FREE is another kind of cache and has its value.
But in the original implementation, during migration, we have already
freed the original "cache", then reallocate the cache elsewhere and
copy.  This appears more like all pages are populated in mmap() always.
I know there's value to populate all pages in mmap(), but does that need
to be done always by default?

Best Regards,
Huang, Ying
