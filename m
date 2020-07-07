Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE14C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E2E206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCJxo4T7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IF5ayT+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGGIXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:23:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:23:43 -0400
Date:   Tue, 07 Jul 2020 08:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594110219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aJxtSkQFjlSQ/pbp1RTO99oPx6lUie8QyRW1KQh+Fw=;
        b=aCJxo4T7oIgCTWKVaao1ivvrzxWiTfXDtf6DG7C/YvTih73V+vWloGvQmXmtDw2nW3B/r6
        hjNs0YNLuFUMlTq+fMkp60C3lg0mjlQZPdaowgKFd3ECxRP6SbEdzR1tN58nGKl5CEuw6u
        ZhTisoFiCzZOJWToC/B/D1RFNr1GivnCEkEzVfEc8BR8uWpeY+TMIF6EuSi9Nv07xuTSHq
        FEmSnPSguzPiCyTi8YgLjSqpLPgNXZz+WejVmMcjCCfmosykcgbHIwzm343h+l4lmQ+PrP
        q+vZOZVqFtHZw6EorSPpCHqTB5ReQ7FNQvEoko4tvFsAzz6f7K3b6iyclXrg/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594110219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aJxtSkQFjlSQ/pbp1RTO99oPx6lUie8QyRW1KQh+Fw=;
        b=IF5ayT+Yr8oxbQitpstt72icOq4JIioW4izk90rKQZSonUnxJqBj6eae8NGTXqxUMpHP/U
        +TD1uwqSk2nGd3CQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Rename idtentry_enter/exit_cond_rcu() to
 idtentry_enter/exit()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <247fc67685263e0b673e1d7f808182d28ff80359.1593795633.git.luto@kernel.org>
References: <247fc67685263e0b673e1d7f808182d28ff80359.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159411021855.4006.13113751062324360868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     b037b09b9058d84882fa2c4db3806433e2b0f912
Gitweb:        https://git.kernel.org/tip/b037b09b9058d84882fa2c4db3806433e2b0f912
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:58 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Jul 2020 21:15:52 +02:00

x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()

They were originally called _cond_rcu because they were special versions
with conditional RCU handling.  Now they're the standard entry and exit
path, so the _cond_rcu part is just confusing.  Drop it.

Also change the signature to make them more extensible and more foolproof.

No functional change -- it's pure refactoring.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/247fc67685263e0b673e1d7f808182d28ff80359.1593795633.git.luto@kernel.org

---
 arch/x86/entry/common.c         | 50 +++++++++++++++++---------------
 arch/x86/include/asm/idtentry.h | 28 ++++++++++--------
 arch/x86/kernel/kvm.c           |  6 ++--
 arch/x86/kernel/traps.c         |  6 ++--
 arch/x86/mm/fault.c             |  6 ++--
 5 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e83b3f1..0521546 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -559,8 +559,7 @@ SYSCALL_DEFINE0(ni_syscall)
 }
 
 /**
- * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
- *			     RCU handling
+ * idtentry_enter - Handle state tracking on ordinary idtentries
  * @regs:	Pointer to pt_regs of interrupted context
  *
  * Invokes:
@@ -572,6 +571,9 @@ SYSCALL_DEFINE0(ni_syscall)
  *  - The hardirq tracer to keep the state consistent as low level ASM
  *    entry disabled interrupts.
  *
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
+ *
  * For kernel mode entries RCU handling is done conditional. If RCU is
  * watching then the only RCU requirement is to check whether the tick has
  * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
@@ -585,18 +587,21 @@ SYSCALL_DEFINE0(ni_syscall)
  * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
  * would not be possible.
  *
- * Returns: True if RCU has been adjusted on a kernel entry
- *	    False otherwise
+ * Returns: An opaque object that must be passed to idtentry_exit()
  *
- * The return value must be fed into the rcu_exit argument of
- * idtentry_exit_cond_rcu().
+ * The return value must be fed into the state argument of
+ * idtentry_exit().
  */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
+idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
 {
+	idtentry_state_t ret = {
+		.exit_rcu = false,
+	};
+
 	if (user_mode(regs)) {
 		check_user_regs(regs);
 		enter_from_user_mode();
-		return false;
+		return ret;
 	}
 
 	/*
@@ -634,7 +639,8 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
-		return true;
+		ret.exit_rcu = true;
+		return ret;
 	}
 
 	/*
@@ -649,7 +655,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 	trace_hardirqs_off();
 	instrumentation_end();
 
-	return false;
+	return ret;
 }
 
 static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
@@ -667,10 +673,9 @@ static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
 }
 
 /**
- * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
- *			    handling
+ * idtentry_exit - Handle return from exception that used idtentry_enter()
  * @regs:	Pointer to pt_regs (exception entry regs)
- * @rcu_exit:	Invoke rcu_irq_exit() if true
+ * @state:	Return value from matching call to idtentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
  * preemption and work checks if possible and reguired and returns to
@@ -679,10 +684,10 @@ static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
  * This is the last action before returning to the low level ASM code which
  * just needs to return to the appropriate context.
  *
- * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
- * function must be fed into the @rcu_exit argument.
+ * Counterpart to idtentry_enter(). The return value of the entry
+ * function must be fed into the @state argument.
  */
-void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
+void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -695,7 +700,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 		 * carefully and needs the same ordering of lockdep/tracing
 		 * and RCU as the return to user mode path.
 		 */
-		if (rcu_exit) {
+		if (state.exit_rcu) {
 			instrumentation_begin();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
@@ -714,7 +719,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.
 		 */
-		if (rcu_exit)
+		if (state.exit_rcu)
 			rcu_irq_exit();
 	}
 }
@@ -800,9 +805,10 @@ static void __xen_pv_evtchn_do_upcall(void)
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	bool inhcall, rcu_exit;
+	bool inhcall;
+	idtentry_state_t state;
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = idtentry_enter(regs);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -812,13 +818,13 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 
 	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(rcu_exit)) {
+	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
 		instrumentation_begin();
 		idtentry_exit_cond_resched(regs, true);
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		idtentry_exit_cond_rcu(regs, rcu_exit);
+		idtentry_exit(regs, state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index eeac6dc..7227225 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,8 +13,12 @@
 void idtentry_enter_user(struct pt_regs *regs);
 void idtentry_exit_user(struct pt_regs *regs);
 
-bool idtentry_enter_cond_rcu(struct pt_regs *regs);
-void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
+typedef struct idtentry_state {
+	bool exit_rcu;
+} idtentry_state_t;
+
+idtentry_state_t idtentry_enter(struct pt_regs *regs);
+void idtentry_exit(struct pt_regs *regs, idtentry_state_t state);
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
@@ -54,12 +58,12 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	idtentry_state_t state = idtentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	idtentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -101,12 +105,12 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	idtentry_state_t state = idtentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	idtentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -199,7 +203,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	idtentry_state_t state = idtentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -207,7 +211,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	idtentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -241,7 +245,7 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	idtentry_state_t state = idtentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -249,7 +253,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	idtentry_exit(regs, state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -270,7 +274,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	idtentry_state_t state = idtentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
@@ -278,7 +282,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	idtentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df63786..3f78482 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 reason = kvm_read_and_reset_apf_flags();
-	bool rcu_exit;
+	idtentry_state_t state;
 
 	switch (reason) {
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
@@ -243,7 +243,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 	}
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = idtentry_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	}
 
 	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	idtentry_exit(regs, state);
 	return true;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b038695..4627f82 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -245,7 +245,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	bool rcu_exit;
+	idtentry_state_t state;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -255,11 +255,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = idtentry_enter(regs);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	idtentry_exit(regs, state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ead568..5e41949 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1377,7 +1377,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
-	bool rcu_exit;
+	idtentry_state_t state;
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1412,11 +1412,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = idtentry_enter(regs);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	idtentry_exit(regs, state);
 }
