Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAEDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58242076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zFxpgwgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHTHuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=v47MbcvDJZ6W0Z2c6u2+MRLrs6DU6fm7/sxoK9nVoyc=; b=zFxpgwggyDhS1CMd9yW6+LbTjy
        icUL/7bFY7Ss5aksbtnGN2EV8a+LHP1Z/5d86iRB9Auke4Aw8w5NEif1U5sqP/RuiBCD1HTgLiF0S
        9b3heSQWQncOBS9oCcD8rnLsZdr7nRD/UNa6ryjS/pagkvtyDIF8QXWksHy9mPEXs1I5YHRSjWsi7
        Pheis6yFHv+IuqjQsG6/5CzAP08fTxlzjqyrteszH/Zj/KNYBgRtqhKmeHLAGWFZoDySnURn+d0MK
        ZyJkeJLhrphuKyk3+09YJ+lyxgTXy34T8x5ZqPp1VCvigBLnWJWFZLHekZolC9brQIeNkR5+GuB3l
        ii2Bk+Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKW-0007DJ-2E; Thu, 20 Aug 2020 07:49:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 756E0305E21;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 621F328B7E844; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.518692200@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH 4/9] cpuidle: Move trace_cpu_idle() into generic code
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trace_cpu_idle() from the arch_cpu_idle() implementations and
put it in the generic code, right before disabling RCU. Gets rid of
more trace_*_rcuidle() users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 arch/arm64/kernel/process.c  |    2 --
 arch/s390/kernel/idle.c      |    3 +--
 arch/x86/kernel/process.c    |    4 ----
 kernel/sched/idle.c          |    3 +++
 5 files changed, 4 insertions(+), 12 deletions(-)

--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -298,11 +298,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
-
 	omap_sram_idle();
-
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_SUSPEND
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -123,10 +123,8 @@ void arch_cpu_idle(void)
 	 * This should do all the clock switching and wait for interrupt
 	 * tricks
 	 */
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	cpu_do_idle();
 	local_irq_enable();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -33,14 +33,13 @@ void enabled_wait(void)
 		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	clear_cpu_flag(CIF_NOHZ_DELAY);
 
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	local_irq_save(flags);
 	/* Call the assembler magic in entry.S */
 	psw_idle(idle, psw_mask);
 	local_irq_restore(flags);
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
+	/* XXX seqcount has tracepoints that require RCU */
 	write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -684,9 +684,7 @@ void arch_cpu_idle(void)
  */
 void __cpuidle default_idle(void)
 {
-	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	safe_halt();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -792,7 +790,6 @@ static int prefer_mwait_c1_over_halt(con
 static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
-		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
 			mb(); /* quirk */
 			clflush((void *)&current_thread_info()->flags);
@@ -804,7 +801,6 @@ static __cpuidle void mwait_idle(void)
 			__sti_mwait(0, 0);
 		else
 			local_irq_enable();
-		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	} else {
 		local_irq_enable();
 	}
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -91,11 +91,14 @@ void __cpuidle default_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 	} else {
+
+		trace_cpu_idle(1, smp_processor_id());
 		rcu_idle_enter();
 		stop_critical_timings();
 		arch_cpu_idle();
 		start_critical_timings();
 		rcu_idle_exit();
+		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
 }
 


