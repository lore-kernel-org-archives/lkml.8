Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE256C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976E3206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594084017;
	bh=ziMXvXXiWA3QdBqS7rIWZL/rSGsPD/0+WCWAhwU/hdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bBU+Ns/K2LhXnkJnZE7/cDW2clPC1OLM9TxbvMZKXvOO6NrlcKBUE0y4LwGaA21Ad
	 NHYVabdZBpp2KQGTaIoi0d5YKmSHEnoPvPs121tzHdNrQL0lwvyMPpdVI5H4fSwXq+
	 +iNB+/GJ/vDMe2Uftnrudo74norp2OkV5I/4VQFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGGBGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:06:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46127 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGGBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:06:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id x13so16895966vsx.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 18:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0rAY13BVmkOt6oIgOgE5Fk6r9TycBRd+bLvE307vPBA=;
        b=UvZnxUHAl4FoNp5yvH/hVHfCPOfD9oSgcOe8CIVSPmj286AL1YCcll+hPv0L0MVS90
         BDfT8Ava8nz+F+85VGWCYRkk6enakQhPt7u0Rcv5YaD/0eQOFQGC+W0xcFcFgESytUrp
         PEh99/nd4wPZnoebNLTKX4Q0zCyJDDoRej0LJEaGrXYeJBCFMbw9ucHyeA7oBYgoM6dW
         /8d3xi2oV6eHTSiPMoGmBrC8U8md9ha7ZtPM1E7YYBgVa/9U83TS5Y4A/MkaL14KyqD7
         CR+qD5IjzLjaeMpVq6wAb6x/0TUq7BJCK3CsXeSbH0dBCBwgE0EoTr1simJlePr9WvRJ
         b0qw==
X-Gm-Message-State: AOAM533vrlQFSNxr7hx3dND/PFCZaykHHIoCDpUe8o0+z4iZeMGlQNu6
        LLyBe48enaXO9ea4mDmBY+I=
X-Google-Smtp-Source: ABdhPJwLgFN+bIsY/8FQ1xDv6OvVHAUBcYPVJGpT4SuVimv86Vc8B2gcRq32LkK1U+B5AON1k2Jfeg==
X-Received: by 2002:a05:6102:21b4:: with SMTP id i20mr39117138vsb.164.1594084013542;
        Mon, 06 Jul 2020 18:06:53 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id t23sm76680vsa.20.2020.07.06.18.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 18:06:52 -0700 (PDT)
Date:   Tue, 7 Jul 2020 01:06:51 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
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
Message-ID: <20200707010651.GA2384124@google.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706132443.GA34488@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:24:43PM +0800, Feng Tang wrote:
> Hi All,
> 
> Please help to review this fix patch, thanks!
> 
> It is against today's linux-mm tree. For easy review, I put the fix
> into one patch, and I could split it to 2 parts for percpu-counter
> and mm/util.c if it's preferred.
> 
> From 593f9dc139181a7c3bb1705aacd1f625f400e458 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Mon, 6 Jul 2020 14:48:29 +0800
> Subject: [PATCH] mm/util.c: sync vm_committed_as when changing memory policy
>  to OVERCOMMIT_NEVER
> 
> With the patch to improve scalability of vm_committed_as [1], 0day reported
> the ltp overcommit_memory test case could fail (fail rate is about 5/50) [2].
> The root cause is when system is running with loose memory overcommit policy
> like OVERCOMMIT_GUESS/ALWAYS, the deviation of vm_committed_as could be big,
> and once the policy is runtime changed to OVERCOMMIT_NEVER, vm_committed_as's 
> batch is decreased to 1/64 of original one, but the deviation is not
> compensated accordingly, and following __vm_enough_memory() check for vm
> overcommit could be wrong due to this deviation, which breaks the ltp
> overcommit_memory case.
> 
> Fix it by forcing a sync for percpu counter vm_committed_as when overcommit
> policy is changed to OVERCOMMIT_NEVER (sysctl -w vm.overcommit_memory=2).
> The sync itself is not a fast operation, and is toleratable given user is
> not expected to frequently changing policy to OVERCOMMIT_NEVER.
> 
> [1] https://lore.kernel.org/lkml/1592725000-73486-1-git-send-email-feng.tang@intel.com/
> [2] https://marc.info/?l=linux-mm&m=159367156428286 (can't find a link in lore.kernel.org)
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  include/linux/percpu_counter.h |  4 ++++
>  lib/percpu_counter.c           | 14 ++++++++++++++
>  mm/util.c                      | 11 ++++++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 0a4f54d..01861ee 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -44,6 +44,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>  			      s32 batch);
>  s64 __percpu_counter_sum(struct percpu_counter *fbc);
>  int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
> +void percpu_counter_sync(struct percpu_counter *fbc);
>  
>  static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
>  {
> @@ -172,6 +173,9 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>  	return true;
>  }
>  
> +static inline void percpu_counter_sync(struct percpu_counter *fbc)
> +{
> +}
>  #endif	/* CONFIG_SMP */
>  
>  static inline void percpu_counter_inc(struct percpu_counter *fbc)
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index a66595b..02d87fc 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -98,6 +98,20 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
>  }
>  EXPORT_SYMBOL(percpu_counter_add_batch);
>  
> +void percpu_counter_sync(struct percpu_counter *fbc)
> +{
> +	unsigned long flags;
> +	s64 count;
> +
> +	raw_spin_lock_irqsave(&fbc->lock, flags);
> +	count = __this_cpu_read(*fbc->counters);
> +	fbc->count += count;
> +	__this_cpu_sub(*fbc->counters, count);
> +	raw_spin_unlock_irqrestore(&fbc->lock, flags);
> +}
> +EXPORT_SYMBOL(percpu_counter_sync);
> +
> +
>  /*
>   * Add up all the per-cpu counts, return the result.  This is a more accurate
>   * but much slower version of percpu_counter_read_positive()
> diff --git a/mm/util.c b/mm/util.c
> index 52ed9c1..5fb62c0 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -746,14 +746,23 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
>  	return ret;
>  }
>  
> +static void sync_overcommit_as(struct work_struct *dummy)
> +{
> +	percpu_counter_sync(&vm_committed_as);
> +}
> +

This seems like a rather niche use case as it's currently coupled with a
schedule_on_each_cpu(). I can't imagine a use case where you'd want to
do this without being called by schedule_on_each_cpu().

Would it be better to modify or introduce something akin to
percpu_counter_sum() which sums and folds in the counter state? I'd be
curious to see what the cost of always folding would be as this is
already considered the cold path and would help with the next batch too.

>  int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
>  
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -	if (ret == 0 && write)
> +	if (ret == 0 && write) {
> +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +			schedule_on_each_cpu(sync_overcommit_as);
> +
>  		mm_compute_batch();
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.7.4
>      
> 
> On Sun, Jul 05, 2020 at 10:36:14PM -0400, Qian Cai wrote:
> > > In my last email, I was not saying OVERCOMMIT_NEVER is not a normal case,
> > > but I don't think user will too frequently runtime change the overcommit
> > > policy. And the fix patch of syncing 'vm_committed_as' is only called when
> > > user calls 'sysctl -w vm.overcommit_memory=2'.
> > > 
> > > > The question is now if any of those regression fixes would now regress
> > > > performance of OVERCOMMIT_NEVER workloads or just in-par with the data
> > > > before the patchset?
> > > 
> > > For the original patchset, it keeps vm_committed_as unchanged for
> > > OVERCOMMIT_NEVER policy and enlarge it for the other 2 loose policies
> > > OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS, and I don't expect the "OVERCOMMIT_NEVER
> > > workloads" performance  will be impacted. If you have suggetions for this
> > > kind of benchmarks, I can test them to better verify the patchset, thanks!
> > 
> > Then, please capture those information into a proper commit log when you
> > submit the regression fix on top of the patchset, and CC PER-CPU MEMORY
> > ALLOCATOR maintainers, so they might be able to review it properly.
> 
> 
> 

Thanks,
Dennis
