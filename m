Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA032075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4pEPgZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391058AbgE1ORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390996AbgE1ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFFC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HhRz+E67wqZLX9Kj0h1J/Z/3Uz9wGLyqpa654HVNs3o=; b=T4pEPgZDlX8IgucK0JkJFDw24W
        0ofDvbDK7EJnWjXf3+82n0Iu5O2/uOrPTCTxsm99iQ+qu7MBopvqXZ6k0odtjS9LMtSyAaHUDeRqt
        qnMVuy/e98JUHcs4Av9BiPkxRVyy/eeBtxOZREn0SRYkbTAUZbruZ0n0FJFhQEGbCD+TGBa5sFvrF
        ZQT8k/kN92vcwwe6EgdE85cZf/rZN9gsguO7kR8is+Vd1yXto1/SkrORVlSWhAlVlB8Av+ftb/MIv
        A2fBMhdXgw95P9jp1PA3jkw5gwgQY87dOFuM7rv+g5DzaJ8BkDNhK8oyIyXUIsC0/V/2Oc9W3nND4
        PvQcR29w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJLI-0007a4-QT; Thu, 28 May 2020 14:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A24530704D;
        Thu, 28 May 2020 16:17:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E63002B9FB570; Thu, 28 May 2020 16:17:06 +0200 (CEST)
Message-ID: <20200528140947.035164777@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 16:05:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH v2 6/6] x86/entry: Fix NMI vs IRQ state tracking
References: <20200528140535.206916549@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the nmi_enter() users did
trace_hardirqs_{off_prepare,on_finish}() there was no matching
lockdep_hardirqs_*() calls to complete the picture.

Introduce idtentry_{enter,exit}_nmi() to enable proper IRQ state
tracking across the NMIs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c         |   42 ++++++++++++++++++++++++++++++++++++----
 arch/x86/include/asm/idtentry.h |    3 ++
 arch/x86/kernel/nmi.c           |    9 +++-----
 arch/x86/kernel/traps.c         |   20 ++++---------------
 include/linux/hardirq.h         |   28 ++++++++++++++++++--------
 5 files changed, 69 insertions(+), 33 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -550,7 +550,7 @@ SYSCALL_DEFINE0(ni_syscall)
  * The return value must be fed into the rcu_exit argument of
  * idtentry_exit_cond_rcu().
  */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
+noinstr bool idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
@@ -619,7 +619,7 @@ static void idtentry_exit_cond_resched(s
  * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
  * function must be fed into the @rcu_exit argument.
  */
-void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
+noinstr void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -663,7 +663,7 @@ void noinstr idtentry_exit_cond_rcu(stru
  * Invokes enter_from_user_mode() to establish the proper context for
  * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
  */
-void noinstr idtentry_enter_user(struct pt_regs *regs)
+noinstr void idtentry_enter_user(struct pt_regs *regs)
 {
 	enter_from_user_mode();
 }
@@ -680,13 +680,47 @@ void noinstr idtentry_enter_user(struct
  *
  * Counterpart to idtentry_enter_user().
  */
-void noinstr idtentry_exit_user(struct pt_regs *regs)
+noinstr void idtentry_exit_user(struct pt_regs *regs)
 {
 	lockdep_assert_irqs_disabled();
 
 	prepare_exit_to_usermode(regs);
 }
 
+noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
+{
+	bool irq_state = lockdep_hardirqs_enabled();
+
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
+	instrumentation_end();
+
+	return irq_state;
+}
+
+noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
+{
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (restore) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (restore)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
+}
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -16,6 +16,9 @@ void idtentry_exit_user(struct pt_regs *
 bool idtentry_enter_cond_rcu(struct pt_regs *regs);
 void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 
+bool idtentry_enter_nmi(struct pt_regs *regs);
+void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,7 +330,6 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -417,8 +416,6 @@ static noinstr void default_do_nmi(struc
 		unknown_nmi_error(reason, regs);
 
 out:
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
@@ -511,6 +508,8 @@ static noinstr bool is_debug_stack(unsig
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
+	bool irq_state;
+
 	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
 		return;
 
@@ -535,14 +534,14 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 	}
 #endif
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -387,7 +387,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	nmi_enter();
+	idtentry_enter_nmi(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -632,15 +632,12 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		idtentry_exit_user(regs);
 	} else {
-		nmi_enter();
+		bool irq_state = idtentry_enter_nmi(regs);
 		instrumentation_begin();
-		trace_hardirqs_off_finish();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
 		instrumentation_end();
-		nmi_exit();
+		idtentry_exit_nmi(regs, irq_state);
 	}
 }
 
@@ -852,10 +849,7 @@ static void noinstr handle_debug(struct
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
-	nmi_enter();
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	instrumentation_end();
+	bool irq_state = idtentry_enter_nmi(regs);
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
@@ -878,11 +872,7 @@ static __always_inline void exc_debug_ke
 	if (dr6)
 		handle_debug(regs, dr6, false);
 
-	instrumentation_begin();
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
-	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -111,32 +111,42 @@ extern void rcu_nmi_exit(void);
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
-#define nmi_enter()						\
+#define __nmi_enter()						\
 	do {							\
+		lockdep_off();					\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
-		lockdep_off();					\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		rcu_nmi_enter();				\
+	} while (0)
+
+#define nmi_enter()						\
+	do {							\
+		__nmi_enter();					\
 		lockdep_hardirq_enter();			\
+		rcu_nmi_enter();				\
 		instrumentation_begin();			\
 		ftrace_nmi_enter();				\
 		instrumentation_end();				\
 	} while (0)
 
+#define __nmi_exit()						\
+	do {							\
+		BUG_ON(!in_nmi());				\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		printk_nmi_exit();				\
+		arch_nmi_exit();				\
+		lockdep_on();					\
+	} while (0)
+
 #define nmi_exit()						\
 	do {							\
 		instrumentation_begin();			\
 		ftrace_nmi_exit();				\
 		instrumentation_end();				\
-		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
-		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		lockdep_on();					\
-		printk_nmi_exit();				\
-		arch_nmi_exit();				\
+		lockdep_hardirq_exit();				\
+		__nmi_exit();					\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */


