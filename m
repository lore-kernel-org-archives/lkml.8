Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B670C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E60F206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgGAIyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:54:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:18896 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGAIyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:54:13 -0400
IronPort-SDR: mAwyIiPBHYg1XFOe7sGjXV8VCZYZ+VStt4rj2+Vbzu9zayW9HmDo7sQmAojpZaN5Iha8uYU6vT
 TXhpqZAQknxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126609424"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="126609424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 01:54:12 -0700
IronPort-SDR: VV1sOWZQ/zmi/RI+r3nHlQ1QDLu1X/A+JmrDLZzMSAtFFc20CzSYads6hC0lF0nLhaajtIaeyn
 76sqXgr1DSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="425516440"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2020 01:54:10 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kbusch@kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of discard
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234509.8F89C4EF@viggo.jf.intel.com>
        <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
        <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
        <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
Date:   Wed, 01 Jul 2020 16:54:09 +0800
In-Reply-To: <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
        (David Rientjes's message of "Tue, 30 Jun 2020 22:41:47 -0700")
Message-ID: <87h7urlioe.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Tue, 30 Jun 2020, Yang Shi wrote:
>
>> > > From: Dave Hansen <dave.hansen@linux.intel.com>
>> > > 
>> > > If a memory node has a preferred migration path to demote cold pages,
>> > > attempt to move those inactive pages to that migration node before
>> > > reclaiming. This will better utilize available memory, provide a faster
>> > > tier than swapping or discarding, and allow such pages to be reused
>> > > immediately without IO to retrieve the data.
>> > > 
>> > > When handling anonymous pages, this will be considered before swap if
>> > > enabled. Should the demotion fail for any reason, the page reclaim
>> > > will proceed as if the demotion feature was not enabled.
>> > > 
>> > Thanks for sharing these patches and kick-starting the conversation, Dave.
>> > 
>> > Could this cause us to break a user's mbind() or allow a user to
>> > circumvent their cpuset.mems?
>> > 
>> > Because we don't have a mapping of the page back to its allocation
>> > context (or the process context in which it was allocated), it seems like
>> > both are possible.
>> 
>> Yes, this could break the memory placement policy enforced by mbind and
>> cpuset. I discussed this with Michal on mailing list and tried to find a way
>> to solve it, but unfortunately it seems not easy as what you mentioned above.
>> The memory policy and cpuset is stored in task_struct rather than mm_struct.
>> It is not easy to trace back to task_struct from page (owner field of
>> mm_struct might be helpful, but it depends on CONFIG_MEMCG and is not
>> preferred way).
>> 
>
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

Why can not we just bind the memory of the application to node 0, 2, 3
via mbind() or cpuset.mems?  Then the application can allocate memory
directly from PMEM.  And if we bind the memory of the application via
mbind() to node 0, we can only allocate memory directly from DRAM.

Best Regards,
Huang, Ying
