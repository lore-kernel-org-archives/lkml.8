Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2528620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgEEOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729527AbgEEOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043BBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKT-0000ho-AT; Tue, 05 May 2020 16:13:49 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 99441FFC8D;
        Tue,  5 May 2020 16:13:48 +0200 (CEST)
Message-Id: <20200505134100.864179229@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [patch V4 part 1 28/36] hardirq/nmi: Allow nested nmi_enter()
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Since there are already a number of sites (ARM64, PowerPC) that effectively
nest nmi_enter(), make the primitive support this before adding even more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/arm64/kernel/sdei.c    |   14 ++------------
 arch/arm64/kernel/traps.c   |    8 ++------
 arch/powerpc/kernel/traps.c |   22 ++++++----------------
 include/linux/hardirq.h     |    5 ++++-
 include/linux/preempt.h     |    4 ++--
 5 files changed, 16 insertions(+), 37 deletions(-)

--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -251,22 +251,12 @@ asmlinkage __kprobes notrace unsigned lo
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
 	unsigned long ret;
-	bool do_nmi_exit = false;
 
-	/*
-	 * nmi_enter() deals with printk() re-entrance and use of RCU when
-	 * RCU believed this CPU was idle. Because critical events can
-	 * interrupt normal events, we may already be in_nmi().
-	 */
-	if (!in_nmi()) {
-		nmi_enter();
-		do_nmi_exit = true;
-	}
+	nmi_enter();
 
 	ret = _sdei_handler(regs, arg);
 
-	if (do_nmi_exit)
-		nmi_exit();
+	nmi_exit();
 
 	return ret;
 }
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -906,17 +906,13 @@ bool arm64_is_fatal_ras_serror(struct pt
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	const bool was_in_nmi = in_nmi();
-
-	if (!was_in_nmi)
-		nmi_enter();
+	nmi_enter();
 
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
-	if (!was_in_nmi)
-		nmi_exit();
+	nmi_exit();
 }
 
 asmlinkage void enter_from_user_mode(void)
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -441,15 +441,9 @@ void hv_nmi_check_nonrecoverable(struct
 void system_reset_exception(struct pt_regs *regs)
 {
 	unsigned long hsrr0, hsrr1;
-	bool nested = in_nmi();
 	bool saved_hsrrs = false;
 
-	/*
-	 * Avoid crashes in case of nested NMI exceptions. Recoverability
-	 * is determined by RI and in_nmi
-	 */
-	if (!nested)
-		nmi_enter();
+	nmi_enter();
 
 	/*
 	 * System reset can interrupt code where HSRRs are live and MSR[RI]=1.
@@ -521,8 +515,7 @@ void system_reset_exception(struct pt_re
 		mtspr(SPRN_HSRR1, hsrr1);
 	}
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
@@ -823,9 +816,8 @@ int machine_check_generic(struct pt_regs
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+
+	nmi_enter();
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
@@ -851,8 +843,7 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		goto bail;
 
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 
 	die("Machine check", regs, SIGBUS);
 
@@ -863,8 +854,7 @@ void machine_check_exception(struct pt_r
 	return;
 
 bail:
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -65,13 +65,16 @@ extern void irq_exit(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+/*
+ * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ */
 #define nmi_enter()						\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
-		BUG_ON(in_nmi());				\
+		BUG_ON(in_nmi() == NMI_MASK);			\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -26,13 +26,13 @@
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00100000
+ *             NMI_MASK:	0x00f00000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	4
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)

