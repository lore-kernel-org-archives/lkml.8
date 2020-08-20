Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5AC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pkhofzpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHTO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHTO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:58:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C9BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6VFu3ZhQ+wtKPnpd8cZL+f3G4fwE8SCvYtHvC7FRWbI=; b=PkhofzpozZcD6rnubPSz3AvFPh
        kcBHWT7UTHSI4XH/+NEMKZvPkWrEQMg6j+d8Si4PTMQ0G/rjVOO9g0qwCVcdv/zQu3GXBQPsiHGW7
        /MRx1sp7gb/VnmKKXFekoshkGutmsfhKRJifiI9kharE/gORnCGdQ6dhzaes3HN2HPsCNxgPrvzFW
        XhQX/PMtcW45VljOCi9voajplDBP6tsXAZh89CU9QpLA6BGE5qq/TBwF7vRKpo4i/kO4M1LMO+VgU
        bWRFQxcyuwceb6V/XSm6VcHHS9VbAG4EcT+N726MjaxTqELk2Dh2+cY6inPmBsYWs27eGiP0f/lqx
        jgVZ5FdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8m1I-0004Ah-MP; Thu, 20 Aug 2020 14:58:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB2DA302526;
        Thu, 20 Aug 2020 16:58:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AABC521296C37; Thu, 20 Aug 2020 16:58:21 +0200 (CEST)
Date:   Thu, 20 Aug 2020 16:58:21 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rjw@rjwysocki.net, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
References: <20200820073031.886217423@infradead.org>
 <20200820103643.1b9abe88@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820103643.1b9abe88@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:36:43AM -0400, Steven Rostedt wrote:
> 
> I tested this series on top of tip/master and triggered the below
> warning when running the irqsoff tracer boot up test (config attached).
> 
> -- Steve
> 
>  Testing tracer irqsoff: 
>  
>  =============================
>  WARNING: suspicious RCU usage
>  5.9.0-rc1-test+ #92 Not tainted
>  -----------------------------
>  include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
>  
>  other info that might help us debug this:
>  
>  
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  no locks held by swapper/2/0.
>  
>  stack backtrace:
>  CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.9.0-rc1-test+ #92
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  Call Trace:
>   dump_stack+0x8d/0xc0
>   lock_acquire.cold+0x23/0x2c
>   ? default_idle_call+0x4d/0x210
>   _raw_spin_lock_irqsave+0x50/0xa0
>   ? check_critical_timing+0x69/0x160
>   check_critical_timing+0x69/0x160
>   ? default_idle_call+0x4d/0x210
>   stop_critical_timings+0xdd/0xf0
>   default_idle_call+0x4d/0x210
>   do_idle+0x1f6/0x260
>   cpu_startup_entry+0x19/0x20
>   start_secondary+0x110/0x140
>   secondary_startup_64+0xb6/0xc0

Shiny, I think that wants something like the below, but let me go frob
my config and test it.

---
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -151,8 +151,8 @@ static void enter_s2idle_proper(struct c
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
-	rcu_idle_enter();
 	stop_critical_timings();
+	rcu_idle_enter();
 	drv->states[index].enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
@@ -164,8 +164,8 @@ static void enter_s2idle_proper(struct c
 	 * FIXME, order against rcu_idle_exit ?
 	 */
 	RCU_NONIDLE(tick_unfreeze());
-	start_critical_timings();
 	rcu_idle_exit();
+	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock());
 
@@ -236,11 +236,11 @@ int cpuidle_enter_state(struct cpuidle_d
 	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
-	rcu_idle_enter();
 	stop_critical_timings();
+	rcu_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
-	start_critical_timings();
 	rcu_idle_exit();
+	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -55,16 +55,16 @@ __setup("hlt", cpu_idle_nopoll_setup);
 static noinline int __cpuidle cpu_idle_poll(void)
 {
 	trace_cpu_idle(0, smp_processor_id());
+	stop_critical_timings();
 	rcu_idle_enter();
 	local_irq_enable();
-	stop_critical_timings();
 
 	while (!tif_need_resched() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 
-	start_critical_timings();
 	rcu_idle_exit();
+	start_critical_timings();
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
 	return 1;
@@ -91,11 +91,11 @@ void __cpuidle default_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 	} else {
-		rcu_idle_enter();
 		stop_critical_timings();
+		rcu_idle_enter();
 		arch_cpu_idle();
-		start_critical_timings();
 		rcu_idle_exit();
+		start_critical_timings();
 	}
 }
 
