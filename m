Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45953C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314D02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391356AbgDNQUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391002AbgDNQUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:20:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7708720678;
        Tue, 14 Apr 2020 16:19:58 +0000 (UTC)
Date:   Tue, 14 Apr 2020 12:19:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cpumask: Make cpumask_any() truly random
Message-ID: <20200414121956.3687d6e9@gandalf.local.home>
In-Reply-To: <20200414150556.10920-3-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
        <20200414150556.10920-3-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 16:05:54 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> Commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> added a new cpumask_any_and_distribute() which truly returns a random
> cpu within the mask.
> 
> Previous patch renamed the function to cpumask_any_and(), so that old
> users can take advantage of the new randomness behavior.
> 
> Build up on that, and let cpumask_any() truly random too by re-using the
> logic from cpumask_any_and().
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Yury Norov <yury.norov@gmail.com>
> CC: Paul Turner <pjt@google.com>
> CC: Alexey Dobriyan <adobriyan@gmail.com>
> CC: Josh Don <joshdon@google.com>
> CC: Pavan Kondeti <pkondeti@codeaurora.org>
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpumask.h | 14 ++++++--------
>  lib/cpumask.c           | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index e4d6d140a67c..7fb25d256043 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -194,6 +194,11 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
>  	return 0;
>  }
>  
> +static inline int cpumask_any(const struct cpumask *src1p)
> +{
> +	return 0;
> +}
> +
>  static inline int cpumask_any_and(const struct cpumask *src1p,
>  				  const struct cpumask *src2p)
>  {
> @@ -251,6 +256,7 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
>  int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
>  unsigned int cpumask_local_spread(unsigned int i, int node);
> +int cpumask_any(const struct cpumask *srcp);
>  int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p);
>  
>  /**
> @@ -600,14 +606,6 @@ static inline void cpumask_copy(struct cpumask *dstp,
>  	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), nr_cpumask_bits);
>  }
>  
> -/**
> - * cpumask_any - pick a "random" cpu from *srcp
> - * @srcp: the input cpumask
> - *
> - * Returns >= nr_cpu_ids if no cpus set.
> - */
> -#define cpumask_any(srcp) cpumask_first(srcp)
> -
>  /**
>   * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
>   * @src1p: the first input
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index b527a153b023..bcac63e45374 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -259,3 +259,27 @@ int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p)
>  	return next;
>  }
>  EXPORT_SYMBOL(cpumask_any_and);
> +
> +/**
> + * cpumask_any - pick a "random" cpu from *srcp
> + * @srcp: the input cpumask
> + *
> + * Returns >= nr_cpu_ids if no cpus set.
> + */
> +int cpumask_any(const struct cpumask *srcp)
> +{
> +	int next, prev;
> +
> +	/* NOTE: our first selection will skip 0. */
> +	prev = __this_cpu_read(distribute_cpu_mask_prev);
> +
> +	next = cpumask_next(prev, srcp);
> +	if (next >= nr_cpu_ids)
> +		next = cpumask_first(srcp);
> +
> +	if (next < nr_cpu_ids)
> +		__this_cpu_write(distribute_cpu_mask_prev, next);

Do we care if this gets preempted and migrated to a new CPU where we read
"prev" from one distribute_cpu_mask_prev on one CPU and write it to another
CPU?

-- Steve

> +
> +	return next;
> +}
> +EXPORT_SYMBOL(cpumask_any);

