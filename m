Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9245DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C96207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgE0BoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:44:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:59084 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgE0BoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:44:05 -0400
IronPort-SDR: pj4uXSQEHp7LhosaWVl4JNJwoAg3nxLB0vgVEiAG/91cgxLIE7f/oj+VXeSuA8FlYsAYR7z6ZK
 4TmaUyA/TVeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 18:44:04 -0700
IronPort-SDR: xF4NamqZOsUfFCvLw03Fj91Sa2iAEJ1DPzR8Hjbd2NynOMqmOFEDowii1ih4wd95HIlwHYfBHy
 8YnMVI6dUygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="255326666"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 18:44:00 -0700
Date:   Wed, 27 May 2020 09:43:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andi Kleen <andi.kleen@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200527014359.GA93879@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527011413.GA610738@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527011413.GA610738@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:14:13PM -0700, Andi Kleen wrote:
> On Tue, May 26, 2020 at 02:14:59PM -0400, Qian Cai wrote:
> > On Thu, May 21, 2020 at 05:27:26PM -0400, Qian Cai wrote:
> > > On Fri, May 08, 2020 at 03:25:14PM +0800, Feng Tang wrote:
> > > > When checking a performance change for will-it-scale scalability
> > > > mmap test [1], we found very high lock contention for spinlock of
> > > > percpu counter 'vm_committed_as':
> > > > 
> > > >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> > > >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> > > >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > > > 
> > > > Actually this heavy lock contention is not always necessary. The
> > > > 'vm_committed_as' needs to be very precise when the strict
> > > > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > > > number for the percpu counter.
> > > > 
> > > > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > > > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > > > when the policy is reconfigured.
> > > > 
> > > > Benchmark with the same testcase in [1] shows 53% improvement on a
> > > > 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> > > > for some platforms, due to the test mmap size of the case is bigger
> > > > than the batch number computed, though the patch will help mmap/munmap
> > > > generally.
> > > > 
> > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > > 
> > > > There are some style complain from checkpatch for patch 3, as it
> > > > follows the similar format of sibling functions
> > > > 
> > > > patch1: a cleanup for /proc/meminfo
> > > > patch2: a preparation patch which also improve the accuracy of
> > > >         vm_memory_committed
> > > > patch3: the main change
> > > > 
> > > > Please help to review, thanks!
> > > 
> > > Reverted this series fixed a warning under memory pressue.
> > 
> > Andrew, Stephen, can you drop this series?
> 
> Hope you're happy now.
> 
> The warning is just not needed for the always case. The whole point
> of the patch was to maintain these counters only approximately.
> We could of course use _sum or _sum_positive in the warning, but that would
> just be unnecessary overhead in this moderately hot path.
> 
> So this patch should fix it: (untested)
> 
> Possibly might need to move it even further down because the patch
> also affected the _GUESS case.

Thanks Andi for the patch. And I agree that it could be after _GUESS
case, as existig check for _GUESS is loose:

	if (pages > totalram_pages() + total_swap_pages)
	         goto error;

Thanks,
Feng

> 
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..fa78f90e29a1 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -798,10 +798,6 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
>  
> -	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> -			-(s64)vm_committed_as_batch * num_online_cpus(),
> -			"memory commitment underflow");
> -
>  	vm_acct_memory(pages);
>  
>  	/*
> @@ -810,6 +806,10 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
>  		return 0;
>  
> +	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> +			-(s64)vm_committed_as_batch * num_online_cpus(),
> +			"memory commitment underflow");
> +
>  	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
>  		if (pages > totalram_pages() + total_swap_pages)
>  			goto error;
