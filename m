Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E14B20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGABkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:40:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:46617 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgGABke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:40:34 -0400
IronPort-SDR: WWu0jK0TnpNnF/vx/CrL3bxyzQgo0XFdOjfuB9suyO8zJ0mBHt9uh9/aeofZ18LiNcgmnqENUQ
 3lvlxhnRgl+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147985230"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="147985230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 18:40:28 -0700
IronPort-SDR: z3ow3w6GrhlQoJF4D6rgjhTSef8gpxhMB55XL31ON4rO1sZ49JUOyfJ1fRHX8xvsFGr0daed29
 0494EltF4cbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481128227"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2020 18:40:26 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kbusch@kernel.org>, <yang.shi@linux.alibaba.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of discard
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234509.8F89C4EF@viggo.jf.intel.com>
        <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
Date:   Wed, 01 Jul 2020 09:40:25 +0800
In-Reply-To: <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
        (David Rientjes's message of "Tue, 30 Jun 2020 17:47:34 -0700")
Message-ID: <87a70knhbq.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Mon, 29 Jun 2020, Dave Hansen wrote:
>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>> 
>> If a memory node has a preferred migration path to demote cold pages,
>> attempt to move those inactive pages to that migration node before
>> reclaiming. This will better utilize available memory, provide a faster
>> tier than swapping or discarding, and allow such pages to be reused
>> immediately without IO to retrieve the data.
>> 
>> When handling anonymous pages, this will be considered before swap if
>> enabled. Should the demotion fail for any reason, the page reclaim
>> will proceed as if the demotion feature was not enabled.
>> 
>
> Thanks for sharing these patches and kick-starting the conversation, Dave.
>
> Could this cause us to break a user's mbind() or allow a user to 
> circumvent their cpuset.mems?
>
> Because we don't have a mapping of the page back to its allocation 
> context (or the process context in which it was allocated), it seems like 
> both are possible.

For mbind, I think we don't have enough information during reclaim to
enforce the node binding policy.  But for cpuset, if cgroup v2 (with the
unified hierarchy) is used, it's possible to get the node binding policy
via something like,

  cgroup_get_e_css(page->mem_cgroup, &cpuset_cgrp_subsys)

> So let's assume that migration nodes cannot be other DRAM nodes.  
> Otherwise, memory pressure could be intentionally or unintentionally 
> induced to migrate these pages to another node.  Do we have such a 
> restriction on migration nodes?
>
>> Some places we would like to see this used:
>> 
>>   1. Persistent memory being as a slower, cheaper DRAM replacement
>>   2. Remote memory-only "expansion" NUMA nodes
>>   3. Resolving memory imbalances where one NUMA node is seeing more
>>      allocation activity than another.  This helps keep more recent
>>      allocations closer to the CPUs on the node doing the allocating.
>> 
>
> (3) is the concerning one given the above if we are to use 
> migrate_demote_mapping() for DRAM node balancing.
>
>> Yang Shi's patches used an alternative approach where to-be-discarded
>> pages were collected on a separate discard list and then discarded
>> as a batch with migrate_pages().  This results in simpler code and
>> has all the performance advantages of batching, but has the
>> disadvantage that pages which fail to migrate never get swapped.
>> 
>> #Signed-off-by: Keith Busch <keith.busch@intel.com>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Keith Busch <kbusch@kernel.org>
>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> ---
>> 
>>  b/include/linux/migrate.h        |    6 ++++
>>  b/include/trace/events/migrate.h |    3 +-
>>  b/mm/debug.c                     |    1 
>>  b/mm/migrate.c                   |   52 +++++++++++++++++++++++++++++++++++++++
>>  b/mm/vmscan.c                    |   25 ++++++++++++++++++
>>  5 files changed, 86 insertions(+), 1 deletion(-)
>> 
>> diff -puN include/linux/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/linux/migrate.h
>> --- a/include/linux/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.950312604 -0700
>> +++ b/include/linux/migrate.h	2020-06-29 16:34:38.963312604 -0700
>> @@ -25,6 +25,7 @@ enum migrate_reason {
>>  	MR_MEMPOLICY_MBIND,
>>  	MR_NUMA_MISPLACED,
>>  	MR_CONTIG_RANGE,
>> +	MR_DEMOTION,
>>  	MR_TYPES
>>  };
>>  
>> @@ -78,6 +79,7 @@ extern int migrate_huge_page_move_mappin
>>  				  struct page *newpage, struct page *page);
>>  extern int migrate_page_move_mapping(struct address_space *mapping,
>>  		struct page *newpage, struct page *page, int extra_count);
>> +extern int migrate_demote_mapping(struct page *page);
>>  #else
>>  
>>  static inline void putback_movable_pages(struct list_head *l) {}
>> @@ -104,6 +106,10 @@ static inline int migrate_huge_page_move
>>  	return -ENOSYS;
>>  }
>>  
>> +static inline int migrate_demote_mapping(struct page *page)
>> +{
>> +	return -ENOSYS;
>> +}
>>  #endif /* CONFIG_MIGRATION */
>>  
>>  #ifdef CONFIG_COMPACTION
>> diff -puN include/trace/events/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/trace/events/migrate.h
>> --- a/include/trace/events/migrate.h~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.952312604 -0700
>> +++ b/include/trace/events/migrate.h	2020-06-29 16:34:38.963312604 -0700
>> @@ -20,7 +20,8 @@
>>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>> -	EMe(MR_CONTIG_RANGE,	"contig_range")
>> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
>> +	EMe(MR_DEMOTION,	"demotion")
>>  
>>  /*
>>   * First define the enums in the above macros to be exported to userspace
>> diff -puN mm/debug.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/debug.c
>> --- a/mm/debug.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.954312604 -0700
>> +++ b/mm/debug.c	2020-06-29 16:34:38.963312604 -0700
>> @@ -25,6 +25,7 @@ const char *migrate_reason_names[MR_TYPE
>>  	"mempolicy_mbind",
>>  	"numa_misplaced",
>>  	"cma",
>> +	"demotion",
>>  };
>>  
>>  const struct trace_print_flags pageflag_names[] = {
>> diff -puN mm/migrate.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/migrate.c
>> --- a/mm/migrate.c~0008-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard	2020-06-29 16:34:38.956312604 -0700
>> +++ b/mm/migrate.c	2020-06-29 16:34:38.964312604 -0700
>> @@ -1151,6 +1151,58 @@ int next_demotion_node(int node)
>>  	return node;
>>  }
>>  
>> +static struct page *alloc_demote_node_page(struct page *page, unsigned long node)
>> +{
>> +	/*
>> +	 * 'mask' targets allocation only to the desired node in the
>> +	 * migration path, and fails fast if the allocation can not be
>> +	 * immediately satisfied.  Reclaim is already active and heroic
>> +	 * allocation efforts are unwanted.
>> +	 */
>> +	gfp_t mask = GFP_NOWAIT | __GFP_NOWARN | __GFP_NORETRY |
>> +			__GFP_NOMEMALLOC | __GFP_THISNODE | __GFP_HIGHMEM |
>> +			__GFP_MOVABLE;
>
> GFP_NOWAIT has the side-effect that it does __GFP_KSWAPD_RECLAIM: do we 
> actually want to kick kswapd on the pmem node?

I think it should be a good idea to kick kswapd on the PMEM node.
Because otherwise, we will discard more pages in DRAM node.  And in
general, the DRAM pages are hotter than the PMEM pages, because the cold
DRAM pages are migrated to the PMEM node.

> If not, GFP_TRANSHUGE_LIGHT does a trick where it does 
> GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM.  You could probably do the same 
> here although the __GFP_IO and __GFP_FS would be unnecessary (but not 
> harmful).
>
>> +	struct page *newpage;
>> +
>> +	if (PageTransHuge(page)) {
>> +		mask |= __GFP_COMP;
>> +		newpage = alloc_pages_node(node, mask, HPAGE_PMD_ORDER);
>> +		if (newpage)
>> +			prep_transhuge_page(newpage);
>> +	} else
>> +		newpage = alloc_pages_node(node, mask, 0);
>> +
>> +	return newpage;
>> +}
>> +

Best Regards,
Huang, Ying
