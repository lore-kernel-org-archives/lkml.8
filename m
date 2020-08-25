Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99902076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgHYGta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:49:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:30123 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbgHYGt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:49:29 -0400
IronPort-SDR: CVEweMkr9tTQ0BzzouaKKZ2s2alpAVNTrfJxkN8LR4WjwiI06JFCZfRvoXevm04wAguN1y6sD0
 mASGsGEgPzAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217606813"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="217606813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 23:49:29 -0700
IronPort-SDR: V5mWwFtmttc0oEsWfhmDgvgOsHb7rREsw6RKkwLs5R8c5LOYQFJJ/w6ytddXRu/MWuQ/W+OCLA
 2/b3NG4oJOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="338698437"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2020 23:49:26 -0700
Date:   Tue, 25 Aug 2020 14:49:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Borislav Petkov <bp@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200825064926.GB83850@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200824165653.GQ2976@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824165653.GQ2976@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 05:56:53PM +0100, Mel Gorman wrote:
> On Mon, Aug 24, 2020 at 06:12:38PM +0200, Borislav Petkov wrote:
> > 
> > > :)  Right, this is what I'm doing right now. Some test job is queued on
> > > the test box, and it may needs some iterations of new patch. Hopefully we
> > > can isolate some specific variable given some luck.
> > 
> > ... yes, exactly, you need to identify the contention where this
> > happens,
> > causing a cacheline to bounce or a variable straddles across a
> > cacheline boundary, causing the read to fetch two cachelines and thus
> > causes that slowdown. And then align that var to the beginning of a
> > cacheline.
> > 
> 
> Given the test is malloc1, it *may* be struct per_cpu_pages embedded within
> per_cpu_pageset. The cache characteristics of per_cpu_pageset are terrible
> because of how it mixes up zone counters and per-cpu lists. However, if
> the first per_cpu_pageset is cache-aligned then every second per_cpu_pages
> will be cache-aligned and half of the lists will fit in one cache line. If
> the whole structure gets pushed out of alignment then all per_cpu_pages
> straddle cache lines, increase the overall cache footprint and potentially
> cause problems if the cache is not large enough to hold hot structures.
> 
> The misses could potentially be inferred without c2c from looking at
> perf -e cache-misses on a good and bad kernel and seeing if there is a
> noticable increase in misses in mm/page_alloc.c with a focus on anything
> using per-cpu lists.
 
Thanks for the tip, which is useful for Xeon-Phi. I ran it with 'cache-misses'
instead of default 'cycles', and the 2 versions of perf data show similar hotspots:

    92.62%    92.62%  [kernel.kallsyms]   [k] native_queued_spin_lock_slowpath              -      -            
46.20% native_queued_spin_lock_slowpath;_raw_spin_lock_irqsave;release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
46.13% native_queued_spin_lock_slowpath;_raw_spin_lock_irqsave;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
 
> Whether the problem is per_cpu_pages or some other structure, it's not
> struct mce's fault in all likelihood -- it's just the messenger.

Agreed. The mce patch itself is innocent, it just changes other domains'
variables' alignment indeliberately. 

Thanks,
Feng

> -- 
> Mel Gorman
> SUSE Labs
