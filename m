Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16440C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EAC20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgGAQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:48:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:34749 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbgGAQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:48:28 -0400
IronPort-SDR: QXY1QpQFNVHiVc+AsNW0PXo03RqGnVwP1eYMws29fCc41/xmyGIMwBy2L11CVpbhrnaZskZads
 gRqb6MZW2ctw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="211693644"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="211693644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:48:28 -0700
IronPort-SDR: MGRYNvRsO4sGUWMD/cqiNDY+lxEeJEondhbkO/YSYtRyyahFgW1iKs370XhRBJ4XnONjB4zGh5
 yVbyaQkf1/EQ==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="455167727"
Received: from rapyeatx-mobl3.amr.corp.intel.com (HELO [10.255.2.31]) ([10.255.2.31])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:48:23 -0700
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
To:     David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, dan.j.williams@intel.com
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <20200629234509.8F89C4EF@viggo.jf.intel.com>
 <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <c06b4453-c533-a9ba-939a-8877fb301ad6@intel.com>
Date:   Wed, 1 Jul 2020 09:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 5:47 PM, David Rientjes wrote:
> On Mon, 29 Jun 2020, Dave Hansen wrote:
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

In its current form, yes.

My current rationale for this is that while it's not as deferential as
it can be to the user/kernel ABI contract, it's good *overall* behavior.
 The auto-migration only kicks in when the data is about to go away.  So
while the user's data might be slower than they like, it is *WAY* faster
than they deserve because it should be off on the disk.

> Because we don't have a mapping of the page back to its allocation 
> context (or the process context in which it was allocated), it seems like 
> both are possible.
> 
> So let's assume that migration nodes cannot be other DRAM nodes.  
> Otherwise, memory pressure could be intentionally or unintentionally 
> induced to migrate these pages to another node.  Do we have such a 
> restriction on migration nodes?

There's nothing explicit.  On a normal, balanced system where there's a
1:1:1 relationship between CPU sockets, DRAM nodes and PMEM nodes, it's
implicit since the migration path is one deep and goes from DRAM->PMEM.

If there were some oddball system where there was a memory only DRAM
node, it might very well end up being a migration target.

>> Some places we would like to see this used:
>>
>>   1. Persistent memory being as a slower, cheaper DRAM replacement
>>   2. Remote memory-only "expansion" NUMA nodes
>>   3. Resolving memory imbalances where one NUMA node is seeing more
>>      allocation activity than another.  This helps keep more recent
>>      allocations closer to the CPUs on the node doing the allocating.
> 
> (3) is the concerning one given the above if we are to use 
> migrate_demote_mapping() for DRAM node balancing.

Yeah, agreed.  That's the sketchiest of the three.  :)

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

In my mental model, cold data flows from:

	DRAM -> PMEM -> swap

Kicking kswapd here ensures that while we're doing DRAM->PMEM migrations
for kinda cold data, kswapd can be working on doing the PMEM->swap part
on really cold data.

...
>> @@ -1229,6 +1230,30 @@ static unsigned long shrink_page_list(st
>>  			; /* try to reclaim the page below */
>>  		}
>>  
>> +		rc = migrate_demote_mapping(page);
>> +		/*
>> +		 * -ENOMEM on a THP may indicate either migration is
>> +		 * unsupported or there was not enough contiguous
>> +		 * space. Split the THP into base pages and retry the
>> +		 * head immediately. The tail pages will be considered
>> +		 * individually within the current loop's page list.
>> +		 */
>> +		if (rc == -ENOMEM && PageTransHuge(page) &&
>> +		    !split_huge_page_to_list(page, page_list))
>> +			rc = migrate_demote_mapping(page);
>> +
>> +		if (rc == MIGRATEPAGE_SUCCESS) {
>> +			unlock_page(page);
>> +			if (likely(put_page_testzero(page)))
>> +				goto free_it;
>> +			/*
>> +			 * Speculative reference will free this page,
>> +			 * so leave it off the LRU.
>> +			 */
>> +			nr_reclaimed++;
> 
> nr_reclaimed += nr_pages instead?

Oh, good catch.  I also need to go double-check that 'nr_pages' isn't
wrong elsewhere because of the split.
