Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA8720771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgGARVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:21:51 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39070 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbgGARVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:21:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U1PXvC4_1593624102;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U1PXvC4_1593624102)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jul 2020 01:21:44 +0800
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
To:     David Rientjes <rientjes@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, ying.huang@intel.com, dan.j.williams@intel.com
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <20200629234509.8F89C4EF@viggo.jf.intel.com>
 <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
 <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
 <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <33028a57-24fd-e618-7d89-5f35a35a6314@linux.alibaba.com>
Date:   Wed, 1 Jul 2020 10:21:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/20 10:41 PM, David Rientjes wrote:
> On Tue, 30 Jun 2020, Yang Shi wrote:
>
>>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>>>
>>>> If a memory node has a preferred migration path to demote cold pages,
>>>> attempt to move those inactive pages to that migration node before
>>>> reclaiming. This will better utilize available memory, provide a faster
>>>> tier than swapping or discarding, and allow such pages to be reused
>>>> immediately without IO to retrieve the data.
>>>>
>>>> When handling anonymous pages, this will be considered before swap if
>>>> enabled. Should the demotion fail for any reason, the page reclaim
>>>> will proceed as if the demotion feature was not enabled.
>>>>
>>> Thanks for sharing these patches and kick-starting the conversation, Dave.
>>>
>>> Could this cause us to break a user's mbind() or allow a user to
>>> circumvent their cpuset.mems?
>>>
>>> Because we don't have a mapping of the page back to its allocation
>>> context (or the process context in which it was allocated), it seems like
>>> both are possible.
>> Yes, this could break the memory placement policy enforced by mbind and
>> cpuset. I discussed this with Michal on mailing list and tried to find a way
>> to solve it, but unfortunately it seems not easy as what you mentioned above.
>> The memory policy and cpuset is stored in task_struct rather than mm_struct.
>> It is not easy to trace back to task_struct from page (owner field of
>> mm_struct might be helpful, but it depends on CONFIG_MEMCG and is not
>> preferred way).
>>
> Yeah, and Ying made a similar response to this message.
>
> We can do this if we consider pmem not to be a separate memory tier from
> the system perspective, however, but rather the socket perspective.  In
> other words, a node can only demote to a series of exclusive pmem ranges
> and promote to the same series of ranges in reverse order.  So DRAM node 0
> can only demote to PMEM node 2 while DRAM node 1 can only demote to PMEM
> node 3 -- a pmem range cannot be demoted to, or promoted from, more than
> one DRAM node.
>
> This naturally takes care of mbind() and cpuset.mems if we consider pmem
> just to be slower volatile memory and we don't need to deal with the
> latency concerns of cross socket migration.  A user page will never be
> demoted to a pmem range across the socket and will never be promoted to a
> different DRAM node that it doesn't have access to.

But I don't see too much benefit to limit the migration target to the 
so-called *paired* pmem node. IMHO it is fine to migrate to a remote (on 
a different socket) pmem node since even the cross socket access should 
be much faster then refault or swap from disk.

>
> That can work with the NUMA abstraction for pmem, but it could also
> theoretically be a new memory zone instead.  If all memory living on pmem
> is migratable (the natural way that memory hotplug is done, so we can
> offline), this zone would live above ZONE_MOVABLE.  Zonelist ordering
> would determine whether we can allocate directly from this memory based on
> system config or a new gfp flag that could be set for users of a mempolicy
> that allows allocations directly from pmem.  If abstracted as a NUMA node
> instead, interleave over nodes {0,2,3} or a cpuset.mems of {0,2,3} doesn't
> make much sense.
>
> Kswapd would need to be enlightened for proper pgdat and pmem balancing
> but in theory it should be simpler because it only has its own node to
> manage.  Existing per-zone watermarks might be easy to use to fine tune
> the policy from userspace: the scale factor determines how much memory we
> try to keep free on DRAM for migration from pmem, for example.  We also
> wouldn't have to deal with node hotplug or updating of demotion/promotion
> node chains.
>
> Maybe the strongest advantage of the node abstraction is the ability to
> use autonuma and migrate_pages()/move_pages() API for moving pages
> explicitly?  Mempolicies could be used for migration to "top-tier" memory,
> i.e. ZONE_NORMAL or ZONE_MOVABLE, instead.

I think using pmem as a node is more natural than zone and less 
intrusive since we can just reuse all the numa APIs. If we treat pmem as 
a new zone I think the implementation may be more intrusive and 
complicated (i.e. need a new gfp flag) and user can't control the memory 
placement.

Actually there had been such proposal before, please see 
https://www.spinics.net/lists/linux-mm/msg151788.html


