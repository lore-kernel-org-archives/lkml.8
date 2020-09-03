Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68463C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5A520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599145349;
	bh=EYOKFpQLAgzW+dO649MB9HSBeHEPjcKtWmQy4atVc+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XRNxQrCSk5w2tJsp/Z8j8d1HOmB8emWvAZrmk8+rgB8H33OQk0TH7f8qnzStF5LIp
	 g2URSFRCNggjtZsirnfHGYy6god2IYbhswm24M9Lwn9Zux5b+Vtj4bm4BTZ0q3VbQE
	 Sov5tFMUUjBT/Y+3m6i4AvaKBEYTpuBamvuCvI1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgICPC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgICPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:01:57 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5B720716;
        Thu,  3 Sep 2020 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599145316;
        bh=EYOKFpQLAgzW+dO649MB9HSBeHEPjcKtWmQy4atVc+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQL1BRvrnDVWgnu1Q/g2cezFqc5/XNoPWXXKb7j7H/iwHBzV0gme3PJONTTd9Hlw4
         U2MqV71nnjBKcXhWdigfQ+C56HmVeyxN33FxBBQcgevZ1vteRoccfQ8gMFouyYRBnl
         v1j03Ih9d9ZsMp6wnxn47spFc8pMYR0wVuBA/yX0=
Date:   Thu, 3 Sep 2020 17:01:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] nohz: try to avoid IPI when setting tick dependency
 for task
Message-ID: <20200903150152.GA5353@lenoir>
References: <20200825184147.948670309@fuller.cnet>
 <20200825184414.486721471@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825184414.486721471@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:41:49PM -0300, Marcelo Tosatti wrote:
> When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
> performed (to re-read the dependencies and possibly not re-enter
> nohz_full on a given CPU).
> 
> A common case is for applications that run on nohz_full= CPUs
> to not use POSIX timers (eg DPDK).
> 
> This patch optimizes tick_nohz_dep_set_task to avoid kicking
> all nohz_full= CPUs in case the task allowed mask does not
> intersect with nohz_full= CPU mask,
> when going through tick_nohz_dep_set_task.
> 
> This reduces interruptions to nohz_full= CPUs.
> 
> ---
>  kernel/time/tick-sched.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -383,11 +383,16 @@ void tick_nohz_dep_set_task(struct task_
>  			tick_nohz_full_kick();
>  			preempt_enable();
>  		} else {
> +			unsigned long flags;
> +
>  			/*
>  			 * Some future tick_nohz_full_kick_task()
> -			 * should optimize this.
> +			 * should further optimize this.
>  			 */
> -			tick_nohz_full_kick_all();
> +			raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +			if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
> +				tick_nohz_full_kick_all();
> +			raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
>  		}
>  	}
>  }
> 
> 

Not long ago, Peterz suggested that we simply do:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4ba1ad..42ce8e458013 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -357,17 +357,26 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
 	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
-		if (tsk == current) {
-			preempt_disable();
-			tick_nohz_full_kick();
-			preempt_enable();
-		} else {
-			/*
-			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
-			 */
-			tick_nohz_full_kick_all();
-		}
+		int cpu = task_cpu(tsk);
+
+		/*
+		 * If the task concurrently migrates to another cpu,
+		 * we guarantee it sees the new tick dependency upon
+		 * schedule.
+		 *
+		 * set_task_cpu(p, cpu);
+		 *   STORE p->cpu = @cpu
+		 * __schedule() (switch to task 'p')
+		 *   LOCK rq->lock
+		 *   smp_mb__after_spin_lock()		STORE p->tick_dep_mask
+		 *   tick_nohz_task_switch()		smp_mb() (atomic_fetch_or())
+		 *      LOAD p->tick_dep_mask		LOAD p->cpu
+		 */
+
+		preempt_disable();
+		if (cpu_online(cpu))
+			tick_nohz_full_kick_cpu(cpu);
+		preempt_enable();
 	}
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
