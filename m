Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03EC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C51F20838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgEEOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729303AbgEEOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B140C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMi-00027U-93; Tue, 05 May 2020 16:16:08 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C830CFFC8D;
        Tue,  5 May 2020 16:16:07 +0200 (CEST)
Message-Id: <20200505135315.177564104@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:45 +0200
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
Subject: [patch V4 part 4 19/24] x86/entry: Implement user mode C entry points
 for #DB and #MCE
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

The MCE entry point uses the same mechanism as the IST entry point for
now. For #DB split the inner workings and just keep the ist_enter/exit
magic in the IST variant. Fixup the ASM code to emit the proper
noist_##cfunc call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S      |    2 -
 arch/x86/kernel/cpu/mce/core.c |   40 +++++++++++++++++++----
 arch/x86/kernel/traps.c        |   70 +++++++++++++++++++++++++++++++----------
 3 files changed, 88 insertions(+), 24 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -658,7 +658,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector \cfunc, has_error_code=0
+	idtentry_body vector noist_\cfunc, has_error_code=0 sane=1
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,24 +1904,50 @@ static void unexpected_machine_check(str
 /* Call the installed machine check handler for this CPU setup. */
 void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
-DEFINE_IDTENTRY_MCE(exc_machine_check)
+static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	/*
+	 * Only required when from kernel mode. See
+	 * mce_check_crashing_cpu() for details.
+	 */
 	if (machine_check_vector == do_machine_check &&
 	    mce_check_crashing_cpu())
 		return;
 
-	if (user_mode(regs))
-		idtentry_enter(regs);
-	else
-		nmi_enter();
+	nmi_enter();
+	machine_check_vector(regs);
+	nmi_exit();
+}
 
+static __always_inline void exc_machine_check_user(struct pt_regs *regs)
+{
+	idtentry_enter(regs);
 	machine_check_vector(regs);
+	idtentry_exit(regs);
+}
 
+#ifdef CONFIG_X86_64
+/* MCE hit kernel mode */
+DEFINE_IDTENTRY_MCE(exc_machine_check)
+{
+	exc_machine_check_kernel(regs);
+}
+
+/* The user mode variant. */
+DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
+{
+	exc_machine_check_user(regs);
+}
+#else
+/* 32bit unified entry point */
+DEFINE_IDTENTRY_MCE(exc_machine_check)
+{
 	if (user_mode(regs))
-		idtentry_exit(regs);
+		exc_machine_check_user(regs);
 	else
-		nmi_exit();
+		exc_machine_check_kernel(regs);
 }
+#endif
 
 /*
  * Called for each booted CPU to set up machine checks.
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -753,20 +753,12 @@ static __always_inline void debug_exit(u
  *
  * May run on IST stack.
  */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
+static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
-	unsigned long dr6, dr7;
 	int user_icebp = 0;
 	int si_code;
 
-	debug_enter(&dr6, &dr7);
-
-	if (user_mode(regs))
-		idtentry_enter(regs);
-	else
-		nmi_enter();
-
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
@@ -778,7 +770,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		     is_sysenter_singlestep(regs))) {
 		dr6 &= ~DR_STEP;
 		if (!dr6)
-			goto exit;
+			return;
 		/*
 		 * else we might have gotten a single-step trap and hit a
 		 * watchpoint at the same time, in which case we should fall
@@ -799,12 +791,12 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 
 #ifdef CONFIG_KPROBES
 	if (kprobe_debug_handler(regs))
-		goto exit;
+		return;
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP)
-		goto exit;
+		return;
 
 	/*
 	 * Let others (NMI) know that the debug stack is in use
@@ -820,7 +812,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
-		goto exit;
+		return;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -839,14 +831,60 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		send_sigtrap(regs, 0, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
+}
+
+static __always_inline void exc_debug_kernel(struct pt_regs *regs,
+					     unsigned long dr6)
+{
+	nmi_enter();
+	handle_debug(regs, dr6);
+	nmi_exit();
+}
+
+static __always_inline void exc_debug_user(struct pt_regs *regs,
+					   unsigned long dr6)
+{
+	idtentry_enter(regs);
+	handle_debug(regs, dr6);
+	idtentry_exit(regs);
+}
+
+#ifdef CONFIG_X86_64
+/* IST stack entry */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
+	exc_debug_kernel(regs, dr6);
+	debug_exit(dr7);
+}
+
+/* User entry, runs on regular task stack */
+DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
+	exc_debug_user(regs, dr6);
+	debug_exit(dr7);
+}
+#else
+/* 32 bit does not have separate entry points. */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
 
-exit:
 	if (user_mode(regs))
-		idtentry_exit(regs);
+		exc_debug_user(regs, dr6);
 	else
-		nmi_exit();
+		exc_debug_kernel(regs, dr6);
+
 	debug_exit(dr7);
 }
+#endif
 
 /*
  * Note that we play around with the 'TS' bit in an attempt to get

