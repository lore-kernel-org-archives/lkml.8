Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03807C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EA52074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UKMksTa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFLNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:21:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89758C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:21:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so7078351qtg.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DD0ihgapksKy9e/gq8dIvq5dhFNIV5ERaS7Go6iCQUo=;
        b=UKMksTa3BWdxqJpr7nmMqJk74n8YFl5b7DRAKt+jtchVR3pOeJM0TnXuL/EfOsg9ig
         Uj0svNzq4Z0qHX26F9tryAbYNnRzpiQADaXt8GIoZU4hM1tYG73Fwtr3KbAn9nOEsktZ
         oP8mF5TZVe6+r/ykXAhh3gw0id6OjRVlqTMD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DD0ihgapksKy9e/gq8dIvq5dhFNIV5ERaS7Go6iCQUo=;
        b=f0AQlf38jF8bDB93VfX1dgKyJyIlkcx/wOlm4sil093uZ28QXoqKqlN3IwxiDCC4iw
         wn6KV2sLjetsi3ZvEJRezNalDoWU8bJS7LmrzGy4jvRrqivcChpPiEKHKzNaQi8VHaQo
         Xuz8Blk0o7c/2yCK9IV/WwrYBPiDeIn2ayB5SoDTbvexlapUMEtNN8b9VcUQPbgDi9aE
         RDy5Lhnjlb6el+Q9/iCdP+VH2HeYi1bx09CtQiLbElhZM7mBICCemVH7PRQVRYZ8jufG
         ha0lUjkA3EMOPBgFIGVkSJUhSE/9gc9j4cz2hXc1Z1OoAzyMCq7wbTwBi6347dkRToHk
         C+Yg==
X-Gm-Message-State: AOAM5317jaxhP2J4FeFxJyOtiw/EX8kkkZ7sBYvMaiEFpeEczWtm7mup
        k2WlrStHGiRSfIz25jwiHQpG0w==
X-Google-Smtp-Source: ABdhPJxqypBED+Rp1Idhw/ttaRiPZVL5OJj9thMlgVARJ6DO77reX8cMmALLmPN2nwd15RBm2gPzQQ==
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr2869558qtk.320.1591968088673;
        Fri, 12 Jun 2020 06:21:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x36sm4693626qtd.97.2020.06.12.06.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:21:27 -0700 (PDT)
Date:   Fri, 12 Jun 2020 09:21:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 11/13] sched: migration changes for core scheduling
Message-ID: <20200612132127.GA90012@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:00:01PM +0000, vpillai wrote:
> From: Aubrey Li <aubrey.li@intel.com>
> 
>  - Don't migrate if there is a cookie mismatch
>      Load balance tries to move task from busiest CPU to the
>      destination CPU. When core scheduling is enabled, if the
>      task's cookie does not match with the destination CPU's
>      core cookie, this task will be skipped by this CPU. This
>      mitigates the forced idle time on the destination CPU.
> 
>  - Select cookie matched idle CPU
>      In the fast path of task wakeup, select the first cookie matched
>      idle CPU instead of the first idle CPU.
> 
>  - Find cookie matched idlest CPU
>      In the slow path of task wakeup, find the idlest CPU whose core
>      cookie matches with task's cookie
> 
>  - Don't migrate task if cookie not match
>      For the NUMA load balance, don't migrate task to the CPU whose
>      core cookie does not match with task's cookie
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> ---
>  kernel/sched/fair.c  | 55 +++++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h | 29 +++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c9a80d8dbb8..f42ceecb749f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1789,6 +1789,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>  			continue;
>  
> +#ifdef CONFIG_SCHED_CORE
> +		/*
> +		 * Skip this cpu if source task's cookie does not match
> +		 * with CPU's core cookie.
> +		 */
> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> +			continue;
> +#endif
> +
>  		env->dst_cpu = cpu;
>  		task_numa_compare(env, taskimp, groupimp, maymove);
>  	}
> @@ -5660,8 +5669,13 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  
>  	/* Traverse only the allowed CPUs */
>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +		struct rq *rq = cpu_rq(i);
> +
> +#ifdef CONFIG_SCHED_CORE
> +		if (!sched_core_cookie_match(rq, p))
> +			continue;
> +#endif
>  		if (available_idle_cpu(i)) {
> -			struct rq *rq = cpu_rq(i);
>  			struct cpuidle_state *idle = idle_get_state(rq);
>  			if (idle && idle->exit_latency < min_exit_latency) {
>  				/*
> @@ -5927,8 +5941,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  			return si_cpu;
>  		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  			continue;
> +#ifdef CONFIG_SCHED_CORE
> +		if (available_idle_cpu(cpu) &&
> +		    sched_core_cookie_match(cpu_rq(cpu), p))
> +			break;
> +#else

select_idle_cpu() is called only if no idle core could be found in the LLC by
select_idle_core().

So, would it be better here to just do the cookie equality check directly
instead of calling the sched_core_cookie_match() helper?  More so, because
select_idle_sibling() is a fastpath.

AFAIR, that's what v4 did:

                if (available_idle_cpu(cpu))
#ifdef CONFIG_SCHED_CORE
                        if (sched_core_enabled(cpu_rq(cpu)) &&
                            (p->core_cookie == cpu_rq(cpu)->core->core_cookie))
                                break;
#else
                        break;
#endif


Thoughts? thanks,

 - Joel

