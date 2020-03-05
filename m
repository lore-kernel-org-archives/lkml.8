Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0513C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F68E208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaETOaEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCEEdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:33:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44760 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgCEEdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:33:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id y26so2106794pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmQ5FyHouNnsdD5UAEEsRkVBnVM3x/Md8IuYlmoi1Fk=;
        b=aaETOaEHTcbQ+HBu2MR5sZx8ToLqh2MoLdegXaGqilVDbOBlKIndKonzypo9p3HR/n
         aWxsghf9fsWhntui86tUKWKuagBXP/hEhBsU/+cUvrxLkdKrLxbpH5KJBXXgoJMT+BMD
         pS0Bsy4MafIEP6X5cAKj7QDTrSLpRj7ylKenjkz9EiBJZgLDBm0pkjh9TAopj8N1uvg+
         CB1rJUJQ9Q4CuuIn4kMu8XIvDzm10fntU1/nbzRph2njys4IPJ/d20LXolX7aDO38Eed
         zHWIlltnut/PTU3tCi5Jb4X7Xy2L5pGeYRrncVMMteatHdX2riRBlYVmN6H8OeqIPJtE
         DO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmQ5FyHouNnsdD5UAEEsRkVBnVM3x/Md8IuYlmoi1Fk=;
        b=BZttk09yMBLnMF9SZ2cIgHEit4c+ucDbxYOVJyCyILavin9bS1kErFaJRGRKH2t0qT
         7/4iUDHadWgqN7jNnNdBHpCKnJZJjVhh0XihU4tC/H3gFUSJqMfLrsupIv5205gh5HNp
         w49WffKIYSid7m6p37wjOTFUbe+Y/WmY/p1Hqzh4bSpC3zcq6ndcTG2PgsnUeAz6t6Cn
         MM8DYM/G6HM9ZAgHbLCA15JAfwrfJJZLVasZOwGE4jCsmEljwwZa4prhJ2ZTViRbPCMP
         F2Nl2UTd7KgTXEKXJu2HAqdtujcWK7/FbkLXZbGiW3ry9ubAAKO/m+A+vebqTna6gjfT
         85qw==
X-Gm-Message-State: ANhLgQ2hUuPt8H4r1AtPTqMXdVwHhgzb2ryMTojzHSVJRgKiBpx6vyu+
        +yQcZDR/fyNN2+2xPzRvHYhf3BtqBDY=
X-Google-Smtp-Source: ADFU+vv0tZBE8q88rWgxSlobQOCg3AJvmbuZES749+zABhmZAcunrklOPupTsNvq1e9T59nFMSgsuQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11mr6676747pfg.38.1583382820915;
        Wed, 04 Mar 2020 20:33:40 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id 28sm29350300pgl.42.2020.03.04.20.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 20:33:39 -0800 (PST)
Date:   Thu, 5 Mar 2020 12:33:30 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200305043330.GA8755@ziqianlu-desktop.localdomain>
References: <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com>
 <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
 <bcd601e7-3f15-e340-bebe-a6ca3635dacb@linux.intel.com>
 <a55bb7a5-bb20-d3f3-e634-4dfda1ac6005@linux.intel.com>
 <67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:54:39AM +0800, Li, Aubrey wrote:
> On 2020/3/3 22:59, Li, Aubrey wrote:
> > On 2020/2/29 7:55, Tim Chen wrote:
...
> >> In Vinnet's fix, we only look at the currently running task's weight in
> >> src and dst rq.  Perhaps the load on the src and dst rq needs to be considered
> >> to prevent too great an imbalance between the run queues?
> > 
> > We are trying to migrate a task, can we just use cfs.h_nr_running? This signal
> > is used to find the busiest run queue as well.
> 
> How about this one? the cgroup weight issue seems fixed on my side.

It doesn't apply on top of your coresched_v4-v5.5.2 branch, so I
manually allied it. Not sure if I missed something.

It's now getting 4 cpus in 2 cores. Better, but not back to normal yet..

Thanks,
Aaron
 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f42ceec..90024cf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1767,6 +1767,8 @@ static void task_numa_compare(struct task_numa_env *env,
>  	rcu_read_unlock();
>  }
>  
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p);
> +
>  static void task_numa_find_cpu(struct task_numa_env *env,
>  				long taskimp, long groupimp)
>  {
> @@ -5650,6 +5652,44 @@ static struct sched_group *
>  find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  		  int this_cpu, int sd_flag);
>  
> +#ifdef CONFIG_SCHED_CORE
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +	struct rq *src_rq = task_rq(p);
> +	bool idle_core = true;
> +	int cpu;
> +
> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
> +	if (!sched_core_enabled(rq))
> +		return true;
> +
> +	if (rq->core->core_cookie == p->core_cookie)
> +		return true;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> +		if (!available_idle_cpu(cpu)) {
> +			idle_core = false;
> +			break;
> +		}
> +	}
> +	/*
> +	 * A CPU in an idle core is always the best choice for tasks with
> +	 * cookies.
> +	 */
> +	if (idle_core)
> +		return true;
> +
> +	/*
> +	 * Ignore cookie match if there is a big imbalance between the src rq
> +	 * and dst rq.
> +	 */
> +	if ((src_rq->cfs.h_nr_running - rq->cfs.h_nr_running) > 1)
> +		return true;
> +
> +	return false;
> +}
> +#endif
> +
>  /*
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
>   */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 7ae6858..8c607e9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1061,28 +1061,6 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>  	return &rq->__lock;
>  }
>  
> -static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> -{
> -	bool idle_core = true;
> -	int cpu;
> -
> -	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
> -	if (!sched_core_enabled(rq))
> -		return true;
> -
> -	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> -		if (!available_idle_cpu(cpu)) {
> -			idle_core = false;
> -			break;
> -		}
> -	}
> -	/*
> -	 * A CPU in an idle core is always the best choice for tasks with
> -	 * cookies.
> -	 */
> -	return idle_core || rq->core->core_cookie == p->core_cookie;
> -}
> -
>  extern void queue_core_balance(struct rq *rq);
>  
>  void sched_core_add(struct rq *rq, struct task_struct *p);
