Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFBA206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRlw7Ngz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgG3DqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3DqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:46:03 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE52C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:46:03 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so8960073qvl.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QgG2pHZtzg+utCxk++co6vrqhlVkfARpiFmAbKQSZq0=;
        b=eRlw7NgzZkV0KZc8tWTsyR0CkrSQ46rTzIWPm1kuPEtNL+OdEMZy6eR634Z/5+eFPj
         5zlSBUG6y75pTky/dcKsotlh7fgEJPCMaN+JB9XrM9tkhlOOB4OqBvTsbmDaXz/sVFhe
         bunfJTyEfd/pI7HliLKuucpWCoer5Z9bOD6/hledoqQHaBDX1kpA30cG/Tz8cxOVwLQ2
         VjYOc9rwalebyBdcMdxYouiNhFLJSFl4YkoA1AjNcjHDrAYARBr5gYhsEYdgZFWqVJnA
         lzXqa152b5qudf6FGAKDey4FxTJU+VOdPU/tElbLmE++TdH37hVtQtFCMsZEcdpaGf69
         9yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QgG2pHZtzg+utCxk++co6vrqhlVkfARpiFmAbKQSZq0=;
        b=BFuSWnhrt5IFpUxQINN0mhCC6/BFLa/m95iXeXCnX/HsM9MvKPSW5WryyYbg5mO34M
         NLaGkFbOJg8ZfCaLAZEdpB9KFDMrlpVYCZBq4QIZ/98fV8T55KV3ydDGKmyoJmYPYOwC
         lVi3sLfFJQOcWXtGw0pFOIMGYtbamvmNz/dStgf4xKHHs6R8fCXabnDWftuKXMJdKxlk
         h4ct/9HZjUu2OyRvLMoNmj5j7tLTMl3JqTXwEQGSmgtht0qsko8ZXDCsfXSfgRGpZDNr
         RhME9z7YmwLZQu2vmBHanGZQ8Y3NuxoVdtk6sYMgSnX5jhth2BoO+mXWKEykJETy1YKL
         C7kA==
X-Gm-Message-State: AOAM531CZgc8AfvcDxYcV4nI+SJeDXOF6mB/1ZF/jTu9gxBOy6J8nyi1
        ZFTAWAEPYR2+sZuVSGb7TxbEPw==
X-Google-Smtp-Source: ABdhPJx11Tcm2F5B3aZDniw3WcAJyf9VmBLXTFk6bv3UutTupQP+sUb+ZU0Twt9xtq3CbpvGahY1Zg==
X-Received: by 2002:a0c:cd02:: with SMTP id b2mr1022705qvm.150.1596080762196;
        Wed, 29 Jul 2020 20:46:02 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w1sm3258618qkj.90.2020.07.29.20.45.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2020 20:46:00 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:45:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200714173920.3319063-1-guro@fb.com>
Message-ID: <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Roman Gushchin wrote:

> I've noticed a number of warnings like "vmstat_refresh: nr_free_cma
> -5" or "vmstat_refresh: nr_zone_write_pending -11" on our production
> hosts. The numbers of these warnings were relatively low and stable,
> so it didn't look like we are systematically leaking the counters.
> The corresponding vmstat counters also looked sane.

nr_zone_write_pending: yes, I've looked at our machines, and see that
showing up for us too (-49 was the worst I saw).  Not at all common,
but seen.  And not followed by increasingly worse numbers, so a state
that corrects itself.  nr_dirty too (fewer instances, bigger numbers);
but never nr_writeback, which you'd expect to go along with those.

I wish I could explain that (I've wondered if somewhere delays
incrementing the stat, and can be interrupted by the decrementer of
the stat before it has reached incrementing), but have not succeeded.
Perhaps it is all down to the vmstat_refresh() skid that you hide in
this patch; but I'm not convinced.

> 
> These warnings are generated by the vmstat_refresh() function, which
> assumes that atomic zone and numa counters can't go below zero.
> However, on a SMP machine it's not quite right: due to per-cpu
> caching it can in theory be as low as -(zone threshold) * NR_CPUs.
> 
> For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
> reached 0. Then we've reclaimed a small number of cma pages on each
> CPU except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are
> slightly positive (the atomic counter is still 0). Then somebody on
> CPU0 consumes all these pages. The number of pages can easily exceed
> the threshold and a negative value will be committed to the atomic
> counter.
> 
> To fix the problem and avoid generating false warnings, let's just
> relax the condition and warn only if the value is less than minus
> the maximum theoretically possible drift value, which is 125 *
> number of online CPUs. It will still allow to catch systematic leaks,
> but will not generate bogus warnings.

Sorry, but despite the acks of others, I want to NAK this in its
present form.

You're right that there's a possibility of a spurious warning,
but is that so terrible?

I'm imagining a threshold of 125, and 128 cpus, and the following
worst case.  Yes, it is possible that when vmstat_refresh() schedules
its refresh on all the cpus, that the first 127 cpus to complete all
sync a count of 0, but immediately after each allocates 125 of whatever
(raising their per-cpu counters without touching the global counter);
and then, before the 128th cpu starts its sync, somehow that 128th
gets to be the lucky cpu to free all of those 127*125 items,
so arriving at a mistaken count of -15875 for that stat.

And I guess you could even devise a test which conspires to do that.
But is it so likely, that it's worth throwing away the warning when
we leak (or perhaps it's unleak) 16000 huge pages?  I don't think so:
I think it makes those warnings pretty much useless, and it would be
better just to delete the code that issues them.

But there's other things you could do, that we can probably agree on.

When stat_refresh first went in, there were two stats (NR_ALLOC_BATCH
and NR_PAGES_SCANNED) which were peculiarly accounted, and gave rise
to negative reports: the original commit just filtered those cases out
in a switch.  Maybe you should filter out NR_ZONE_WRITE_PENDING and
NR_FREE_CMA_PAGES, if there's nothing to fix in their accounting.

I'm not sure exactly what your objection is to the warning: would
you prefer pr_info or pr_debug to pr_warn?  I'd prefer to leave it
as pr_warn, but can compromise.

(IIRC xfstests can fail a test if an unexpected message appears
in the log; but xfstests does not use /proc/sys/vm/stat_refresh.)

But a better idea is perhaps to redefine the behavior of
"echo >/proc/sys/vm/stat_refresh".  What if
"echo someparticularstring >/proc/sys/vm/stat_refresh" were to
disable or enable the warning (permanently? or just that time?):
disable would be more "back-compatible", but I think it's okay
if you prefer enable.  Or "someparticularstring" could actually
specify the warning threshold you want to use - you might echo
125 or 16000, I might echo 0.  We can haggle over the default.

And there's a simpler change we already made internally: we didn't
mind the warning at all, but the accompanying -EINVALs became very
annoying.  A lot of testing scripts have "set -e" in them, and for
test B of feature B to fail because earlier test A of feature A
had tickled a bug in A that wrapped some stat negative, that
was very irritating.  We deleted those "err = -EINVAL;"s -
which might be what's actually most annoying you too?

Nit in this patch called out below.

Hugh

> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Hugh Dickins <hughd@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst |  4 ++--
>  mm/vmstat.c                             | 30 ++++++++++++++++---------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 4b9d2e8e9142..95fb80d0c606 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -822,8 +822,8 @@ e.g. cat /proc/sys/vm/stat_refresh /proc/meminfo
>  
>  As a side-effect, it also checks for negative totals (elsewhere reported
>  as 0) and "fails" with EINVAL if any are found, with a warning in dmesg.
> -(At time of writing, a few stats are known sometimes to be found negative,
> -with no ill effects: errors and warnings on these stats are suppressed.)
> +(On a SMP machine some stats can temporarily become negative, with no ill
> +effects: errors and warnings on these stats are suppressed.)
>  
>  
>  numa_stat
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index a21140373edb..8f0ef8aaf8ee 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -169,6 +169,8 @@ EXPORT_SYMBOL(vm_node_stat);
>  
>  #ifdef CONFIG_SMP
>  
> +#define MAX_THRESHOLD 125
> +
>  int calculate_pressure_threshold(struct zone *zone)
>  {
>  	int threshold;
> @@ -186,11 +188,9 @@ int calculate_pressure_threshold(struct zone *zone)
>  	threshold = max(1, (int)(watermark_distance / num_online_cpus()));
>  
>  	/*
> -	 * Maximum threshold is 125
> +	 * Threshold is capped by MAX_THRESHOLD
>  	 */
> -	threshold = min(125, threshold);
> -
> -	return threshold;
> +	return min(MAX_THRESHOLD, threshold);
>  }
>  
>  int calculate_normal_threshold(struct zone *zone)

calculate_normal_threshold() also contains a 125:
better change that to MAX_THRESHOLD too, if you do pursue this.

> @@ -610,6 +610,9 @@ void dec_node_page_state(struct page *page, enum node_stat_item item)
>  }
>  EXPORT_SYMBOL(dec_node_page_state);
>  #else
> +
> +#define MAX_THRESHOLD 0
> +
>  /*
>   * Use interrupt disable to serialize counter updates
>   */
> @@ -1810,7 +1813,7 @@ static void refresh_vm_stats(struct work_struct *work)
>  int vmstat_refresh(struct ctl_table *table, int write,
>  		   void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	long val;
> +	long val, max_drift;
>  	int err;
>  	int i;
>  
> @@ -1821,17 +1824,22 @@ int vmstat_refresh(struct ctl_table *table, int write,
>  	 * pages, immediately after running a test.  /proc/sys/vm/stat_refresh,
>  	 * which can equally be echo'ed to or cat'ted from (by root),
>  	 * can be used to update the stats just before reading them.
> -	 *
> -	 * Oh, and since global_zone_page_state() etc. are so careful to hide
> -	 * transiently negative values, report an error here if any of
> -	 * the stats is negative, so we know to go looking for imbalance.
>  	 */
>  	err = schedule_on_each_cpu(refresh_vm_stats);
>  	if (err)
>  		return err;
> +
> +	/*
> +	 * Since global_zone_page_state() etc. are so careful to hide
> +	 * transiently negative values, report an error here if any of
> +	 * the stats is negative and are less than the maximum drift value,
> +	 * so we know to go looking for imbalance.
> +	 */
> +	max_drift = num_online_cpus() * MAX_THRESHOLD;
> +
>  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>  		val = atomic_long_read(&vm_zone_stat[i]);
> -		if (val < 0) {
> +		if (val < -max_drift) {
>  			pr_warn("%s: %s %ld\n",
>  				__func__, zone_stat_name(i), val);
>  			err = -EINVAL;
> @@ -1840,7 +1848,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
>  #ifdef CONFIG_NUMA
>  	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
>  		val = atomic_long_read(&vm_numa_stat[i]);
> -		if (val < 0) {
> +		if (val < -max_drift) {
>  			pr_warn("%s: %s %ld\n",
>  				__func__, numa_stat_name(i), val);
>  			err = -EINVAL;
> -- 
> 2.26.2
