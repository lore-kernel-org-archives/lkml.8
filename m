Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39EF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LoYridEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgE0J45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgE0J44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:56:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTmhp/04YIC3xuKgZgkBx4pbXjQ8GoI+myn03qcU1oI=; b=LoYridEsQCDHmseS8e5ZUg6QCW
        OycaYhfR1jCNlrMcS0FIyRCUn5IxwQrVCmb0+UAO3I5Pw/FGTupATLAmWwVXtXQbye6VyIZhwbudh
        Iipd5BqLHWbhyya+kBmzvPuo4keETHxmsWRlFWGpdZwkXnbwrKGo5nbrBvCBG3igdADeeCTHaQdDf
        whm4NjKu/5xpuxrGU0eTt3iwD09QFE7adycCul4SJF/D8HCOshW1YCTw0jMuF7Pi2HgIyUzo3ms91
        jI3Q4xzucKhR6xmUxsK7bfve69hvI54ffcnz3McYsBRYXu7enYZMHJkpGy5KV6bh2qGphRMiLPDRL
        ThPI2OCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdsnp-0002cm-AS; Wed, 27 May 2020 09:56:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF8BD3012C3;
        Wed, 27 May 2020 11:56:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A027720FF792B; Wed, 27 May 2020 11:56:45 +0200 (CEST)
Date:   Wed, 27 May 2020 11:56:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, paulmck@kernel.org
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200527095645.GH325280@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161907.953304789@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:11:01PM +0200, Peter Zijlstra wrote:
> Just like the ttwu_queue_remote() IPI, make use of _TIF_POLLING_NRFLAG
> to avoid sending IPIs to idle CPUs.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   10 ++++++++++
>  kernel/sched/idle.c  |    1 +
>  kernel/sched/sched.h |    2 ++
>  kernel/smp.c         |   16 +++++++++++++++-
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2296,6 +2296,16 @@ static void wake_csd_func(void *info)
>  	sched_ttwu_pending();
>  }
>  
> +void send_call_function_single_ipi(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (!set_nr_if_polling(rq->idle))
> +		arch_send_call_function_single_ipi(cpu);
> +	else
> +		trace_sched_wake_idle_without_ipi(cpu);
> +}
> +
>  /*
>   * Queue a task on the target CPUs wake_list and wake the CPU via IPI if
>   * necessary. The wakee CPU on receipt of the IPI will queue the task
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -289,6 +289,7 @@ static void do_idle(void)
>  	 */
>  	smp_mb__after_atomic();
>  
> +	flush_smp_call_function_from_idle();
>  	sched_ttwu_pending();
>  	schedule_idle();
>  

Paul; the above patch basically allows smp_call_function_single() to run
from the idle context (with IRQs disabled, obviously) instead of from an
actual IRQ context.

This makes RCU unhappy (as reported by mingo):

 [ ] ------------[ cut here ]------------
 [ ] Not in hardirq as expected
 [ ] WARNING: CPU: 4 PID: 0 at kernel/rcu/tree.c:430 rcu_is_cpu_rrupt_from_idle+0xed/0x110
 [ ] Modules linked in:
 [ ] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.7.0-rc7-00840-ga61d572-dirty #1
 [ ] Hardware name: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS 2.0b       03/01/2012
 [ ] RIP: 0010:rcu_is_cpu_rrupt_from_idle+0xed/0x110
 [ ] Call Trace:
 [ ]  rcu_exp_handler+0x38/0x90
 [ ]  flush_smp_call_function_queue+0xce/0x230
 [ ]  flush_smp_call_function_from_idle+0x2f/0x60
 [ ]  do_idle+0x163/0x260
 [ ]  cpu_startup_entry+0x19/0x20
 [ ]  start_secondary+0x14f/0x1a0
 [ ] irq event stamp: 189300
 [ ] hardirqs last  enabled at (189299): [<ffffffff811d3e25>] tick_nohz_idle_exit+0x55/0xb0
 [ ] hardirqs last disabled at (189300): [<ffffffff811da5f5>] flush_smp_call_function_from_idle+0x25/0x60
 [ ] softirqs last  enabled at (189284): [<ffffffff811280a0>] irq_enter_rcu+0x70/0x80
 [ ] softirqs last disabled at (189283): [<ffffffff81128085>] irq_enter_rcu+0x55/0x80

This is rcu_is_cpu_rrupt_from_idle()'s lockdep_assert_in_irq() tripping
up (it's comment is obviously a bit antiquated).

Now, if I read that code correctly, it actually relies on
rcu_irq_enter() and thus really wants to be in an interrupt. Is there
any way this code can be made to work from the new context too?

After all, all that really is different is not having gone throught he
bother of setting up the IRQ context, nothing else changed -- it just so
happens you actually relied on that ;/
