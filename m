Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9CBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC146206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGGDYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:24:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:18678 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgGGDYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:24:46 -0400
IronPort-SDR: aIBXuSXs3M95yXAdMx3dvFv3CsAzQf6QUrBHZgUgHoJHxqePsjUSPwjE7iptyq9nBCWlU3Xw9a
 lp0D0spvZW6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="134998742"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="134998742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 20:24:45 -0700
IronPort-SDR: zSVTX1Nq7QXFBpZ1GVH8tusaG2I8RYXGEBq1xPESk6/tU3IyaQsoZmIhFXW8u7SBI6JpJEjI+g
 imJHTpyPnxtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456955198"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 20:24:40 -0700
Date:   Tue, 7 Jul 2020 11:24:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707032439.GA21741@shbuild999.sh.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
 <20200707010651.GA2384124@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707010651.GA2384124@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:06:51AM +0000, Dennis Zhou wrote:
> On Mon, Jul 06, 2020 at 09:24:43PM +0800, Feng Tang wrote:
> > Hi All,
> > 
> > Please help to review this fix patch, thanks!
> > 
> > It is against today's linux-mm tree. For easy review, I put the fix
> > into one patch, and I could split it to 2 parts for percpu-counter
> > and mm/util.c if it's preferred.
> > 
> > From 593f9dc139181a7c3bb1705aacd1f625f400e458 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Mon, 6 Jul 2020 14:48:29 +0800
> > Subject: [PATCH] mm/util.c: sync vm_committed_as when changing memory policy
> >  to OVERCOMMIT_NEVER
> > 
> > With the patch to improve scalability of vm_committed_as [1], 0day reported
> > the ltp overcommit_memory test case could fail (fail rate is about 5/50) [2].
> > The root cause is when system is running with loose memory overcommit policy
> > like OVERCOMMIT_GUESS/ALWAYS, the deviation of vm_committed_as could be big,
> > and once the policy is runtime changed to OVERCOMMIT_NEVER, vm_committed_as's 
> > batch is decreased to 1/64 of original one, but the deviation is not
> > compensated accordingly, and following __vm_enough_memory() check for vm
> > overcommit could be wrong due to this deviation, which breaks the ltp
> > overcommit_memory case.
> > 
> > Fix it by forcing a sync for percpu counter vm_committed_as when overcommit
> > policy is changed to OVERCOMMIT_NEVER (sysctl -w vm.overcommit_memory=2).
> > The sync itself is not a fast operation, and is toleratable given user is
> > not expected to frequently changing policy to OVERCOMMIT_NEVER.
> > 
> > [1] https://lore.kernel.org/lkml/1592725000-73486-1-git-send-email-feng.tang@intel.com/
> > [2] https://marc.info/?l=linux-mm&m=159367156428286 (can't find a link in lore.kernel.org)
> > 
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  include/linux/percpu_counter.h |  4 ++++
> >  lib/percpu_counter.c           | 14 ++++++++++++++
> >  mm/util.c                      | 11 ++++++++++-
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> > index 0a4f54d..01861ee 100644
> > --- a/include/linux/percpu_counter.h
> > +++ b/include/linux/percpu_counter.h
> > @@ -44,6 +44,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
> >  			      s32 batch);
> >  s64 __percpu_counter_sum(struct percpu_counter *fbc);
> >  int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
> > +void percpu_counter_sync(struct percpu_counter *fbc);
> >  
> >  static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
> >  {
> > @@ -172,6 +173,9 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
> >  	return true;
> >  }
> >  
> > +static inline void percpu_counter_sync(struct percpu_counter *fbc)
> > +{
> > +}
> >  #endif	/* CONFIG_SMP */
> >  
> >  static inline void percpu_counter_inc(struct percpu_counter *fbc)
> > diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> > index a66595b..02d87fc 100644
> > --- a/lib/percpu_counter.c
> > +++ b/lib/percpu_counter.c
> > @@ -98,6 +98,20 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> >  }
> >  EXPORT_SYMBOL(percpu_counter_add_batch);
> >  
> > +void percpu_counter_sync(struct percpu_counter *fbc)
> > +{
> > +	unsigned long flags;
> > +	s64 count;
> > +
> > +	raw_spin_lock_irqsave(&fbc->lock, flags);
> > +	count = __this_cpu_read(*fbc->counters);
> > +	fbc->count += count;
> > +	__this_cpu_sub(*fbc->counters, count);
> > +	raw_spin_unlock_irqrestore(&fbc->lock, flags);
> > +}
> > +EXPORT_SYMBOL(percpu_counter_sync);
> > +
> > +
> >  /*
> >   * Add up all the per-cpu counts, return the result.  This is a more accurate
> >   * but much slower version of percpu_counter_read_positive()
> > diff --git a/mm/util.c b/mm/util.c
> > index 52ed9c1..5fb62c0 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -746,14 +746,23 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
> >  	return ret;
> >  }
> >  
> > +static void sync_overcommit_as(struct work_struct *dummy)
> > +{
> > +	percpu_counter_sync(&vm_committed_as);
> > +}
> > +
> 
> This seems like a rather niche use case as it's currently coupled with a
> schedule_on_each_cpu(). I can't imagine a use case where you'd want to
> do this without being called by schedule_on_each_cpu().

Yes!

> 
> Would it be better to modify or introduce something akin to
> percpu_counter_sum() which sums and folds in the counter state? I'd be
> curious to see what the cost of always folding would be as this is
> already considered the cold path and would help with the next batch too.

Initially, I also thought about doing the sync just like percpu_counter_sum():

	raw_spin_lock_irqsave
	for_each_online_cpu(cpu)			}
		do-the-sync	
	raw_spin_unlock_irqrestore

One problem is the per_cpu_ptr(fbc->counters, cpu) could still be
updated on other CPUs as the fast path update is not protected by
fbc->lock.

As for cost, it is about about 800 nanoseconds on a 2C/4T platform 
and 2~3 microseconds on a 2S/36C/72T Skylake server in normal case,
and in worst case where vm_committed_as's spinlock is under severe
contention, it costs 30~40 microseconds for the 2S/36C/72T Skylake
sever.

Thanks,
Feng


> >  int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
> >  		size_t *lenp, loff_t *ppos)
> >  {
> >  	int ret;
> >  
> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > -	if (ret == 0 && write)
> > +	if (ret == 0 && write) {
> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > +			schedule_on_each_cpu(sync_overcommit_as);
> > +
> >  		mm_compute_batch();
> > +	}
> >  
> >  	return ret;
> >  }
> > -- 
> > 2.7.4
