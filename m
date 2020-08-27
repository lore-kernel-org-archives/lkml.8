Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B2820825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIQ2GTEg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5cntnkre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgH0H4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgH0Hya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:30 -0400
Date:   Thu, 27 Aug 2020 07:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWOu4hP2h1wGfItCLjMQCdGhGH+38NihvXknOuOLnjQ=;
        b=BIQ2GTEgmmeS/Y6jRfhAFyDSapZyedS4UYOBVje50wUqZ3NadDaBOEbr9eIX7ThXzFPJFB
        j0tImToGqBsxSot90Z4dsl7Lsyrbeshw4wVWiU988dFXuJYOhJIE9hhtlVm2Tx/gFKQUXb
        2X1wxJWkOyYkKE6ds7eukiRQXzahWZoZBX0XTvioyScH8UCht6LU0VRqiNo2DE65sg3bUG
        9MQjJ8UaluhUfY2nJD4V8vpppb0bsK5b/FQ4dRZc6AbgQZI0wauFv8tDkguWuACr631gOE
        0QeJHO4J69F9ldBdxxhnoLNz072uzTCNcFOjbaPPGMXq5DNyk8iQMtJ7/Bnwtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWOu4hP2h1wGfItCLjMQCdGhGH+38NihvXknOuOLnjQ=;
        b=5cntnkre53U4hXct43waSgrYN2aJLC5ZADFZ3ulDQarXPpJGkN/CfIEC2o2JUiV4Tt1jYu
        pk0YTuT7W4BLIBBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cpuidle: Move trace_cpu_idle() into generic code
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.428433395@infradead.org>
References: <20200821085348.428433395@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486723.20229.13788902080977664669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9864f5b5943ab0f1f835f21dc3f9f068d06f5b52
Gitweb:        https://git.kernel.org/tip/9864f5b5943ab0f1f835f21dc3f9f068d06f5b52
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Aug 2020 12:27:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:54 +02:00

cpuidle: Move trace_cpu_idle() into generic code

Remove trace_cpu_idle() from the arch_cpu_idle() implementations and
put it in the generic code, right before disabling RCU. Gets rid of
more trace_*_rcuidle() users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.428433395@infradead.org
---
 arch/arm/mach-omap2/pm34xx.c | 4 ----
 arch/arm64/kernel/process.c  | 2 --
 arch/s390/kernel/idle.c      | 3 +--
 arch/x86/kernel/process.c    | 4 ----
 kernel/sched/idle.c          | 3 +++
 5 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6df395f..f5dfddf 100644
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
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b63ce4c..f180449 100644
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
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 88bb42c..c73f506 100644
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
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 994d839..13ce616 100644
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
@@ -792,7 +790,6 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
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
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ea3a098..f324dc3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -91,11 +91,14 @@ void __cpuidle default_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 	} else {
+
+		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
 		rcu_idle_enter();
 		arch_cpu_idle();
 		rcu_idle_exit();
 		start_critical_timings();
+		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
 }
 
