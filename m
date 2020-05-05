Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3992720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgEEOQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730084AbgEEOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMd-00023Z-Az; Tue, 05 May 2020 16:16:03 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D2F75FFC8D;
        Tue,  5 May 2020 16:16:02 +0200 (CEST)
Message-Id: <20200505135314.808628211@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:41 +0200
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
References: <20200505134926.578885807@linutronix.de>
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

DR6/7 should be handled before nmi_enter() is invoked and restore after
nmi_exit() to minimize the exposure.

Split it out into helper inlines and bring it into the correct order.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hw_breakpoint.c |    6 ---
 arch/x86/kernel/traps.c         |   62 +++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -464,7 +464,7 @@ static int hw_breakpoint_handler(struct
 {
 	int i, cpu, rc = NOTIFY_STOP;
 	struct perf_event *bp;
-	unsigned long dr7, dr6;
+	unsigned long dr6;
 	unsigned long *dr6_p;
 
 	/* The DR6 value is pointed by args->err */
@@ -479,9 +479,6 @@ static int hw_breakpoint_handler(struct
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
 
-	get_debugreg(dr7, 7);
-	/* Disable breakpoints during exception handling */
-	set_debugreg(0UL, 7);
 	/*
 	 * Assert that local interrupts are disabled
 	 * Reset the DRn bits in the virtualized register value.
@@ -538,7 +535,6 @@ static int hw_breakpoint_handler(struct
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
-	set_debugreg(dr7, 7);
 	put_cpu();
 
 	return rc;
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -691,6 +691,44 @@ static bool is_sysenter_singlestep(struc
 #endif
 }
 
+static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
+{
+	/*
+	 * Disable breakpoints during exception handling; recursive exceptions
+	 * are exceedingly 'fun'.
+	 *
+	 * Since this function is NOKPROBE, and that also applies to
+	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
+	 * HW_BREAKPOINT_W on our stack)
+	 *
+	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
+	 * includes the entry stack is excluded for everything.
+	 */
+	get_debugreg(*dr7, 6);
+	set_debugreg(0, 7);
+
+	/*
+	 * The Intel SDM says:
+	 *
+	 *   Certain debug exceptions may clear bits 0-3. The remaining
+	 *   contents of the DR6 register are never cleared by the
+	 *   processor. To avoid confusion in identifying debug
+	 *   exceptions, debug handlers should clear the register before
+	 *   returning to the interrupted task.
+	 *
+	 * Keep it simple: clear DR6 immediately.
+	 */
+	get_debugreg(*dr6, 6);
+	set_debugreg(0, 6);
+	/* Filter out all the reserved bits which are preset to 1 */
+	*dr6 &= ~DR6_RESERVED;
+}
+
+static __always_inline void debug_exit(unsigned long dr7)
+{
+	set_debugreg(dr7, 7);
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -718,28 +756,13 @@ static bool is_sysenter_singlestep(struc
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 {
 	struct task_struct *tsk = current;
+	unsigned long dr6, dr7;
 	int user_icebp = 0;
-	unsigned long dr6;
 	int si_code;
 
-	nmi_enter();
-
-	get_debugreg(dr6, 6);
-	/*
-	 * The Intel SDM says:
-	 *
-	 *   Certain debug exceptions may clear bits 0-3. The remaining
-	 *   contents of the DR6 register are never cleared by the
-	 *   processor. To avoid confusion in identifying debug
-	 *   exceptions, debug handlers should clear the register before
-	 *   returning to the interrupted task.
-	 *
-	 * Keep it simple: clear DR6 immediately.
-	 */
-	set_debugreg(0, 6);
+	debug_enter(&dr6, &dr7);
 
-	/* Filter out all the reserved bits which are preset to 1 */
-	dr6 &= ~DR6_RESERVED;
+	nmi_enter();
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
@@ -777,7 +800,7 @@ dotraplinkage void do_debug(struct pt_re
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
-							SIGTRAP) == NOTIFY_STOP)
+		       SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
 	/*
@@ -816,6 +839,7 @@ dotraplinkage void do_debug(struct pt_re
 
 exit:
 	nmi_exit();
+	debug_exit(dr7);
 }
 NOKPROBE_SYMBOL(do_debug);
 

