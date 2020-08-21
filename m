Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49D220702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHUA5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:57:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:19780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHUA5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:57:54 -0400
IronPort-SDR: Vx0Z/EfvIDx09nUvE49oJpBD0RFDXn9lvJQHh+Ro4G5Fp3zu+tcFs/XU0FeAyXq904FvK+PruB
 jkAxv/1zuFHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="152844195"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="152844195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 17:57:54 -0700
IronPort-SDR: s8Q3GTMRn4CZHTNRB6VtBti3Xkq6jyXeTOWGQp5lLiKprp79ujG+ljBfEV7mujn1EP0U8k3RpN
 jdl/ao99K4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="311288655"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 17:57:51 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "David Rientjes" <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
References: <20200818184122.29C415DF@viggo.jf.intel.com>
        <20200818184131.C972AFCC@viggo.jf.intel.com>
        <87lfi9wxk9.fsf@yhuang-dev.intel.com>
        <6a378a57-a453-0318-924b-05dfa0a10c1f@intel.com>
        <CAHbLzkrjxm38VV+ibQxoQkC4nW7F13aJcL5RypUchX30rqUstA@mail.gmail.com>
Date:   Fri, 21 Aug 2020 08:57:50 +0800
In-Reply-To: <CAHbLzkrjxm38VV+ibQxoQkC4nW7F13aJcL5RypUchX30rqUstA@mail.gmail.com>
        (Yang Shi's message of "Thu, 20 Aug 2020 09:26:57 -0700")
Message-ID: <87v9hcvmr5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Thu, Aug 20, 2020 at 8:22 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 8/20/20 1:06 AM, Huang, Ying wrote:
>> >> +    /* Migrate pages selected for demotion */
>> >> +    nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
>> >> +
>> >>      pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>> >>
>> >>      mem_cgroup_uncharge_list(&free_pages);
>> >> _
>> > Generally, it's good to batch the page migration.  But one side effect
>> > is that, if the pages are failed to be migrated, they will be placed
>> > back to the LRU list instead of falling back to be reclaimed really.
>> > This may cause some issue in some situation.  For example, if there's no
>> > enough space in the PMEM (slow) node, so the page migration fails, OOM
>> > may be triggered, because the direct reclaiming on the DRAM (fast) node
>> > may make no progress, while it can reclaim some pages really before.
>>
>> Yes, agreed.
>
> Kind of. But I think that should be transient and very rare. The
> kswapd on pmem nodes will be waken up to drop pages when we try to
> allocate migration target pages. It should be very rare that there is
> not reclaimable page on pmem nodes.
>
>>
>> There are a couple of ways we could fix this.  Instead of splicing
>> 'demote_pages' back into 'ret_pages', we could try to get them back on
>> 'page_list' and goto the beginning on shrink_page_list().  This will
>> probably yield the best behavior, but might be a bit ugly.
>>
>> We could also add a field to 'struct scan_control' and just stop trying
>> to migrate after it has failed one or more times.  The trick will be
>> picking a threshold that doesn't mess with either the normal reclaim
>> rate or the migration rate.
>
> In my patchset I implemented a fallback mechanism via adding a new
> PGDAT_CONTENDED node flag. Please check this out:
> https://patchwork.kernel.org/patch/10993839/.
>
> Basically the PGDAT_CONTENDED flag will be set once migrate_pages()
> return -ENOMEM which indicates the target pmem node is under memory
> pressure, then it would fallback to regular reclaim path. The flag
> would be cleared by clear_pgdat_congested() once the pmem node memory
> pressure is gone.

There may be some races between the flag set and clear.  For example,

- try to migrate some pages from DRAM node to PMEM node

- no enough free pages on the PMEM node, so wakeup kswapd

- kswapd on PMEM node reclaimed some page and try to clear
  PGDAT_CONTENDED on DRAM node

- set PGDAT_CONTENDED on DRAM node
 
This may be resolvable.  But I still prefer to fallback to real page
reclaiming directly for the pages failed to be migrated.  That looks
more robust.

Best Regards,
Huang, Ying

> We already use node flags to indicate the state of node in reclaim
> code, i.e. PGDAT_WRITEBACK, PGDAT_DIRTY, etc. So, adding a new flag
> sounds more straightforward to me IMHO.
>
>>
>> This is on my list to fix up next.
>>
