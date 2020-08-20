Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1D32076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOYQ2qUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgHTHu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHTHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C68C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OYLx5mxfIutc54xRo+CbyTsmOq/yjZvSPQ0mZkvF7LI=; b=DOYQ2qUFO6TB7tH1ifvbY0x7U5
        5LnOHneNXqN+4aq5l9SGVfGHAJsA2kPn/gbOai+EOzfBtHKtCl27uJ72IClgFgfevVs9t1o/Jc+UR
        9oaTupNePDV5j3cflUIgoC1WUJcKAdgFNP2uYTG8SaGxZN507s/jWAxdHP3bnrA0XWLgFBODMAe2A
        O3sz57GsGWMlztfcZSzBsg0eSy7yF7u7O9a11VqDWHs/c+xRcoKLRc7G2YRvDU65S8AAFOIcUso5l
        RJezLmS/mQrtrD26BAQczOQ5LFUA4GJVgkApGNfcCGulkvKLsC5NFGyKqQz1nczxdwOZ1k4BXb3th
        +2lXtGgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKU-0000Md-UN; Thu, 20 Aug 2020 07:49:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7443C305DD1;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57C8528B7E841; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.401636694@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH 2/9] sched,idle,rcu: Push rcu_idle deeper into the idle path
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
that the locking tracepoints were using RCU.

Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.

Specifically, sched_clock_idle_wakeup_event() will use ktime which
will use seqlocks which will tickle lockdep.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c            |   15 +++++++++++----
 kernel/sched/idle.c                  |   18 ++++++------------
 kernel/time/tick-broadcast-hrtimer.c |   29 ++++++++++++-----------------
 3 files changed, 29 insertions(+), 33 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -145,22 +145,27 @@ static void enter_s2idle_proper(struct c
 	 * executing it contains RCU usage regarded as invalid in the idle
 	 * context, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_freeze());
+	tick_freeze();
 	/*
 	 * The state used here cannot be a "coupled" one, because the "coupled"
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
+	rcu_idle_enter();
 	stop_critical_timings();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side
 	 * critical sections, so tell RCU about that.
+	 *
+	 * FIXME, order against rcu_idle_exit ?
 	 */
 	RCU_NONIDLE(tick_unfreeze());
 	start_critical_timings();
+	rcu_idle_exit();
 
 	time_end = ns_to_ktime(local_clock());
 
@@ -228,16 +233,18 @@ int cpuidle_enter_state(struct cpuidle_d
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
-	trace_cpu_idle_rcuidle(index, dev->cpu);
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
+	rcu_idle_enter();
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
+	rcu_idle_exit();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -54,17 +54,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	trace_cpu_idle(0, smp_processor_id());
 	rcu_idle_enter();
-	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
 
 	while (!tif_need_resched() &&
-		(cpu_idle_force_poll || tick_check_broadcast_expired()))
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
+
 	start_critical_timings();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
 	return 1;
 }
@@ -90,9 +91,11 @@ void __cpuidle default_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 	} else {
+		rcu_idle_enter();
 		stop_critical_timings();
 		arch_cpu_idle();
 		start_critical_timings();
+		rcu_idle_exit();
 	}
 }
 
@@ -158,7 +161,6 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		default_idle_call();
 		goto exit_idle;
@@ -178,21 +180,17 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
-			rcu_idle_enter();
 
 			entered_state = call_cpuidle_s2idle(drv, dev);
 			if (entered_state > 0)
 				goto exit_idle;
 
-			rcu_idle_exit();
-
 			max_latency_ns = U64_MAX;
 		} else {
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
 
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
@@ -209,8 +207,6 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		rcu_idle_enter();
-
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
@@ -226,8 +222,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
-
-	rcu_idle_exit();
 }
 
 /*


