Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB7C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474420578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgB1Izz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:55:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:44919 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgB1Izz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:55:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 00:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="272566543"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2020 00:55:40 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
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
Date:   Fri, 28 Feb 2020 16:55:40 +0800
In-Reply-To: <edae2736-3239-0bdc-499c-560fc234c974@redhat.com> (David
        Hildenbrand's message of "Fri, 28 Feb 2020 09:22:56 +0100")
Message-ID: <871rqf850z.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 28.02.20 08:25, Huang, Ying wrote:
>> Hi, Matthew,
>> 
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>>> On Fri, Feb 28, 2020 at 11:38:16AM +0800, Huang, Ying wrote:
>>>> MADV_FREE is a lazy free mechanism in Linux.  According to the manpage
>>>> of mavise(2), the semantics of MADV_FREE is,
>>>>
>>>>   The application no longer requires the pages in the range specified
>>>>   by addr and len.  The kernel can thus free these pages, but the
>>>>   freeing could be delayed until memory pressure occurs. ...
>>>>
>>>> Originally, the pages freed lazily by MADV_FREE will only be freed
>>>> really by page reclaiming when there is memory pressure or when
>>>> unmapping the address range.  In addition to that, there's another
>>>> opportunity to free these pages really, when we try to migrate them.
>>>>
>>>> The main value to do that is to avoid to create the new memory
>>>> pressure immediately if possible.  Instead, even if the pages are
>>>> required again, they will be allocated gradually on demand.  That is,
>>>> the memory will be allocated lazily when necessary.  This follows the
>>>> common philosophy in the Linux kernel, allocate resources lazily on
>>>> demand.
>>>
>>> Do you have an example program which does this (and so benefits)?
>> 
>> Sorry, what do you mean exactly for "this" here?  Call
>> madvise(,,MADV_FREE)?  Or migrate pages?
>> 
>>> If so, can you quantify the benefit at all?
>> 
>> The question is what is the right workload?  For example, I can build a
>> scenario as below to show benefit.
>
> We usually don't optimize for theoretical issues. Is there a real-life
> workload you are trying to optimize this code for?

We don't use a specific workload because we thought this is a general
optimization.  I will explain more later in this email.

>> 
>> - run program A in node 0 with many lazily freed pages
>> 
>> - run program B in node 1, so that the free memory on node 1 is low
>> 
>> - migrate the program A from node 0 to node 1, so that the program B is
>>   influenced by the memory pressure created by migrating lazily freed
>>   pages.
>> 
>
> E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
> report currently free pages to the hypervisor, which will MADV_FREE the
> reported memory. As long as there is no memory pressure, there is no
> need to actually free the pages. Once the guest reuses such a page, it
> could happen that there is still the old page and pulling in in a fresh
> (zeroed) page can be avoided.
>
> AFAIKs, after your change, we would get more pages discarded from our
> guest, resulting in more fresh (zeroed) pages having to be pulled in
> when a guest touches a reported free page again. But OTOH, page
> migration is speed up (avoiding to migrate these pages).

Let's look at this problem in another perspective.  To migrate the
MADV_FREE pages of the QEMU process from the node A to the node B, we
need to free the original pages in the node A, and (maybe) allocate the
same number of pages in the node B.  So the question becomes

- we may need to allocate some pages in the node B
- these pages may be accessed by the application or not
- we should allocate all these pages in advance or allocate them lazily
  when they are accessed.

We thought the common philosophy in Linux kernel is to allocate lazily.

That is, because we will always free the original pages in the node A,
the question isn't whether we should free these MADV_FREE pages, but
whether we should allocate the same number of pages in the node B before
we know whether they are really needed.  We thought this is similar as
whether we should allocate all physical pages when mmap().

> However, one important question, will you always discard memory when
> migrating pages, or only if there is memory pressure on the migration
> target?

We will always discard memory when migrating pages.  Our reasoning is as
above.

Best Regards,
Huang, Ying
