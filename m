Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30118C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EC920675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgEEOTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730108AbgEEOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMj-00028X-G9; Tue, 05 May 2020 16:16:09 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0D674FFC8D;
        Tue,  5 May 2020 16:16:09 +0200 (CEST)
Message-Id: <20200505135315.283276272@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:46 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 20/24] x86/traps: Restructure #DB handling
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

Now that there are separate entry points, move the kernel/user_mode specifc
checks into the entry functions so the common handling code does not need
the extra mode checks. Make the code more readable while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |   69 ++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -753,39 +753,12 @@ static __always_inline void debug_exit(u
  *
  * May run on IST stack.
  */
-static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
+				 bool user_icebp)
 {
 	struct task_struct *tsk = current;
-	int user_icebp = 0;
 	int si_code;
 
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
-
-	if (unlikely(!user_mode(regs) && (dr6 & DR_STEP) &&
-		     is_sysenter_singlestep(regs))) {
-		dr6 &= ~DR_STEP;
-		if (!dr6)
-			return;
-		/*
-		 * else we might have gotten a single-step trap and hit a
-		 * watchpoint at the same time, in which case we should fall
-		 * through and handle the watchpoint.
-		 */
-	}
-
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	if (!dr6 && user_mode(regs))
-		user_icebp = 1;
-
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
@@ -810,9 +783,7 @@ static noinstr void handle_debug(struct
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
 				 X86_TRAP_DB);
-		cond_local_irq_disable(regs);
-		debug_stack_usage_dec();
-		return;
+		goto out;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -826,9 +797,12 @@ static noinstr void handle_debug(struct
 		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
+
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(regs, 0, si_code);
+
+out:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 }
@@ -837,7 +811,27 @@ static __always_inline void exc_debug_ke
 					     unsigned long dr6)
 {
 	nmi_enter();
-	handle_debug(regs, dr6);
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
+
+	/*
+	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
+	 * watchpoint at the same time then that will still be handled.
+	 */
+	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+		dr6 &= ~DR_STEP;
+
+	/*
+	 * If DR6 is zero, no point in trying to handle it. The kernel is
+	 * not using INT1.
+	 */
+	if (dr6)
+		handle_debug(regs, dr6, false);
+
 	nmi_exit();
 }
 
@@ -845,7 +839,14 @@ static __always_inline void exc_debug_us
 					   unsigned long dr6)
 {
 	idtentry_enter(regs);
-	handle_debug(regs, dr6);
+	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
+
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	handle_debug(regs, dr6, !dr6);
 	idtentry_exit(regs);
 }
 

