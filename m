Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950CC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067022469C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgBYX0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgBYX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:32 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jag-0004v4-P6; Wed, 26 Feb 2020 00:26:15 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id F028B1040AE;
        Wed, 26 Feb 2020 00:25:45 +0100 (CET)
Message-Id: <20200225224144.911992536@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:29 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 08/16] x86/entry: Implement user mode C entry points for #DB and #MCE
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 arch/x86/entry/entry_64.S      |    2 +-
 arch/x86/kernel/cpu/mce/core.c |   11 +++++++++++
 arch/x86/kernel/traps.c        |   30 ++++++++++++++++++++++--------
 3 files changed, 34 insertions(+), 9 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -646,7 +646,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector \cfunc, has_error_code=0
+	idtentry_body vector noist_\cfunc, has_error_code=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1898,11 +1898,22 @@ static void unexpected_machine_check(str
 /* Call the installed machine check handler for this CPU setup. */
 void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
+/* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
 	machine_check_vector(regs);
 }
 
+#ifdef CONFIG_X86_64
+/*
+ * The user mode variant (same content for now).
+ */
+DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
+{
+	machine_check_vector(regs);
+}
+#endif
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -739,15 +739,13 @@ static bool is_sysenter_singlestep(struc
  *
  * May run on IST stack.
  */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
+static void notrace handle_debug(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 	int user_icebp = 0;
 	unsigned long dr6;
 	int si_code;
 
-	ist_enter(regs);
-
 	get_debugreg(dr6, 6);
 	/*
 	 * The Intel SDM says:
@@ -776,7 +774,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		     is_sysenter_singlestep(regs))) {
 		dr6 &= ~DR_STEP;
 		if (!dr6)
-			goto exit;
+			return;
 		/*
 		 * else we might have gotten a single-step trap and hit a
 		 * watchpoint at the same time, in which case we should fall
@@ -797,12 +795,12 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 
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
@@ -818,7 +816,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
-		goto exit;
+		return;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -837,11 +835,27 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		send_sigtrap(regs, 0, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
+}
+NOKPROBE_SYMBOL(handle_debug);
 
-exit:
+/*
+ * IST stack entry.
+ */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	ist_enter(regs);
+	handle_debug(regs);
 	ist_exit(regs);
 }
 
+#ifdef CONFIG_X86_64
+/* User entry, runs on regular task stack */
+DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
+{
+	handle_debug(regs);
+}
+#endif
+
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
  * the correct behaviour even in the presence of the asynchronous

