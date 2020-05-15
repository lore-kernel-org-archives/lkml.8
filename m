Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF037C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A9F205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEOICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:02:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:5668 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgEOICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:02:15 -0400
IronPort-SDR: eMi7DRUpSnRbVsZ5Ne3LfPznmmLKUqcH2Di0JbWWoBIAOxjSi5ODaN9n3g6WQeX2i3Yw0IS4n5
 0gt4k6DBCE1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 01:02:15 -0700
IronPort-SDR: rb7XtPi0zvHUhqz+bSx+ZcEFecunPYvkkmE1HmSArCgCCEEW6bC8ej5sUZb+h3zyx25ufaRLrb
 xPlsf0jLeilQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="266528464"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2020 01:02:11 -0700
Date:   Fri, 15 May 2020 16:02:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200515080210.GC69177@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
 <20200515074125.GH29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515074125.GH29153@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thanks for the thorough reviews for these 3 patches!

On Fri, May 15, 2020 at 03:41:25PM +0800, Michal Hocko wrote:
> On Fri 08-05-20 15:25:17, Feng Tang wrote:
> > When checking a performance change for will-it-scale scalability
> > mmap test [1], we found very high lock contention for spinlock of
> > percpu counter 'vm_committed_as':
> > 
> >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > 
> > Actually this heavy lock contention is not always necessary. The
> > 'vm_committed_as' needs to be very precise when the strict
> > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > number for the percpu counter.
> > 
> > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > when the policy is reconfigured.
> 
> Increasing the batch size for weaker overcommit modes makes sense. But
> your patch is also tuning OVERCOMMIT_NEVER without any explanation why
> that is still "small enough to be precise".

Actually, it keeps the batch algorithm for "OVERCOMMIT_NEVER", but
change the other 2 policies, which I should set it clear in the
commit log.

> > Benchmark with the same testcase in [1] shows 53% improvement on a
> > 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> > for some platforms, due to the test mmap size of the case is bigger
> > than the batch number computed, though the patch will help mmap/munmap
> > generally.
> > 
> > [1] https://lkml.org/lkml/2020/3/5/57
> 
> Please do not use lkml.org links in the changelog. Use
> http://lkml.kernel.org/r/$msg instead.

Thanks, will keep that in mind for this and future patches.

> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >  s32 vm_committed_as_batch = 32;
> >  
> > -static void __meminit mm_compute_batch(void)
> > +void mm_compute_batch(void)
> >  {
> >  	u64 memsized_batch;
> >  	s32 nr = num_present_cpus();
> >  	s32 batch = max_t(s32, nr*2, 32);
> > -
> > -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> > -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> > +	unsigned long ram_pages = totalram_pages();
> > +
> > +	/*
> > +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> > +	 * of (total memory/#cpus), and lift it to 6.25% for other
> > +	 * policies to easy the possible lock contention for percpu_counter
> > +	 * vm_committed_as, while the max limit is INT_MAX
> > +	 */
> > +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> > +	else
> > +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);

Also as you mentioned there are real-world work loads with big mmap
size and multi-threading, can we lift it even further ?
	memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX)

Thanks,
Feng

