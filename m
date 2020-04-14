Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A2CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D6B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbgDNBba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:31:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:46087 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDNBb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:31:28 -0400
IronPort-SDR: p98+ZZ6QYuqxpLTalD8H3Sd3s5rg1eqNDc6Jwm5Ls09fONbKbejrc9DVcrizFSt/RF6XksEwim
 RhRT5QIvqy9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 18:31:26 -0700
IronPort-SDR: kOzw4nBLI2e7kjIdZeS0pezxBLzcZ/XvN8vKLi1t0VHDBzG0XjIK7125/jN/gUjRz6L0zxodKh
 TcJmLRoO8icA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="253051814"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 18:31:24 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
        <87a73f7d71.fsf@yhuang-dev.intel.com> <20200413133150.GA810380@xps-13>
Date:   Tue, 14 Apr 2020 09:31:24 +0800
In-Reply-To: <20200413133150.GA810380@xps-13> (Andrea Righi's message of "Mon,
        13 Apr 2020 15:31:50 +0200")
Message-ID: <87wo6i6efn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Mon, Apr 13, 2020 at 09:00:34PM +0800, Huang, Ying wrote:
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> 
>> [snip]
>> 
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index ebed37bbf7a3..c71abc8df304 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -20,6 +20,7 @@
>> >  #include <linux/migrate.h>
>> >  #include <linux/vmalloc.h>
>> >  #include <linux/swap_slots.h>
>> > +#include <linux/oom.h>
>> >  #include <linux/huge_mm.h>
>> >  
>> >  #include <asm/pgtable.h>
>> > @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
>> >  	max_pages = 1 << READ_ONCE(page_cluster);
>> >  	if (max_pages <= 1)
>> >  		return 1;
>> > +	/*
>> > +	 * If current task is using too much memory or swapoff is running
>> > +	 * simply use the max readahead size. Since we likely want to load a
>> > +	 * lot of pages back into memory, using a fixed-size max readhaead can
>> > +	 * give better performance in this case.
>> > +	 */
>> > +	if (oom_task_origin(current))
>> > +		return max_pages;
>> >  
>> >  	hits = atomic_xchg(&swapin_readahead_hits, 0);
>> >  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
>> 
>> Thinks this again.  If my understanding were correct, the accessing
>> pattern during swapoff is sequential, why swap readahead doesn't work?
>> If so, can you root cause that firstly?
>
> Theoretically if the pattern is sequential the current heuristic should
> already select a big readahead size, but apparently it's not doing that.
>
> I'll repeat my tests tracing the readahead size during swapoff to see
> exactly what's going on here.

I haven't verify it.  It may be helpful to call lookup_swap_cache()
before swapin_readahead() in unuse_pte_range().  The theory behind it is
to update the swap readahead statistics via lookup_swap_cache().

Best Regards,
Huang, Ying
