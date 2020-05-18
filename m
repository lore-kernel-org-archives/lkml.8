Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE38C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D640E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMECPHCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgERJCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:02:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ei2i021Oqr6dJFVTXCWHRag3lixtaMTRU/YlTdPchXM=; b=TMECPHCwQiRlSU3YGHH1wQxVPB
        1AYaZwzglqQvHBBwEM5suKG8toOa+PYaWT4W3/naompx0HlCbBygTOCWSRkApjABQUoE8C6piN6D4
        BDIKVxZM6DYd6leMlZv3Li++3zwBz9MYF8rcsuOYrroxn0lVTGE5YVPDih4kHHjN7K3t4oaLhSZav
        UZpDLfYsvdv0wSWE3OP9JlfaCk4Sc1O6cQInHhnxPff3pogV+XHV7wIU6RHGxq65kkg+Sh4mBiN8A
        93OPeFWfgcLVtOnnNuZojTM+9HwAVRe3zG71FEZLpdf5L0anFTcIXnGBXqcwT8IHuOS5/RokASgO4
        yTK8Cj3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jabb4-0004dp-7j; Mon, 18 May 2020 08:58:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D46E93011F0;
        Mon, 18 May 2020 10:57:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B82EA20BE636D; Mon, 18 May 2020 10:57:58 +0200 (CEST)
Date:   Mon, 18 May 2020 10:57:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Message-ID: <20200518085758.GK2940@hirez.programming.kicks-ass.net>
References: <20200515003429.4317-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515003429.4317-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:29AM +0200, Frederic Weisbecker wrote:
> So far setting a tick dependency on any task, including current, used to
> trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
> an issue as long as it was only used by posix-cpu-timers on nohz_full,
> a combo that nobody seemed to use in real life.
> 
> But RCU started to use task tick dependency on current task to fix
> stall issues on callbacks processing. These trigger regular and
> undesired system wide IPIs on nohz_full.
> 
> The fix is very easy while setting a tick dependency on the current
> task, only its CPU needs an IPI.
> 
> Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
> Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: stable@kernel.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/time/tick-sched.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 3e2dc9b8858c..f0199a4ba1ad 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
>  EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
>  
>  /*
> - * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
> - * per task timers.
> + * Set a per-task tick dependency. RCU need this. Also posix CPU timers
> + * in order to elapse per task timers.
>   */
>  void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
>  {
> -	/*
> -	 * We could optimize this with just kicking the target running the task
> -	 * if that noise matters for nohz full users.
> -	 */
> -	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
> +	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {

So why not simply:

		tick_nohz_full_kick_cpu(task_cpu(tsk)); ?

If it got preempted, the scheduling involved would already have observed
the bit we just set and kept the tick on anyway, same for migration.

Or am I missing something?

> +		if (tsk == current) {
> +			preempt_disable();
> +			tick_nohz_full_kick();
> +			preempt_enable();
> +		} else {
> +			/*
> +			 * Some future tick_nohz_full_kick_task()
> +			 * should optimize this.
> +			 */
> +			tick_nohz_full_kick_all();
> +		}
> +	}

